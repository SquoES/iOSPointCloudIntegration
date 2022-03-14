import AVFoundation
import UIKit

final class FaceIDSession: NSObject, VideoContentProviderSession {
    
    private let queue = DispatchQueue(label: "com.spherum.FaceIDSession")
    
    private var captureSession: AVCaptureSession!
    private var videoDeviceInput: AVCaptureDeviceInput!
    private var audioDeviceInput: AVCaptureDeviceInput!
    private var videoDataOutput: AVCaptureVideoDataOutput!
    private var audioDataOutput: AVCaptureAudioDataOutput!
    private var depthDataOutput: AVCaptureDepthDataOutput!
    
    private var outputSyncronizer: AVCaptureDataOutputSynchronizer!
    
    private(set) var initialized: Bool = false
    
    var recommendedVideoSettings: [String : Any]? {
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
        captureSession.beginConfiguration()
        
        captureSession.sessionPreset = .hd1280x720

        guard let videoDevice = AVCaptureDevice.default(.builtInTrueDepthCamera, for: .video, position: .front),
              let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice),
              captureSession.canAddInput(videoDeviceInput) else {
            return
        }
        self.videoDeviceInput = videoDeviceInput
        captureSession.addInput(videoDeviceInput)

        videoDataOutput = AVCaptureVideoDataOutput()
        guard captureSession.canAddOutput(videoDataOutput) else {
            return
        }
        captureSession.addOutput(videoDataOutput)
        if let videoDataConnection = videoDataOutput.connection(with: .video) {
            print("videoDataConnection.videoOrientation:", videoDataConnection.videoOrientation)
            videoDataOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: Int(kCVPixelFormatType_32BGRA)]
            videoDataConnection.videoOrientation = .portrait
        }
        
        guard let audioDevice = AVCaptureDevice.default(.builtInMicrophone, for: .audio, position: .unspecified),
              let audioDeviceInput = try? AVCaptureDeviceInput(device: audioDevice),
              captureSession.canAddInput(audioDeviceInput) else {
                  return
              }
        self.audioDeviceInput = audioDeviceInput
        captureSession.addInput(audioDeviceInput)
        
        try! AVAudioSession.sharedInstance().setActive(false)
        try! AVAudioSession.sharedInstance().setCategory(.playAndRecord)
        try! AVAudioSession.sharedInstance().setActive(true)
        captureSession.automaticallyConfiguresApplicationAudioSession = false
        
        audioDataOutput = AVCaptureAudioDataOutput()
        guard captureSession.canAddOutput(audioDataOutput) else {
            return
        }
        audioDataOutput.setSampleBufferDelegate(self, queue: queue)
        captureSession.addOutput(audioDataOutput)

        depthDataOutput = AVCaptureDepthDataOutput()
        guard captureSession.canAddOutput(depthDataOutput) else {
            return
        }
        captureSession.addOutput(depthDataOutput)
        if let depthDataConnection = depthDataOutput.connection(with: .depthData) {
            depthDataConnection.isEnabled = true
            depthDataOutput.isFilteringEnabled = false
            depthDataConnection.videoOrientation = .portrait
        }
        

        let selectedFormat = videoDeviceInput.device.activeFormat.supportedDepthDataFormats.filter({ format in
            CMFormatDescriptionGetMediaSubType(format.formatDescription) == kCVPixelFormatType_DepthFloat16
        }).max(by: { first, second in
            CMVideoFormatDescriptionGetDimensions(first.formatDescription).width < CMVideoFormatDescriptionGetDimensions(second.formatDescription).width
        })
        try! videoDevice.lockForConfiguration()
        videoDevice.activeDepthDataFormat = selectedFormat
        videoDevice.unlockForConfiguration()

        outputSyncronizer = AVCaptureDataOutputSynchronizer(dataOutputs: [videoDataOutput, depthDataOutput])
        outputSyncronizer?.setDelegate(self, queue: queue)

        captureSession.commitConfiguration()
        
        initialized = true
    }
    
}

extension FaceIDSession: AVCaptureAudioDataOutputSampleBufferDelegate {
    
    func captureOutput(_ output: AVCaptureOutput,
                       didOutput sampleBuffer: CMSampleBuffer,
                       from connection: AVCaptureConnection) {
        
        videoContentProviderSessionDelegate?.videoContentProviderSession(self,
                                                                         didOutput: .faceIDAudioSample(sampleBuffer))
        
    }
    
}

extension FaceIDSession: AVCaptureDataOutputSynchronizerDelegate {
    
    func dataOutputSynchronizer(_ synchronizer: AVCaptureDataOutputSynchronizer,
                                didOutput synchronizedDataCollection: AVCaptureSynchronizedDataCollection) {
        
        let videoData = synchronizedDataCollection[videoDataOutput] as? AVCaptureSynchronizedSampleBufferData
        let depthData = synchronizedDataCollection[depthDataOutput] as? AVCaptureSynchronizedDepthData
        
        guard let sampleBuffer = videoData?.sampleBuffer,
              let depthData = depthData?.depthData else {
            return
        }
        
        videoContentProviderSessionDelegate?.videoContentProviderSession(self,
                                                                         didOutput: .faceIDVideoSample(sampleBuffer,
                                                                                                       depthData))
        
    }
    
}
