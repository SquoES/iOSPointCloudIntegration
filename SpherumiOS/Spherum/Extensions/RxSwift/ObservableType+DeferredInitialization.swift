import RxSwift

extension Single {
    
    static func deferred(queue: DispatchQueue = .main, action: @escaping () -> Element) -> Single<Element> {
        .create { observer in
            queue.async {
                let element = action()
                observer(.success(element))
            }
            return Disposables.create()
        }
    }
    
}
