import Foundation

extension URL {
    
    static var legalInformation: URL {
        Bundle.main.url(forResource: "Legal Information", withExtension: "txt")!
    }
    
    static var termsAndPolicies: URL {
        Bundle.main.url(forResource: "Terms and Policies", withExtension: "txt")!
    }
    
}
