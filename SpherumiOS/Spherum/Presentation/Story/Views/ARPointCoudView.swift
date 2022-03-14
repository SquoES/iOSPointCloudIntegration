import Foundation
import AVFoundation
import MetalKit
import Metal

class ARPointCloudView: MTKView, MTKViewDelegate {
        
    private let arProvider = try! ARProvider()
    
    private var depthState: MTLDepthStencilState!
    private var pipelineState: MTLRenderPipelineState!
    private var metalCommandQueue: MTLCommandQueue!
    
    private var confSelection: Int = 0
    private var scaleMovement: Float = .zero
    private var staticAngle: Float = 0.0
    private var staticInc: Float = 0.02
    
    private var _center = simd_float3(0, 0, 500)    // current point camera looks at
    private var _eye = simd_float3(0, 0, 0)         // current camera position
    private var _up = simd_float3(-1, 0, 0)         // camera "up" direction
        
    var lastARData: ARData?
    
    override init(frame frameRect: CGRect, device: MTLDevice?) {
        super.init(frame: frameRect, device: device)
        initialSetup()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        initialSetup()
    }
    
    func draw(in view: MTKView) {
        
        guard let lastArData = lastARData else {
            return
        }
        arProvider.onNewARData(arData: lastArData)
        
        let confidence = arProvider.upscaledConfidence //arProvider.isToUpsampleDepth ? arProvider.upscaledConfidence : arProvider.confidenceContent
        
        guard let commandBuffer = metalCommandQueue.makeCommandBuffer() else { return }
        guard let passDescriptor = view.currentRenderPassDescriptor else { return }
        guard let encoder = commandBuffer.makeRenderCommandEncoder(descriptor: passDescriptor) else { return }
        encoder.setDepthStencilState(depthState)
        encoder.setVertexTexture(arProvider.depthContent.texture, index: 0)
        encoder.setVertexTexture(confidence.texture, index: 1)
        encoder.setVertexTexture(arProvider.colorYContent.texture, index: 2)
        encoder.setVertexTexture(arProvider.colorCbCrContent.texture, index: 3)
        // Camera-intrinsics units are in full camera-resolution pixels.
        var cameraIntrinsics = ARData.cameraIntrinsics
        let depthResolution = simd_float2(x: Float(arProvider.depthContent.texture!.width), y: Float(arProvider.depthContent.texture!.height))
        let scaleRes = simd_float2(x: Float(ARData.cameraResolution.width) / depthResolution.x,
                                   y: Float(ARData.cameraResolution.height) / depthResolution.y )
        cameraIntrinsics[0][0] /= scaleRes.x
        cameraIntrinsics[1][1] /= scaleRes.y

        cameraIntrinsics[2][0] /= scaleRes.x
        cameraIntrinsics[2][1] /= scaleRes.y
        var pmv = calcCurrentPMVMatrix()
        encoder.setVertexBytes(&pmv, length: MemoryLayout<matrix_float4x4>.stride, index: 0)
        encoder.setVertexBytes(&cameraIntrinsics, length: MemoryLayout<matrix_float3x3>.stride, index: 1)
        encoder.setVertexBytes(&confSelection, length: MemoryLayout<Int>.stride, index: 2)
        encoder.setRenderPipelineState(pipelineState)
        encoder.drawPrimitives(type: .point, vertexStart: 0, vertexCount: Int(depthResolution.x * depthResolution.y))
        encoder.endEncoding()
        commandBuffer.present(view.currentDrawable!)
        commandBuffer.commit()
        
    }
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        
    }
    
    func resetView() {
        self._center = simd_float3(0, 0, 500)
        self._eye = simd_float3(0, 0, 0)
        self._up = simd_float3(-1, 0, 0)
    }
    
    func rotate(usingRotation rotation: CGFloat) {
        let angle = Float(rotation) * 60

        let viewDir = simd_normalize(self._center - self._eye)
        let rotMat = Transforms.rotate(angle: angle, r: viewDir)
        self._up = Transforms.matrix4_mul_vector3(m: rotMat, v: self._up)
    }
    
    func pitchAroundCenter(angle: CGFloat) {
        let angle = Float(angle)
        
        let viewDirection = simd_normalize(self._center - self._eye)
        let rightVector = simd_cross(self._up, viewDirection)
        
        let rotMat = Transforms.rotate(angle: angle, r: rightVector)
        
        self._eye = self._eye - self._center
        self._eye = Transforms.matrix4_mul_vector3(m: rotMat, v: self._eye)
        self._eye = self._eye + self._center
        
        self._up = Transforms.matrix4_mul_vector3(m: rotMat, v: self._up)
    }
    
    func yawAroundCenter(angle: CGFloat) {
        let angle = Float(angle)
        
        let rotMat = Transforms.rotate(angle: angle, r: self._up)
        
        self._eye = self._eye - self._center
        self._eye = Transforms.matrix4_mul_vector3(m: rotMat, v: self._eye)
        self._eye = self._eye + self._center
        
        self._up = Transforms.matrix4_mul_vector3(m: rotMat, v: self._up)
    }
    
    func moveTowardCenter(scale: CGFloat) {
        var scale = Float(scale)
        
        var direction = self._center - self._eye
        
        let distance = sqrt(simd_dot(direction, direction))
        if (scale > distance) {
            scale = distance - 3
        }
        
        direction = simd_normalize(direction)
        direction = direction * scale
        
        self._eye += direction
    }
}

