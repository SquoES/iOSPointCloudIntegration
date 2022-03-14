import Foundation


struct FieldError {
    
    static let fieldsMapping: [String: String] = [:]
    
    static let messagesMapping: [String: String] = [:]
    
    let field: String
    let message: String
    
    func humanize() -> String {
        if let humanizeField = FieldError.fieldsMapping[field], let humanizeMessage = FieldError.messagesMapping[message] {
            return "\(humanizeField) \(humanizeMessage)"
        } else if field.isEmpty {
            return message
        } else {
            return "\(field) \(message)"
        }
    }
    
}
