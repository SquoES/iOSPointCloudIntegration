import Foundation
import RealmSwift

enum Realms: String, CaseIterable {
    
    case users
    case profile
    case feed
    case myFeed
    case myProfile
    case live
    
    static func deleteAll() {
        for realm in Self.allCases {
            let db = realm.create()
            try! db.write {
                db.deleteAll()
            }
        }
    }
    
    static func clear(_ realms: Realms...) {
        for realm in realms {
            realm.invoke({ realm in
                realm.deleteAll()
            })
        }
    }
    
    func invoke(_ writeAction: (Realm) -> Void) {
        let realm = create()
        try! realm.write {
            writeAction(realm)
        }
    }
    
    func create() -> Realm {
        return try! Realm(configuration: configuration)
    }
    
    private var configuration: Realm.Configuration {
        var configuration = Realm.Configuration.defaultConfiguration
        let fileURL = Realms.getFolderURL().appendingPathComponent("\(name).realm")
        configuration.fileURL = fileURL
        configuration.deleteRealmIfMigrationNeeded = true
        return configuration
    }
    
    private static func getFolderURL() -> URL {
        let folderURL = Realm.Configuration.defaultConfiguration.fileURL!.deletingLastPathComponent()
        
        if !FileManager.default.fileExists(atPath: folderURL.path) {
            try! FileManager.default.createDirectory(atPath: folderURL.path, withIntermediateDirectories: true, attributes: nil)
        }
        
        return folderURL
    }
    
    private var name: String {
        return self.rawValue
    }
}
