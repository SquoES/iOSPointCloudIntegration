import AVFoundation
import UIKit

class PlayerView: UIView {
    
    private var player: AVPlayer!
    private var playerLayer: AVPlayerLayer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadUI()
    }
    
    private func loadUI() {
        
        playerLayer = AVPlayerLayer()
        playerLayer.frame = bounds
//        playerLayer.setAffineTransform(.init(rotationAngle: .pi/2))
        layer.addSublayer(playerLayer)
        
    }
    
    func playVideo(url: URL) {
        if let previousPlayer = player {
            previousPlayer.pause()
            NotificationCenter.default.removeObserver(self,
                                                      name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                                      object: previousPlayer.currentItem)
        }
        
        player = AVPlayer(url: url)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(playerDidFinishPlaying),
                                               name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                               object: player.currentItem)
        playerLayer.player = player
        player?.play()
    }
    
    func stopPlaying() {
        player?.pause()
        player = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        playerLayer.frame = bounds
    }
    
    @objc private func playerDidFinishPlaying() {
        player?.seek(to: .zero)
        player?.play()
    }
    
}
