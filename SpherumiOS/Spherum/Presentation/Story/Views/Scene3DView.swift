//
//  Scene3DView.swift
//  Spherum3DScanner
//
//  Created by Artem Eremeev on 08.07.2021.
//

import MetalKit
import Foundation

class Scene3DView: MTKView {
    
    // MARK: METAL
    private var commandQueue: MTLCommandQueue!
    private var renderPipelineState: MTLRenderPipelineState!
    private var depthStencilState: MTLDepthStencilState!
    
    private var depthTextureCache: CVMetalTextureCache!
    private var colorTextureCache: CVMetalTextureCache!
    // MARK: END METAL
    
    private var depthVideoReader: DepthVideoReader!
    
    override init(frame frameRect: CGRect, device: MTLDevice?) {
        super.init(frame: frameRect, device: device)
        self.setup()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }
    
    func play(fileGroup: FileGroup) {
        do {
            self.depthVideoReader = try DepthVideoReader(fileGroup: fileGroup)
        } catch let error {
            print("ERROR:", error.localizedDescription)
        }
    }
    
    
}

extension Scene3DView: MTKViewDelegate {
    
    func draw(in view: MTKView) {
        
        guard let sample = self.depthVideoReader?.extractNextSample() else {
            return
        }
        
        let depthData = sample.1
        
        let colorBuffer = sample.0
        let depthBuffer = depthData.depthDataMap
        
        var cvDepthTexture: CVMetalTexture!
        
        if (kCVReturnSuccess != CVMetalTextureCacheCreateTextureFromImage(kCFAllocatorDefault,
                                                                          self.depthTextureCache,
                                                                          depthBuffer,
                                                                          nil,
                                                                          .r16Float,
                                                                          CVPixelBufferGetWidth(depthBuffer),
                                                                          CVPixelBufferGetHeight(depthBuffer),
                                                                          0,
                                                                          &cvDepthTexture)) {
            print("FAILED TO CREATE DEPTH TEXTURE")
            return
        }
        let depthTexture = CVMetalTextureGetTexture(cvDepthTexture)
        
        var cvColorTexture: CVMetalTexture!
        
        if (kCVReturnSuccess != CVMetalTextureCacheCreateTextureFromImage(kCFAllocatorDefault,
                                                                          self.colorTextureCache,
                                                                          colorBuffer,
                                                                          nil,
                                                                          .rgba8Unorm,
                                                                          CVPixelBufferGetWidth(colorBuffer),
                                                                          CVPixelBufferGetHeight(colorBuffer),
                                                                          0,
                                                                          &cvColorTexture)) {
            print("FAILED TO CREATE COLOR TEXTURE")
            return
        }
        let colorTexture = CVMetalTextureGetTexture(cvColorTexture)
        
        var intrinsics = depthData.cameraCalibrationData!.intrinsicMatrix
        let referenceDimensions = depthData.cameraCalibrationData!.intrinsicMatrixReferenceDimensions
        
        let ratio = Float(referenceDimensions.width) / Float(CVPixelBufferGetWidth(depthBuffer))
        intrinsics.columns.0[0] /= ratio
        intrinsics.columns.1[1] /= ratio
        intrinsics.columns.2[0] /= ratio
        intrinsics.columns.2[1] /= ratio
        
        let commandBuffer = commandQueue.makeCommandBuffer()
        
        guard let renderPassDescriptor = self.currentRenderPassDescriptor else {
            return
        }
        
        let depthTextureDescriptor = MTLTextureDescriptor()
        depthTextureDescriptor.width = Int(self.drawableSize.width)
        depthTextureDescriptor.height = Int(self.drawableSize.height)
        depthTextureDescriptor.pixelFormat = .depth32Float
        depthTextureDescriptor.usage = .renderTarget
        
        let depthTestTexture = self.device!.makeTexture(descriptor: depthTextureDescriptor)
        
        renderPassDescriptor.depthAttachment.loadAction = .clear
        renderPassDescriptor.depthAttachment.storeAction = .store
        renderPassDescriptor.depthAttachment.clearDepth = 1.0
        renderPassDescriptor.depthAttachment.texture = depthTestTexture
        
        let renderEncoder = commandBuffer!.makeRenderCommandEncoder(descriptor: renderPassDescriptor)!
        renderEncoder.setDepthStencilState(self.depthStencilState)
        renderEncoder.setRenderPipelineState(self.renderPipelineState)
        
        renderEncoder.setVertexTexture(depthTexture, index: 0)
        
//        let finalViewMatrix = self.matrix
    }
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        
    }
    
}

private extension Scene3DView {
    
    private func setup() {
        self.device = MTLCreateSystemDefaultDevice()
        self.delegate = self
        
        self.commandQueue = self.device?.makeCommandQueue()
        
        self.preferredFramesPerSecond = 30
        
        self.isPaused = false
        self.enableSetNeedsDisplay = false

        self.clearColor = MTLClearColorMake(0.0, 0.0, 0.0, 1.0)
    }
    
    
}
