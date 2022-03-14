import Foundation
import UIKit

protocol TargetGestureViewProviderProtocol: AnyObject {
    var interactiveView: UIView? { get }
}

class GestureManager {
    
    typealias OnRotationChanged = (CGFloat) -> Void
    typealias OnTranslationChanged = (CGPoint) -> Void
    typealias OnScaleBegin = () -> Void
    typealias OnScaleChanged = (CGFloat) -> Void
    
    private unowned let interactiveView: UIView?
    
    private var rotationGesture: UIRotationGestureRecognizer?
    private var onRotationChanged: OnRotationChanged?
    
    private var panGesture: UIPanGestureRecognizer?
    private var onTranslationBegin: OnTranslationChanged?
    private var onTranslationChanged: OnTranslationChanged?
    
    private var pinchGesture: UIPinchGestureRecognizer?
    private var onScaleBegin: OnScaleBegin?
    private var onScaleChanged: OnScaleChanged?
    
    init(with target: TargetGestureViewProviderProtocol) {
        self.interactiveView = target.interactiveView
    }
    
    deinit {
        guard let interactiveView = self.interactiveView else {
            return
        }
        
        if let rotationGesture = self.rotationGesture {
            interactiveView.removeGestureRecognizer(rotationGesture)
        }
    }
    
    func registerRotation(handler: @escaping OnRotationChanged) {
        
        guard let interactiveView = self.interactiveView else {
            return
        }
        
        if let rotationGesture = self.rotationGesture {
            interactiveView.removeGestureRecognizer(rotationGesture)
        }
        
        self.onRotationChanged = handler
        rotationGesture = UIRotationGestureRecognizer(target: self,
                                                      action: #selector(handleRegisteredRotation(gesture:)))
        interactiveView.addGestureRecognizer(rotationGesture!)
        
    }
    
    @objc private func handleRegisteredRotation(gesture: UIRotationGestureRecognizer) {
        if gesture.numberOfTouches != 2 {
            return
        }
        
        if gesture.state == .changed {
            self.onRotationChanged?(gesture.rotation)
            gesture.rotation = .zero
        }
    }
    
    func registerPan(beginHandler: @escaping OnTranslationChanged, changedHandler: @escaping OnTranslationChanged) {
        
        guard let interactiveView = self.interactiveView else {
            return
        }
        
        if let panGesture = self.panGesture {
            interactiveView.removeGestureRecognizer(panGesture)
        }
        
        self.onTranslationBegin = beginHandler
        self.onTranslationChanged = changedHandler
        
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(handleRegisteredPan(gesture:)))
        panGesture!.maximumNumberOfTouches = 1
        panGesture!.minimumNumberOfTouches = 1
        interactiveView.addGestureRecognizer(panGesture!)
    }
    
    @objc private func handleRegisteredPan(gesture: UIPanGestureRecognizer) {
        if gesture.numberOfTouches != 1 {
            return
        }
        
        guard let interactiveView = self.interactiveView else {
            return
        }
        
        if gesture.state == .began {
            let point = gesture.translation(in: interactiveView)
            onTranslationBegin?(point)
            
        } else if (.failed != gesture.state) && (.cancelled != gesture.state) {
            let point: CGPoint = gesture.translation(in: interactiveView)
            onTranslationChanged?(point)
        }
    }
    
    func registerPinch(beginHandler: @escaping OnScaleBegin, changedHandler: @escaping OnScaleChanged) {
        
        guard let interactiveView = self.interactiveView else {
            return
        }
        
        if let pinchGesture = self.pinchGesture {
            interactiveView.removeGestureRecognizer(pinchGesture)
        }
        
        self.onScaleBegin = beginHandler
        self.onScaleChanged = changedHandler
        
        pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handleRegisteredPinch(gesture:)))
        interactiveView.addGestureRecognizer(pinchGesture!)
    }
    
    @objc private func handleRegisteredPinch(gesture: UIPinchGestureRecognizer) {
        if gesture.numberOfTouches != 2 {
            return
        }
        
        if gesture.state == .began {
            onScaleBegin?()
            
        } else if gesture.state == .changed {
            onScaleChanged?(gesture.scale)
        }
    }
}
