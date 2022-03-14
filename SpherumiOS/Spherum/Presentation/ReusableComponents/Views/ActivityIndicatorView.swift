import UIKit

@IBDesignable
class ActivityIndicatorView: UIView {

    @IBInspectable var accentColor: UIColor = .white { didSet { refresh() } }
    @IBInspectable var radius: CGFloat = 12 { didSet { setNeedsDisplay() } }
    @IBInspectable var lineWidth: CGFloat = 2 { didSet { setNeedsDisplay() } }
    
    private var _isAnimating = false
    @IBInspectable var isAnimating: Bool {
        get { self._isAnimating }
        set { self.set(animating: newValue) }
    }
    
    private var progress: CFTimeInterval = 0.0
    private var displayLink: CADisplayLink?
    private var startTime: CFTimeInterval?

    override func draw(_ rect: CGRect) {
        
        guard self._isAnimating else {
            return
        }
        
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        
        let shift = CGFloat.pi * 2.0 * CGFloat(progress)
        let path = UIBezierPath(arcCenter: center, radius: self.radius,
                                startAngle: shift, endAngle: .pi * 1.5 + shift,
                                clockwise: true)
        path.lineWidth = self.lineWidth
        path.lineCapStyle = .round
        
        accentColor.setStroke()
        path.stroke()
        
    }
    
    deinit {
        self.displayLink?.invalidate()
    }
    
    private func set(animating: Bool) {
        if self._isAnimating != animating {
            self._isAnimating = animating
            
            if animating {
                self.startAnimation()
            } else {
                self.stopAnimation()
            }
        }
        self.setNeedsDisplay()
    }
    
    private func startAnimation() {
        self.startTime = CACurrentMediaTime()
        self.displayLink = CADisplayLink(target: self, selector: #selector(self.updateAnimation))
        self.displayLink?.add(to: .main, forMode: .common)
    }
    private func stopAnimation() {
        self.displayLink?.isPaused = true
        self.displayLink?.invalidate()
        self.startTime = nil
    }
    
    @objc private func updateAnimation() {
        guard let startTime = self.startTime else {
            return
        }
        self.progress = (CACurrentMediaTime() - startTime).remainder(dividingBy: 100.0)
        self.setNeedsDisplay()
    }
    
    private func refresh() {
        setNeedsDisplay()
        setNeedsLayout()
    }
}
