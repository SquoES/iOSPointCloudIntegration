import Foundation
import RxSwift
import RxSwiftExt
import Alamofire
import RxAlamofireWrapper
import RealmSwift
import RxRealm
import CleanMapper

protocol BaseApiRepositoryProtocol { }

extension BaseApiRepositoryProtocol {
    
    func uploadRequest(_ router: URLConvertible, method: HTTPMethod, formData: MultipartFormData, query: [String: Any] = [:]) -> Single<Void> {
        return .create { observer in
            
            let request = AlamofireWrapper.shared.uploadRequest(router, method: method, formData: formData, onSuccess: { _ in
                observer(.success(()))
            }, onStateChanged: { state in
                print(state)
            }, onError: { error in
                observer(.error(error))
            })
            
            return Disposables.create {
                request.cancel()
            }
        }
//        return AlamofireWrapper.shared.uploadRequest(router, method: method, formData: formData, queryParameters: query)
    }
    
    func uploadRequest<Response: Codable>(_ router: URLConvertible, method: HTTPMethod, formData: MultipartFormData, query: [String: Any] = [:]) -> Single<Response> {
        let data: Single<Data> = AlamofireWrapper.shared.uploadRequest(router, method: method, formData: formData, queryParameters: query)
        
        return data.map({ data in
            return try JSONDecoder().decode(Response.self, from: data)
        })
    }
    
    func request(_ router: URLConvertible, method: HTTPMethod, json: [String: Any]? = nil, query: [String: Any] = [:]) -> Single<Void> {
        return AlamofireWrapper.shared.dataRequest(router,
                                                   method: method,
                                                   json: json,
                                                   queryParameters: query)
    }
    
    func request<Response: Codable>(_ router: URLConvertible, method: HTTPMethod, json: [String: Any]? = nil, query: [String: Any] = [:]) -> Single<Response> {
        let data: Single<Data> = AlamofireWrapper.shared.dataRequest(router,
                                                                     method: method,
                                                                     json: json,
                                                                     queryParameters: query)
        return data.map({ data in
            return try JSONDecoder().decode(Response.self, from: data)
        })
    }
    
    func request(_ router: URLConvertible, method: HTTPMethod, json: [String: Any]? = nil, query: [String: Any] = [:]) -> Single<Data> {
        return AlamofireWrapper.shared.dataRequest(router,
                                                   method: method,
                                                   json: json,
                                                   queryParameters: query)
    }
    
    func downloadFile(from url: URL, named fileName: String, progressHandler: @escaping (Double) -> Void) -> Single<URL?> {
        
        .create { observer in
            
            let destination: DownloadRequest.Destination = { _, _ in
                var destinationURL = URL(fileURLWithPath: NSTemporaryDirectory())
                destinationURL.appendPathComponent(fileName)
                
                return (destinationURL, [.removePreviousFile])
            }
            
            Alamofire.Session.default.sessionConfiguration.timeoutIntervalForRequest = 50_000
            
            let request = Alamofire.Session.default.download(url, to: destination)
                .downloadProgress(closure: { progress in
                    progressHandler(progress.fractionCompleted)
                    print("download progress:", progress.fractionCompleted)
                })
                .responseData { response in
                    observer(.success(response.fileURL))
                }
            
            return Disposables.create {
                request.cancel()
            }
            
        }
        
    }
    
    private func tryMap<Target, Result>(_ target: Target?) -> Result? {
        guard let target = target else {
            return nil
        }
        let result: Result = Mapper.map(target)
        return result
    }
    private func mapCollection<TC: Collection, T, R>(_ target: TC) -> [R] where TC.Element == T {
        return Mapper.map(target)
    }
    
