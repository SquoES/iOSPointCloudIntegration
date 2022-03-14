//
//  CameraRecorder.swift
//  Spherum3DScanner
//
//  Created by Artem Eremeev on 20.06.2021.
//

import Foundation
import AVFoundation

class CameraRecorder: NSObject {
    
    typealias Sample = (CVPixelBuffer, AVDepthData)
    typealias OnNewSample = (Sample) -> Void
    
    let captureSession = AVCaptureSession()
    
    private let depthDataOutput = AVCaptureDepthDataOutput()
    private let videoDataOutput = AVCaptureVideoDataOutput()
    
    private let cameraDevice: AVCaptureDevice?
    private var cameraDevicePosition: AVCaptureDevice.Position {
        return self.cameraDevice?.position ?? .unspecified
    }
    private let cameraDeviceInput: AVCaptureDeviceInput?
    
    private(set) var sessionConfigured: Bool = false
    
    private let dataOutputDispatchQueue = DispatchQueue(label: "CameraRecordManager_dataOutputDispatchQueue")

    // https://developer.apple.com/documentation/avfoundation/avcapturedataoutputsynchronizer
    private var outputSyncronizer: AVCaptureDataOutputSynchronizer?
    
    private var assetWriter: CameraRecorderAssetWriter?
    
    var onNewSample: OnNewSample?
    
    init(preferredCameraPosition: AVCaptureDevice.Position) {
        
        self.cameraDevice = CameraRecorder.requestCameraDevice(forPreferredPosition: preferredCameraPosition)
        self.cameraDeviceInput = CameraRecorder.tryCreateCameraDeviceInput(forDevice: self.cameraDevice)
        
        super.init()
        
        self.tryConfigureSession()

    }
    
    private func tryConfigureSession() {
        self.captureSession.beginConfiguration()
        
        self.captureSession.sessionPreset = .high
        
        guard let cameraDeviceInput = self.cameraDeviceInput,
              self.captureSession.canAddInput(cameraDeviceInput) else {
            return
        }
        self.captureSession.addInput(cameraDeviceInput)
        
        guard self.captureSession.canAddOutput(self.videoDataOutput) else {
            return
        }
        self.captureSession.addOutput(self.videoDataOutput)
        if let videoDataConnection = self.videoDataOutput.connection(with: .video) {
            print("videoDataConnection.videoOrientation:", videoDataConnection.videoOrientation)
            videoDataOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: Int(kCVPixelFormatType_32BGRA)]
//            videoDataConnection.videoOrientation = .portrait
        }
        
        guard self.captureSession.canAddOutput(self.depthDataOutput) else {
            return
        }
        self.captureSession.addOutput(self.depthDataOutput)
        if let depthDataConnection = self.depthDataOutput.connection(with: .depthData) {
            depthDataConnection.isEnabled = true
            self.depthDataOutput.isFilteringEnabled = false
//            depthDataConnection.videoOrientation = .portrait
            print("depthDataConnection.videoOrientation:", depthDataConnection.videoOrientation)
        }
        
        let videoDevice = cameraDeviceInput.device
        let depthFormats = videoDevice.activeFormat.supportedDepthDataFormats
        let filtered = depthFormats.filter({
            CMFormatDescriptionGetMediaSubType($0.formatDescription) == kCVPixelFormatType_DepthFloat16
        })
        let selectedFormat = filtered.max(by: {
            first, second in CMVideoFormatDescriptionGetDimensions(first.formatDescription).width < CMVideoFormatDescriptionGetDimensions(second.formatDescription).width
        })
        
        try! videoDevice.lockForConfiguration()
        videoDevice.activeDepthDataFormat = selectedFormat
        videoDevice.unlockForConfiguration()
        
        self.outputSyncronizer = AVCaptureDataOutputSynchronizer(dataOutputs: [self.videoDataOutput, self.depthDataOutput])
        self.outputSyncronizer?.setDelegate(self, queue: self.dataOutputDispatchQueue)
        
        self.sessionConfigured = true
        
