import Foundation
import SwiftyJSON

class JSONMapper {
    private let json: JSON
    
    convenience init(data: Data) {
        self.init(JSON(data))
    }
    init(_ json: JSON) {
        self.json = json
    }
    
    func mapString(key: String) -> String {
        return json[key].stringValue
    }
    func mapInt(key: String) -> Int {
        return json[key].intValue
    }
    func mapOptionalString(key: String) -> String? {
        return json[key].string
    }
    func mapBool(key: String) -> Bool {
        return json[key].boolValue
    }
}
