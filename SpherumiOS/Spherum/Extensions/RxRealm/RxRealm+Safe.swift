import RxSwift
import RxRealm
import RealmSwift

public extension Observable where Element: Object {
    
    static func fromRealm(realmObject object: Element,
                          emitInitialValue: Bool = true,
                          properties: [String]? = nil) -> Observable<Element> {
        
        return Observable<Element>.create { observer in
            if emitInitialValue {
                if object.isInvalidated {
                    observer.onError(RxRealmError.objectDeleted)
                    return Disposables.create()
                } else {
                    observer.onNext(object)
                }
            }
            
            let token = object.observe { change in
                switch change {
                case let .change(objectBase, changedProperties):
                    guard !objectBase.isInvalidated else {
                        observer.onError(RxRealmError.objectDeleted)
                        return
                    }
                    if let properties = properties, !changedProperties.contains(where: { properties.contains($0.name) }) {
                        // if change property isn't an observed one, just return
                        return
                    }
                    observer.onNext(object)
                case .deleted:
                    observer.onError(RxRealmError.objectDeleted)
                case let .error(error):
                    observer.onError(error)
                }
            }
            
            return Disposables.create {
                token.invalidate()
            }
        }
    }
    
}