        self.captureSession.commitConfiguration()
    }
    
    func startRunning() {
        guard !self.captureSession.isRunning else {
            return
        }
        
        self.captureSession.startRunning()
    }
    
    func stopRunning() {
        guard self.captureSession.isRunning else {
            return
        }
        
        self.captureSession.stopRunning()
    }
    
    func startRecording() {
        let recommendedVideoSettings = videoDataOutput.recommendedVideoSettings(forVideoCodecType: .h264,
                                                                                assetWriterOutputFileType: .mov)
        self.assetWriter = CameraRecorderAssetWriter(recommendedVideoSettings: recommendedVideoSettings)
        self.assetWriter?.startRecording()
    }
    
    func stopRecording(onCompleted: @escaping (FileGroup) -> Void) {
        self.assetWriter?.stopRecording(onCompleted: { [weak self] fileGroup in
            onCompleted(fileGroup)
            self?.assetWriter = nil
        })
    }
    
}

// MARK: - AVCaptureVideoDataOutputSampleBufferDelegate & AVCaptureDepthDataOutputDelegate
extension CameraRecorder: AVCaptureDataOutputSynchronizerDelegate {
    
    func dataOutputSynchronizer(_ synchronizer: AVCaptureDataOutputSynchronizer,
                                didOutput synchronizedDataCollection: AVCaptureSynchronizedDataCollection) {
        
        let videoData = synchronizedDataCollection[self.videoDataOutput] as? AVCaptureSynchronizedSampleBufferData
        let depthData = synchronizedDataCollection[self.depthDataOutput] as? AVCaptureSynchronizedDepthData
        
        

        if let pixelBuffer = videoData?.sampleBuffer.imageBuffer, let depthData = depthData?.depthData {
            let sample: Sample = (pixelBuffer, depthData)
            self.onNewSample?(sample)
            
            print("record buffer width:", CVPixelBufferGetWidth(pixelBuffer))
            print("record buffer height:", CVPixelBufferGetHeight(pixelBuffer))
            print("record depth width:", CVPixelBufferGetWidth(depthData.depthDataMap))
            print("record depth height:", CVPixelBufferGetHeight(depthData.depthDataMap))
        }
        
        self.assetWriter?.record(videoData: videoData,
                                 depthData: depthData)
    }
    
}


// MARK: - SUPPORT
fileprivate extension CameraRecorder {
    
    static func requestCameraDevice(forPreferredPosition position: AVCaptureDevice.Position,
                                    trySwitchToAvailablePosition: Bool = false) -> AVCaptureDevice? {
        switch position {
        case .front:
            if let frontCameraDevice = AVCaptureDevice.default(.builtInTrueDepthCamera,
                                                               for: .video,
                                                               position: .front) {
                return frontCameraDevice
            } else {
                if trySwitchToAvailablePosition {
                    return self.requestCameraDevice(forPreferredPosition: .back,
                                                    trySwitchToAvailablePosition: false)
                }
                return nil
            }
            
        case .back:
            if let backCameraDevice = AVCaptureDevice.default(.builtInTrueDepthCamera,
                                                              for: .video,
                                                              position: .back) {
                return backCameraDevice
            } else {
                if trySwitchToAvailablePosition {
                    return self.requestCameraDevice(forPreferredPosition: .front,
                                                    trySwitchToAvailablePosition: false)
                }
                return nil
            }
            
        default:
            if trySwitchToAvailablePosition {
                return self.requestCameraDevice(forPreferredPosition: .front,
                                                trySwitchToAvailablePosition: true)
            }
            return nil
        }
    }
    
    static func tryCreateCameraDeviceInput(forDevice device: AVCaptureDevice?) -> AVCaptureDeviceInput? {
        guard let device = device else {
            #if DEBUG
            print("CameraRecordManager: device is nil")
            #endif
            return nil
        }
        do {
            return try AVCaptureDeviceInput(device: device)
        } catch let error {
            #if DEBUG
            print("CameraRecordManager: \(error.localizedDescription)")
            #endif
            return nil
        }
    }
    
}
