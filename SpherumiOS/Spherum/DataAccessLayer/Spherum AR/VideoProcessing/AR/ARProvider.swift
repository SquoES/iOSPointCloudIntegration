import Foundation
import ARKit
import Accelerate
import MetalPerformanceShaders

final class ARProvider: ARDataReceiver {
    
    private let upscaledWidth = 960
    private let upscaledHeight = 760

    private let origDepthWidth = 256
    private let origDepthHeight = 192

    private let origColorWidth = 1920
    private let origColorHeight = 1440
    
    private let guidedFilterEpsilon: Float = 0.004
    private let guidedFilterKernelDiameter = 5
    
//    private let arReceiver: ARReceiver
    private let metalDevice: MTLDevice
    private let guidedFilter: MPSImageGuidedFilter?
    private let mpsScaleFilter: MPSImageBilinearScale?
    private let commandQueue: MTLCommandQueue?
    private let pipelineStateCompute: MTLComputePipelineState?
    private var textureCache: CVMetalTextureCache?
    
    let depthContent = MetalTextureContent()
    let confidenceContent = MetalTextureContent()
    let colorYContent = MetalTextureContent()
    let colorCbCrContent = MetalTextureContent()
    let upscaledCoef = MetalTextureContent()
    let downscaledRGB = MetalTextureContent()
    let upscaledConfidence = MetalTextureContent()
    
    let coefTexture: MTLTexture
    let destDepthTexture: MTLTexture
    let destConfTexture: MTLTexture
    let colorRGBTexture: MTLTexture
    let colorRGBTextureDownscaled: MTLTexture
    let colorRGBTextureDownscaledLowRes: MTLTexture
    
    var onNewARData: ((ARData) -> Void)? = nil
    
    private(set) var lastArData: ARData? {
        didSet {
            if let arData = lastArData {
                onNewARData?(arData)
            }
        }
    }
    
//    public var isToUpsampleDepth: Bool = true {
//        didSet {
//            processLastArData()
//        }
//    }
//
//    public var isUseSmoothedDepthForUpsampling: Bool = true {
//        didSet {
//            processLastArData()
//        }
//    }
    
    init() throws {
        
//        arReceiver = ARReceiver()
        
        metalDevice = MTLCreateSystemDefaultDevice()!
        
        CVMetalTextureCacheCreate(nil, nil, metalDevice, nil, &textureCache)
        
        guidedFilter = MPSImageGuidedFilter(device: metalDevice, kernelDiameter: guidedFilterKernelDiameter)
        guidedFilter?.epsilon = guidedFilterEpsilon
        
        mpsScaleFilter = MPSImageBilinearScale(device: metalDevice)
        
        commandQueue = metalDevice.makeCommandQueue()
        
        let lib = metalDevice.makeDefaultLibrary()!
        let convertYUV2RGBFunc = lib.makeFunction(name: "convertYCbCrToRGBA")!
        pipelineStateCompute = try metalDevice.makeComputePipelineState(function: convertYUV2RGBFunc)
        
        coefTexture = Self.createTexture(metalDevice: metalDevice,
                                         width: origDepthWidth,
                                         height: origDepthHeight,
                                         usage: [.shaderRead, .shaderWrite],
                                         pixelFormat: .rgba32Float)
        
        destDepthTexture = Self.createTexture(metalDevice: metalDevice,
                                              width: upscaledWidth,
                                              height: upscaledHeight,
                                              usage: [.shaderRead, .shaderWrite],
                                              pixelFormat: .r32Float)
        
        destConfTexture = Self.createTexture(metalDevice: metalDevice,
                                             width: upscaledWidth,
                                             height: upscaledHeight,
                                             usage: [.shaderRead, .shaderWrite],
                                             pixelFormat: .r8Unorm)
        
        colorRGBTexture = Self.createTexture(metalDevice: metalDevice,
                                             width: origColorWidth,
                                             height: origColorHeight,
                                             usage: [.shaderRead, .shaderWrite],
                                             pixelFormat: .rgba32Float)
        
        colorRGBTextureDownscaled = Self.createTexture(metalDevice: metalDevice,
                                                       width: upscaledWidth,
                                                       height: upscaledHeight,
                                                       usage: [.shaderRead, .shaderWrite],
                                                       pixelFormat: .rgba32Float)
        
        colorRGBTextureDownscaledLowRes = Self.createTexture(metalDevice: metalDevice,
                                                             width: origDepthWidth,
                                                             height: origDepthHeight,
                                                             usage: [.shaderRead, .shaderWrite],
                                                             pixelFormat: .rgba32Float)
        
        upscaledCoef.texture = coefTexture
        upscaledConfidence.texture = destConfTexture
        downscaledRGB.texture = colorRGBTextureDownscaled
        
//        arReceiver.delegate = self
    }
    
//    func start() {
//        arReceiver.start()
//    }
//
//    func pause() {
//        arReceiver.pause()
//    }
    
