

import Foundation

struct PageElements<Element: Codable >: Codable {
    
    let count: Int?
    let next: Int?
    let previous: Int?
    let results: [Element]
    
}

