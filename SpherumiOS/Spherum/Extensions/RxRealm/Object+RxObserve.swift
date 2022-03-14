import Foundation
import RealmSwift
import RxSwift

extension Reactive where Base: Object {
    
    func observe<T>(_ keyPath: KeyPath<Base, T>) -> Observable<T?> {
        guard !base.isInvalidated else {
            return .just(nil)
        }
        
        let keyPath = NSExpression(forKeyPath: keyPath).keyPath
        
        return base.rx.observe(T.self, keyPath).catchError { _ in
            return .just(nil)
        }
    }
    
}