    func observableCollection<O: Object, R>(_ type: O.Type, mappedTo resultType: R.Type, from realm: Realms) -> Observable<[R]> {
        let objects = realm.create().objects(type)
        return Observable.collection(from: objects).map(mapCollection)
    }
    func observableCollection<O: Object, R>(_ type: O.Type, mappedTo resultType: R.Type, from realm: Realms, sortedByKey key: String, ascending: Bool = true) -> Observable<[R]> {
        let objects = realm.create().objects(type).sorted(byKeyPath: key, ascending: ascending)
        return Observable.collection(from: objects).map(mapCollection)
    }
    func observableCollection<O: Object, R>(_ type: O.Type, mappedTo resultType: R.Type, filteredBy filter: @escaping (O) -> Bool, from realm: Realms) -> Observable<[R]> {
        let objects = realm.create().objects(type)
        return Observable.collection(from: objects)
            .map({ $0.filter(filter) })
            .map(mapCollection)
    }
    func observableCollection<O: Object>(_ type: O.Type, filteredBy filter: @escaping (O) -> Bool, from realm: Realms) -> Observable<[O]> {
        let objects = realm.create().objects(type)
        return Observable.collection(from: objects)
            .map({ $0.filter(filter) })
    }
    func observableCollection<O: Object, R>(_ type: O.Type, mappedTo resultType: R.Type, filteredUsing predicate: NSPredicate, from realm: Realms) -> Observable<[R]> {
        let objects = realm.create().objects(type).filter(predicate)
        return Observable.collection(from: objects).map(mapCollection)
    }
    
    func observableCollection<O: Object>(_ type: O.Type, filteredUsing predicate: NSPredicate, from realm: Realms) -> Observable<Results<O>> {
        let objects = realm.create().objects(type).filter(predicate)
        return Observable.collection(from: objects)
    }
    
    func observableElementById<O: Object, R>(_ type: O.Type, mappedTo resultType: R.Type, id: Int, from realm: Realms) -> Observable<R?> {
        let predicate = NSPredicate(format: "id = %ld", id)
        let objects = realm.create().objects(O.self).filter(predicate)
        let observableElement: Observable<R?> = Observable.collection(from: objects).map({ objects in
            guard let object = objects.first else {
                return nil
            }
            return tryMap(object)
        })
        return observableElement
    }
    
    func observableCollection<O: Object>(type: O.Type, from realm: Realms, by keyPath: String? = nil, ascending: Bool = true) -> Observable<[O]> {
        var objects = realm.create().objects(type)
        if let keyPath = keyPath {
            objects = objects.sorted(byKeyPath: keyPath, ascending: ascending)
        }
        return Observable.array(from: objects)
    }
    
    func observableElementById<O: Object>(_ type: O.Type, id: Int, from realm: Realms) -> Observable<O?> {
        let predicate = NSPredicate(format: "id = %ld", id)
        let objects = realm.create().objects(O.self).filter(predicate)
        return Observable.collection(from: objects).map { $0.first }
    }
    
    // MARK: - LOCAL
    func store<T: Object>(singleValue: T, in realm: Realms) {
        realm.invoke({ realm in
            realm.deleteAll(T.self)
            realm.add(singleValue)
        })
    }
    func store<T: Object>(value: T, in realm: Realms) {
        realm.invoke({ realm in
            if T.primaryKey() == nil {
                realm.add(value)
            } else {
                realm.add(value, update: .all)
            }
        })
    }
    func store<T: Object, S: Sequence>(values: S, replacing: Bool = false, in realm: Realms) where S.Element == T {
        realm.invoke({ realm in
            if replacing {
                realm.deleteAll(T.self)
            }
            if T.primaryKey() == nil {
                realm.add(values)
            } else {
                realm.add(values, update: .all)
            }
        })
    }
    
    func change<T: Object>(firstOfType type: T.Type, predicate: NSPredicate, in realm: Realms, changes: @escaping (T) -> Void) {
        realm.invoke({ realm in
            guard let item = realm.objects(T.self).filter(predicate).first else { return }
            changes(item)
        })
    }
    
    func delete<T: Object>(allOfType type: T.Type, predicate: NSPredicate? = nil, in realm: Realms) {
        realm.invoke({ realm in
            var items = realm.objects(T.self)
            if let predicate = predicate { items = items.filter(predicate) }
            realm.delete(items)
        })
    }
    
}
