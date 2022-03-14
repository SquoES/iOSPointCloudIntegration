import UIKit

protocol GestureHandlerValuesStorageKey: Hashable {
    var rawValue: String { get }
}

extension GestureHandlerValuesStorageKey {
    var hashValue: Int { rawValue.hashValue }
}

class GestureHandlerValueAccessor<Value, StorageKey: GestureHandlerValuesStorageKey> {
    
    private let accessKey: StorageKey
    private let valuesStorage: GestureHandlerValuesStorage<StorageKey>
    
    init(valuesStorage: GestureHandlerValuesStorage<StorageKey>, accessKey: StorageKey) {
        self.accessKey = accessKey
        self.valuesStorage = valuesStorage
    }
    
    var value: Value? {
        get { valuesStorage[accessKey] as? Value }
        set { valuesStorage[accessKey] = newValue }
    }
    
}

class GestureHandlerValuesStorage<StorageKey: GestureHandlerValuesStorageKey> {
    private var valuesStorage = [StorageKey: Any]()
    
    subscript(key: StorageKey) -> Any? {
        get { valuesStorage[key] }
        set(newValue) { valuesStorage[key] = newValue }
    }
}

class GestureHandler<View: UIView, StorageKey: GestureHandlerValuesStorageKey> {
    
    typealias PanHandler = (GestureHandler<View, StorageKey>, CGPoint) -> Void
    typealias RotationHandler = (GestureHandler<View, StorageKey>, CGFloat) -> Void
    typealias PinchHandler = (GestureHandler<View, StorageKey>, CGFloat) -> Void
    typealias PinchStartHandler = (GestureHandler<View, StorageKey>) -> Void
    
    private weak var view: View?
    
    private var valuesStorage = GestureHandlerValuesStorage<StorageKey>()
    
    private var recognizers = [UIGestureRecognizer]()
    
    var onPanned: PanHandler?
    var onRotated: RotationHandler?
    var onPinched: PinchHandler?
    var onPinchStarted: PinchStartHandler?
    
    func set(view: View?) {
        self.view = view
    }
    
    func getValueAccessor<Value>(valueType: Value.Type, accessKey: StorageKey) -> GestureHandlerValueAccessor<Value, StorageKey> {
        GestureHandlerValueAccessor(valuesStorage: valuesStorage,
                                    accessKey: accessKey)
    }
    
    func addPanHandler(_ panHandler: @escaping PanHandler) {
        let panGestureRecognizer = UIPanGestureRecognizer(target: self,
                                                          action: #selector(handlePan(recognizer:)))
        panGestureRecognizer.maximumNumberOfTouches = 1
        panGestureRecognizer.minimumNumberOfTouches = 1
        view?.addGestureRecognizer(panGestureRecognizer)
        onPanned = panHandler
    }
    
    func addPinchHandler(_ pinchHandler: @escaping PinchHandler, pinchStartHandler: @escaping PinchStartHandler) {
        let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(recognizer:)))
        view?.addGestureRecognizer(pinchGestureRecognizer)
        onPinched = pinchHandler
        onPinchStarted = pinchStartHandler
    }
    
    func addRotationHandler(_ rotationHandler: @escaping RotationHandler) {
        let rotationGestureRecognizer = UIRotationGestureRecognizer(target: self,
                                                                    action: #selector(handleRotation(recognizer:)))
        view?.addGestureRecognizer(rotationGestureRecognizer)
        onRotated = rotationHandler
    }
    
    @objc private func handlePan(recognizer: UIPanGestureRecognizer) {
        if recognizer.numberOfTouches != 1 {
            return
        }
        
        guard let view = recognizer.view else {
            return
        }
        
        switch recognizer.state {
        case .began, .changed:
            let point = recognizer.translation(in: view)
            onPanned?(self, point)
            
        default:
            break
        }
    }
    
    @objc private func handlePinch(recognizer: UIPinchGestureRecognizer) {
        if recognizer.numberOfTouches != 2 {
            return
        }
        
        switch recognizer.state {
        case .began:
            onPinchStarted?(self)
        case .changed:
            let scale = recognizer.scale
            onPinched?(self, scale)
            
        default:
            break
        }
    }
    
    @objc private func handleRotation(recognizer: UIRotationGestureRecognizer) {
        if recognizer.numberOfTouches != 2 {
            return
        }
        
        switch recognizer.state {
        case .changed:
            let rotation = recognizer.rotation
            onRotated?(self, rotation)
            recognizer.rotation = .zero
            
        default:
            break
        }
    }
    
}
