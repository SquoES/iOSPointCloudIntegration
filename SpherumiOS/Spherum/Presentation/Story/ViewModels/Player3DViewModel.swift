import RxSwift
import RxCocoa
import RxMVVM

class Player3DViewModel: ViewModel {
    
    let videoPackage: BehaviorRelay<VideoPackage>
    
    let close = PublishSubject<Void>()
    
    init(videoPackage: VideoPackage) {
        self.videoPackage = .init(value: videoPackage)
    }
    
    override func subscribe() {
        
        close.bind(onNext: {
            Navigator.pop()
        }).disposed(by: disposeBag)
        
        super.subscribe()
    }
    
}
