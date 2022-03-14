import QuartzCore
class VirtualObjectsAnimator {
    
    private var displayLink: CADisplayLink?
    
    private var currentFrame = -1
    private var objectsCount = 0
    private var virtualObjects: [VirtualObject] = []
    
    func set(virtualObjects: [VirtualObject]) {
        self.virtualObjects = virtualObjects
        self.objectsCount = virtualObjects.count
        virtualObjects.forEach { $0.isHidden = true }
    }
    
    func resetAnimation() {
        currentFrame = -1
    }
    
    func startAnimation() {
        prepareDisplayLinkIfNeeded()
        displayLink?.isPaused = false
    }
    
    func stopAnimation() {
        resetAnimation()
        displayLink?.isPaused = true
    }
    
    private func prepareDisplayLinkIfNeeded() {
        guard displayLink.isNil else {
            return
        }
        
        displayLink = CADisplayLink(target: self,
                                    selector: #selector(updateAnimation))
        displayLink?.preferredFramesPerSecond = 60
        displayLink?.add(to: .main,
                         forMode: .common)
    }
    
    @objc private func updateAnimation() {
        guard !virtualObjects.isEmpty else {
            return
        }
        
//        if currentFrame != -1 {
//            virtualObjects[currentFrame].isHidden = true
//        }
//        currentFrame = (currentFrame + 1) % objectsCount
////        print("CURRENT FRAME:", currentFrame)
//        virtualObjects[currentFrame].isHidden = false
    }
    
}
