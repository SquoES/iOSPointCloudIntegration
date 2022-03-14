import Foundation
import RealmSwift
import RxSwift

protocol FeedRepositoryProtocol: BaseApiRepositoryProtocol {
    
    func refreshCategories() -> Single<Void>
    func getCategories() -> Observable<[FeedCategory]>
    
    func refreshFeedElements(page: Int?, userID: Int?) -> Single<Void>
    func getFeedElements(userID: Int?) -> Observable<[RealmFeedElement]>
    func refreshMyFeedElements(page: Int?) -> Single<Void>
    func getMyFeedElements() -> Observable<[RealmFeedElement]>
    func getFeedElements(categoryID: Int?, userID: Int?) -> Observable<[RealmFeedElement]>
    func refreshFeedElements(offset: Int?, categoryID: Int?, userID: Int?) -> Single<Void>
    
    func createFeedElement(mediafile: Int, preview: Int?) -> Single<Void>
    
    func switchLike(feedID: Int) -> Single<Void>
    func switchCategorySubscribe(categoryID: Int) -> Single<Void> 
    
}
