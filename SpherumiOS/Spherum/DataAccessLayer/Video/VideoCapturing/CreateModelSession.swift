import AVFoundation
import UIKit

final class CreateModelSession: NSObject, VideoContentProviderSession {
    
    private let queue = DispatchQueue(label: "com.spherum.CreateModelSession")
    
    private var captureSession: AVCaptureSession!
    private var deviceInput: AVCaptureDeviceInput!
    private var videoDataOutput: AVCaptureVideoDataOutput!
    
    private(set) var initialized: Bool = false
    
    var recommendedVideoSettings: [String: Any]? {
        videoDataOutput?.recommendedVideoSettingsForAssetWriter(writingTo: .mov)
    }
    
    var running: Bool {
        captureSession?.isRunning ?? false
    }
    
    weak var videoContentProviderSessionDelegate: VideoContentProviderSessionDelegate?
    
    func startSession() {
        guard !running else {
            return
        }
        
        initializeSessionIfNeeded()
        captureSession?.startRunning()
    }
    
    func stopSession() {
        guard running else {
            return
        }
        
        captureSession?.stopRunning()
    }
    
    func initializeSessionIfNeeded() {
        guard !initialized else {
            return
        }
        
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .high
        
        guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back),
              let deviceInput = try? AVCaptureDeviceInput(device: device),
              captureSession.canAddInput(deviceInput) else {
            return
        }
        
        self.deviceInput = deviceInput
        
        captureSession.beginConfiguration()
        captureSession.addInput(deviceInput)
        captureSession.commitConfiguration()
        
        videoDataOutput = AVCaptureVideoDataOutput()
        
        guard captureSession.canAddOutput(videoDataOutput) else {
            return
        }
        
        videoDataOutput.setSampleBufferDelegate(self, queue: queue)
        
        captureSession.beginConfiguration()
        captureSession.addOutput(videoDataOutput)
        captureSession.commitConfiguration()
        
        for videoOrientationConnection in captureSession.connections.filter({ $0.isVideoOrientationSupported }) {
            videoOrientationConnection.videoOrientation = .portrait
        }
        
        initialized = true
    }
    
}

extension CreateModelSession: AVCaptureVideoDataOutputSampleBufferDelegate {
    
    func captureOutput(_ output: AVCaptureOutput,
                       didOutput sampleBuffer: CMSampleBuffer,
                       from connection: AVCaptureConnection) {
        
        videoContentProviderSessionDelegate?.videoContentProviderSession(self,
                                                                         didOutput: .createModelSample(sampleBuffer))
        
    }
    
}