extension ARPointCloudView {
    
    private static let pointCloudVertexShaderFunctionName = "pointCloudVertexShader"
    private static let pointCloudFragmentShaderFunctionName = "pointCloudFragmentShader"
    
    private func initialSetup() {
        setupView()
        setupMetalDevice()
        setupFunctions()
    }
    
    private func setupView() {
        
        delegate = self
        
        preferredFramesPerSecond = 60
        backgroundColor = .black
        isOpaque = true
        framebufferOnly = false
        
        clearColor = MTLClearColor(red: .zero,
                                   green: .zero,
                                   blue: .zero,
                                   alpha: .zero)
        
        drawableSize = frame.size
        enableSetNeedsDisplay = false
        depthStencilPixelFormat = .depth32Float
        colorPixelFormat = .bgra8Unorm
        
    }
    
    private func setupMetalDevice() {
        
        let metalDevice = MTLCreateSystemDefaultDevice()!
        device = metalDevice
        metalCommandQueue = metalDevice.makeCommandQueue()!
        
    }
    
    private func setupFunctions() {
        
        let metalDevice = device!
        
        let library = metalDevice.makeDefaultLibrary()
        let pipelineDescriptor = MTLRenderPipelineDescriptor()
        pipelineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
        pipelineDescriptor.vertexFunction = library!.makeFunction(name: Self.pointCloudVertexShaderFunctionName)
        pipelineDescriptor.fragmentFunction = library!.makeFunction(name: Self.pointCloudFragmentShaderFunctionName)
        pipelineDescriptor.vertexDescriptor = createPlaneMetalVertexDescriptor()
        pipelineDescriptor.depthAttachmentPixelFormat = .depth32Float
        pipelineState = try! metalDevice.makeRenderPipelineState(descriptor: pipelineDescriptor)
        
        let depthDescriptor = MTLDepthStencilDescriptor()
        depthDescriptor.isDepthWriteEnabled = true
        depthDescriptor.depthCompareFunction = .less
        depthState = metalDevice.makeDepthStencilState(descriptor: depthDescriptor)
        
    }
    
    private func createPlaneMetalVertexDescriptor() -> MTLVertexDescriptor {
        let mtlVertexDescriptor: MTLVertexDescriptor = MTLVertexDescriptor()
        
        mtlVertexDescriptor.attributes[0].format = .float2
        mtlVertexDescriptor.attributes[0].offset = 0
        mtlVertexDescriptor.attributes[0].bufferIndex = 0
        
        mtlVertexDescriptor.attributes[1].format = .float2
        mtlVertexDescriptor.attributes[1].offset = 8
        mtlVertexDescriptor.attributes[1].bufferIndex = 0
        
        mtlVertexDescriptor.layouts[0].stride = 2 * MemoryLayout<SIMD2<Float>>.stride
        mtlVertexDescriptor.layouts[0].stepRate = 1
        mtlVertexDescriptor.layouts[0].stepFunction = .perVertex
        
        return mtlVertexDescriptor
    }
    
    private func calcCurrentPMVMatrix() -> matrix_float4x4 {
        let aspect = Float(self.drawableSize.width / self.drawableSize.height);

        let vfov = Float(70)
        
        let appleProjMat = Transforms.perspective_fov(fovy: vfov,
                                                      aspect: aspect,
                                                      near: 0.1,
                                                      far: 30_000)

        let eye = self._eye
        let center = self._center
        let up = self._up
                      
        let appleViewMat = Transforms.lookAt(eye: eye,
                                             center: center,
                                             up: up)
        
        var orientationOrig: simd_float4x4 = simd_float4x4()
        
        orientationOrig.columns.0 = [-1, 0, 0, 0]
        orientationOrig.columns.1 = [0, 1, 0, 0]
        orientationOrig.columns.2 = [0, 0, 1, 0]
        orientationOrig.columns.3 = [0, 0, 0, 1]
        
        return orientationOrig * appleProjMat * appleViewMat// * orientationOrig;
    }
    
}
