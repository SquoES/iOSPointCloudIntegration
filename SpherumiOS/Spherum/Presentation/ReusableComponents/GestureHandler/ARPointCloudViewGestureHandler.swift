import CoreGraphics
enum ARPointCloudViewGestureHandlerValuesStorageKey: String, GestureHandlerValuesStorageKey {
    case lastRotationXY
    case lastScale
    case lastZoom
}

class ARPointCloudViewGestureHandler: GestureHandler<ARPointCloudView, ARPointCloudViewGestureHandlerValuesStorageKey> {
    
    override func set(view: ARPointCloudView?) {
        super.set(view: view)
        
        addPanHandler { handler, point in
            let lastRotationXYAccessor = handler.getValueAccessor(valueType: CGPoint.self,
                                                                  accessKey: .lastRotationXY)
            
            if let lastRotationXY = lastRotationXYAccessor.value {
                view?.yawAroundCenter(angle: (point.x - lastRotationXY.x) * 0.1)
                view?.pitchAroundCenter(angle: (point.y - lastRotationXY.y) * 0.1)
            }
            
            lastRotationXYAccessor.value = point
        }
        
        addPinchHandler { handler, scale in
            let lastScaleAccessor = handler.getValueAccessor(valueType: CGFloat.self,
                                                             accessKey: .lastScale)
            
            if let lastScale = lastScaleAccessor.value {
                let diff = scale - lastScale
                let factor: CGFloat = -1e3
                
                let zoom = diff * factor
            
                view?.moveTowardCenter(scale: zoom)
            }
            
            lastScaleAccessor.value = scale
        } pinchStartHandler: { handler in
            let lastScaleAccessor = handler.getValueAccessor(valueType: CGFloat.self,
                                                             accessKey: .lastScale)
            lastScaleAccessor.value = 1.0
        }
    }
    
}
