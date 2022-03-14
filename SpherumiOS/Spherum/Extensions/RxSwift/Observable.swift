import Foundation
import RxSwift

extension Observable {
    
    func asSingleFromFirst() -> Single<Element> {
        return Single.create(subscribe: { observer in
            return self.subscribe(onNext: { element in
                observer(.success(element))
            }, onError: { error in
                observer(.error(error))
            })
        })
    }
    
}
