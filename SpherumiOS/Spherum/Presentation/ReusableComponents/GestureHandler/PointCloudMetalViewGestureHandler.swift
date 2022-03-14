enum PointCloudMetalViewHandlerValuesStorageKey: String, GestureHandlerValuesStorageKey {
    
    case lastScale
    case lastZoom
    case lastXY
    
}

class PointCloudMetalViewGestureHandler: GestureHandler<PointCloudMetalView, PointCloudMetalViewHandlerValuesStorageKey> {
    
    override func set(view: PointCloudMetalView?) {
        super.set(view: view)
        
        addPinchHandler { handler, scale in
            let lastScaleAccessor = handler.getValueAccessor(valueType: CGFloat.self,
                                                             accessKey: .lastScale)
            
            if let lastScale = lastScaleAccessor.value {
                let diff = scale - lastScale
                let factor: CGFloat = 1e3
                
                let lastZoom = Float(diff * factor)
                
                view?.moveTowardCenter(lastZoom)
            }
            
            lastScaleAccessor.value = scale
            
        } pinchStartHandler: { handler in
            let lastScaleAccessor = handler.getValueAccessor(valueType: CGFloat.self,
                                                             accessKey: .lastScale)
            
            lastScaleAccessor.value = 1.0
        }
        
        addPanHandler { handler, point in
            let lastXYAccessor = handler.getValueAccessor(valueType: CGPoint.self,
                                                          accessKey: .lastXY)
            
            if let lastXY = lastXYAccessor.value {
                view?.yawAroundCenter(Float((point.x - lastXY.x) * 0.1))
                view?.pitchAroundCenter(Float((point.y - lastXY.y) * 0.1))
            }
            
            lastXYAccessor.value = point
        }

    }
    
}
