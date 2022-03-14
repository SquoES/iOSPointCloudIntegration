import Foundation
import UIKit

extension String {
    
    static let empty = ""
    
    static func string(originalString: String, usingTemplate templateString: String, templateSymbol: Character) -> String {
        var result = ""
        
        var nextOriginalStringIndex = originalString.startIndex
        var nextTemplateStringIndex = templateString.startIndex
        
        while nextOriginalStringIndex < originalString.endIndex && nextTemplateStringIndex < templateString.endIndex {
            if templateString[nextTemplateStringIndex] == templateSymbol {
                result.append(originalString[nextOriginalStringIndex])
                nextOriginalStringIndex = originalString.index(after: nextOriginalStringIndex)
            } else {
                result.append(templateString[nextTemplateStringIndex])
            }
            
            nextTemplateStringIndex = templateString.index(after: nextTemplateStringIndex)
        }
        
        return result
    }
    
    func date(using format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        return dateFormatter.date(from: self)
    }
    
    func textWidth(font: UIFont) -> CGFloat {
        let attributes = NSAttributedString( string: self, attributes: [.font: font])
        
        return attributes.boundingRect(with: .zero, options: .usesDeviceMetrics, context: nil).size.width
    }
    
    // MARK: - CONVERTERS
    func toData(using encoding: Encoding = .utf8) -> Data {
        return self.data(using: encoding) ?? Data()
    }
    
    
    
}
