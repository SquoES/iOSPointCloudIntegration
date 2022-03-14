import Foundation
import RxMVVM
import RxSwift

class CategoryItemViewModel: ViewModel {
    
    let category: FeedCategory
    
    lazy var title = Observable.just("#" + (category.title ?? ""))
    
    var textWidth: CGFloat {
        return category.title?.textWidth(font: .gilroyFont(ofSize: 15, weight: .semibold) ?? .systemFont(ofSize: 15)) ?? 0
    }
    
    init(category: FeedCategory) {
        self.category = category
    }
    
}
