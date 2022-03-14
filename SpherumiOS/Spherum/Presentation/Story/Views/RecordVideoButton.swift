import UIKit
import RxSwift
import RxCocoa

class RecordVideoButton: UIButton {
    
    private let rectSize = CGSize(width: 28, height: 28)
    private let rectRadius: CGFloat = 8
    
    private let progressLineWidth: CGFloat = 6
    
    private var displayLink: CADisplayLink!
    private var startTime: Date?
    
    private let maxSeconds: TimeInterval = 10

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadUI()
    }
    
    func start() {
        startTime = Date()
        displayLink.isPaused = false
    }
    
    func stop() {
        startTime = nil
        displayLink.isPaused = true
    }
    
    override func draw(_ rect: CGRect) {
        
        if let startTime = startTime {
            let seconds = abs(Date().timeIntervalSince1970 - startTime.timeIntervalSince1970)
            
            
            let centerRect = CGRect(x: (rect.width - rectSize.width) / 2,
                                    y: (rect.height - rectSize.height) / 2,
                                    width: rectSize.width,
                                    height: rectSize.height)
            let centerRectPath = UIBezierPath(roundedRect: centerRect,
                                              cornerRadius: rectRadius)
            
            UIColor.white.setFill()
            centerRectPath.fill()
            
            let progress = (seconds / 10).truncatingRemainder(dividingBy: maxSeconds)
            
            
            UIColor.white.withAlphaComponent(0.6).setStroke()
            let progressBackgroundPath = UIBezierPath(arcCenter: CGPoint(x: rect.width / 2, y: rect.height / 2),
                                                      radius: rect.width / 2 - progressLineWidth,
                                                      startAngle: 0,
                                                      endAngle: 2 * .pi,
                                                      clockwise: true)
            progressBackgroundPath.lineWidth = progressLineWidth
            progressBackgroundPath.stroke()
            
            UIColor.white.setStroke()
            let progressPath = UIBezierPath(arcCenter: CGPoint(x: rect.width / 2, y: rect.height / 2),
                                            radius: rect.width / 2 - progressLineWidth,
                                            startAngle: -.pi / 2,
                                            endAngle: -.pi / 2 + (progress * 2 * .pi),
                                            clockwise: true)
            progressPath.lineWidth = progressLineWidth
            progressPath.stroke()
        }
        
    }
    
    private func loadUI() {
        
        displayLink = CADisplayLink(target: self,
                                    selector: #selector(handleTick))
        displayLink.add(to: .main,
                        forMode: .common)
        displayLink.isPaused = true
        
        addTarget(self,
                  action: #selector(handleTap),
                  for: .touchUpInside)
        
    }

    @objc private func handleTap() {
        stop()
    }
    
    @objc private func handleTick() {
        if let startTime = startTime {
            let seconds = abs(Date().timeIntervalSince1970 - startTime.timeIntervalSince1970)
            
            if seconds >= maxSeconds {
                stop()
                sendActions(for: .touchUpInside)
            }
        }
        setNeedsDisplay()
    }
    
}

