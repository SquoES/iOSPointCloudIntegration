import Foundation
import RxSwift
import RxMVVM

extension AlertConstructor {
    
    func add(alertItem: AlertItem, actionStyle: UIAlertAction.Style? = nil) -> AlertConstructor {
        return self.addAction(title: alertItem.title,
                              style: actionStyle ?? alertItem.actionStyle,
                              actionKey: alertItem.rawValue)
    }
    
    func add(alertItems: AlertItem...) -> AlertConstructor {
        var constructor = self
        for alertItem in alertItems {
            constructor = constructor.add(alertItem: alertItem)
        }
        return constructor
    }
    
    func selectedAlertItem() -> Single<AlertItem> {
        return self.result().map(AlertItem.from(rawValue:))
    }
    
}
