import Foundation
import RxSwift
import CleanMapper
import RealmSwift
import Alamofire
import SwiftUI

class FeedRepository: FeedRepositoryProtocol {
    
    func refreshCategories() -> Single<Void> {
        self.request(ApiRouter.categories, method: .get).map(processRefreshCategories)
    }
    
    func getCategories() -> Observable<[FeedCategory]> {
        return self.observableCollection(RealmFeedCategory.self, mappedTo: FeedCategory.self, from: .feed)
    }
    
    func refreshFeedElements(page: Int? = nil, userID: Int? = nil) -> Single<Void> {
        var query: [String: Any] = [:]
        
        if let offset = page {
            query[JSONFieldConstants.offset] = offset
        }
        
        if let userID = userID {
            query[JSONFieldConstants.user] = userID
        }
        
        return self.request(ApiRouter.feeds, method: .get, query: query).map(processRefreshFeed)
    }
    
    func getFeedElements(userID: Int? = nil) -> Observable<[RealmFeedElement]> {
        
        if let userID = userID {
            
            return self.observableCollection(RealmFeedElement.self,
                                             filteredBy: { $0.user?.id == userID },
                                             from: .feed)
        }
        
        return self.observableCollection(type: RealmFeedElement.self,
                                         from: .feed,
                                         by: "id",
                                         ascending: false)
    }
    
    func refreshMyFeedElements(page: Int? = nil) -> Single<Void> {
        
        var query: [String: Any] = [:]
        
        if let offset = page {
            query[JSONFieldConstants.offset] = offset
        }
        
        return self.request(ApiRouter.myFeed, method: .get, query: query)
            .map(processRefreshMyFeedElements)
    }
    
    func getMyFeedElements() -> Observable<[RealmFeedElement]> {
        return self.observableCollection(type: RealmFeedElement.self, from: .myFeed)
    }
    
    func refreshFeedElements(offset: Int?, categoryID: Int?, userID: Int?) -> Single<Void> {
        var query: [String : Any] = [:]
        
        if let offset = offset {
            query["offset"] = offset
        }
        
        if let categoryID = categoryID {
            query["category"] = categoryID
        }
        
        if let userID = userID {
            query["user"] = userID
        }
        
        return self.request(ApiRouter.feeds, method: .get, query: query)
            .map(processRefreshFeed)
    }
    
    func getFeedElements(categoryID: Int?, userID: Int?) -> Observable<[RealmFeedElement]> {
        return observableCollection(RealmFeedElement.self, filteredBy: { feed in
            return feed.category == categoryID
        }, from: .feed)
    }
    
    func createFeedElement(mediafile: Int, preview: Int?) -> Single<Void> {
        var json: [String: Any] = [
            "mediafile": mediafile,
            "category": 1
        ]
        
        if let preview = preview {
            json["preview"] = preview
        }
        
        return self.request(ApiRouter.feeds,
                            method: .post,
                            json: json).map(processCreateFeedElement(feedElement:))
    }
    
    func switchLike(feedID: Int) -> Single<Void> {
        return self.request(ApiRouter.likeFeed(feedID: feedID), method: .post)
            .map(processLikeFeed)
    }
    
    func switchCategorySubscribe(categoryID: Int) -> Single<Void> {
        return self.request(ApiRouter.subscribeCategory(categoryID: categoryID), method: .post)
            .map(processSwitchCategorySubscribe)
        
    }
        
}

fileprivate extension FeedRepository {
    
    func processRefreshCategories(_ categories: PageElements<FeedCategory>) {
        let realmFeedCategories: [RealmFeedCategory] = categories.results.map(Mapper.map)
        
        self.store(values: realmFeedCategories, replacing: true, in: .feed)
    }
    
    func processRefreshFeed(_ feed: PageElements<FeedElement>) {
        let realmFeedElements: [RealmFeedElement] = feed.results.map(Mapper.map)
        self.store(values: realmFeedElements, in: .feed)
        
        let users = feed.results.compactMap { $0.user }
        let uniqueUsers = Set(users)
        let realmUsers: [RealmUserRetrieve] = uniqueUsers.map(Mapper.map)
        self.store(values: realmUsers, in: .users)
    }
    
    func processRefreshMyFeedElements(_ feed: PageElements<FeedElement>) {
        let realmFeedElements: [RealmFeedElement] = feed.results.map(Mapper.map)
        
        self.store(values: realmFeedElements, in: .myFeed)
    }
    
    func processLikeFeed(_ feedElement: FeedElement) {
        let realmFeedelement: RealmFeedElement = Mapper.map(feedElement)
        
        self.store(value: realmFeedelement, in: .feed)
    }
    
    func processSwitchCategorySubscribe(_ category: FeedCategory) {
        let  realmFeedCategory: RealmFeedCategory = Mapper.map(category)
        
        self.store(value: realmFeedCategory, in: .feed)
    }
    
    func processCreateFeedElement(feedElement: FeedElement) {
        let realmFeedElement: RealmFeedElement = Mapper.map(feedElement)
        
        self.store(value: realmFeedElement, in: .feed)
    }
    
}
