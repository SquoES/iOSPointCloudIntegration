


import Foundation
import RxMVVM
import RxSwift
import RxCocoa

class HomeItemViewModel: ViewModel {
    
    let isFollow = BehaviorRelay<Bool>(value: false)
    let isLike = BehaviorRelay<Bool>(value: false)
    
    let followPressed = PublishSubject<Void>()
    let likePressed = PublishSubject<Void>()
        
    override func subscribe() {
        
        followPressed.bind(onNext: {[weak self] in
            self?.isFollow.toggle()
        }).disposed(by: disposeBag)
        
        likePressed.bind(onNext: {[weak self] in
            self?.isLike.toggle()
        }).disposed(by: disposeBag)
        
        super.subscribe()
    }
    
}