    func onNewARData(arData: ARData) {
        lastArData = arData
        processLastArData()
    }
    
}

private extension ARProvider {
    
    private func processLastArData() {
        colorYContent.texture = lastArData?.colorImage?.texture(withFormat: .r8Unorm, planeIndex: 0, addToCache: textureCache!)!
        colorCbCrContent.texture = lastArData?.colorImage?.texture(withFormat: .rg8Unorm, planeIndex: 1, addToCache: textureCache!)!
        
//        if isUseSmoothedDepthForUpsampling {
        
            depthContent.texture = lastArData?.depthSmoothImage?.texture(withFormat: .r32Float, planeIndex: 0, addToCache: textureCache!)!
            confidenceContent.texture = lastArData?.confidenceSmoothImage?.texture(withFormat: .r8Unorm, planeIndex: 0, addToCache: textureCache!)!
            
//        } else {
//            depthContent.texture = lastArData?.depthImage?.texture(withFormat: .r32Float, planeIndex: 0, addToCache: textureCache!)!
//            confidenceContent.texture = lastArData?.confidenceImage?.texture(withFormat: .r8Unorm, planeIndex: 0, addToCache: textureCache!)!
//            
//        }
        
//        if isToUpsampleDepth {
            guard let commandQueue = commandQueue else { return }
            guard let cmdBuffer = commandQueue.makeCommandBuffer() else { return }
            guard let computeEncoder = cmdBuffer.makeComputeCommandEncoder() else { return }
            
            computeEncoder.setComputePipelineState(pipelineStateCompute!)
            computeEncoder.setTexture(colorYContent.texture, index: 0)
            computeEncoder.setTexture(colorCbCrContent.texture, index: 1)
            computeEncoder.setTexture(colorRGBTexture, index: 2)
            let threadgroupSize = MTLSizeMake(pipelineStateCompute!.threadExecutionWidth,
                                              pipelineStateCompute!.maxTotalThreadsPerThreadgroup / pipelineStateCompute!.threadExecutionWidth, 1)
            let threadgroupCount = MTLSize(width: Int(ceil(Float(colorRGBTexture.width) / Float(threadgroupSize.width))),
                                           height: Int(ceil(Float(colorRGBTexture.height) / Float(threadgroupSize.height))),
                                           depth: 1)
            computeEncoder.dispatchThreadgroups(threadgroupCount, threadsPerThreadgroup: threadgroupSize)
            computeEncoder.endEncoding()
            
            mpsScaleFilter?.encode(commandBuffer: cmdBuffer,
                                   sourceTexture: colorRGBTexture,
                                   destinationTexture: colorRGBTextureDownscaled)
            mpsScaleFilter?.encode(commandBuffer: cmdBuffer,
                                   sourceTexture: colorRGBTexture,
                                   destinationTexture: colorRGBTextureDownscaledLowRes)
            
            mpsScaleFilter?.encode(commandBuffer: cmdBuffer,
                                   sourceTexture: confidenceContent.texture!,
                                   destinationTexture: destConfTexture)
            
            guidedFilter?.encodeRegression(to: cmdBuffer,
                                           sourceTexture: depthContent.texture!,
                                           guidanceTexture: colorRGBTextureDownscaledLowRes,
                                           weightsTexture: nil,
                                           destinationCoefficientsTexture: coefTexture)
            
            guidedFilter?.encodeReconstruction(to: cmdBuffer,
                                               guidanceTexture: colorRGBTextureDownscaled,
                                               coefficientsTexture: coefTexture,
                                               destinationTexture: destDepthTexture)
            cmdBuffer.commit()
            
            depthContent.texture = destDepthTexture
//        }
    }
    
    static func createTexture(metalDevice: MTLDevice, width: Int, height: Int, usage: MTLTextureUsage, pixelFormat: MTLPixelFormat) -> MTLTexture {
        let descriptor: MTLTextureDescriptor = MTLTextureDescriptor()
        descriptor.pixelFormat = pixelFormat
        descriptor.width = width
        descriptor.height = height
        descriptor.usage = usage
        let resTexture = metalDevice.makeTexture(descriptor: descriptor)
        return resTexture!
    }
    
}
