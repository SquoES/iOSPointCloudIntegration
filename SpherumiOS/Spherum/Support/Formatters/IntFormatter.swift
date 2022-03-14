import Foundation

class IntFormatter {
    static func toAbbreviatedLargeNumberFormat(_ originalNumber: Int?) -> String {
        guard let originalNumber = originalNumber else {
            return "0"
        }

        if isBillion(originalNumber) {
            return toBillionAbbreviatedFormat(originalNumber)
        }
        
        if isMillion(originalNumber) {
            return toMillionAbbreviatedFormat(originalNumber)
        }
        
        if isThousand(originalNumber) {
            return toThousandAbbreviatedFormat(originalNumber)
        }
        
        return originalNumber.toString()
    }
    
    static func toMaxSymbolsCountFormat(_ originalNumber: Int) -> String {
        return "Max \(originalNumber) symbols"
    }
    
    private static func isBillion(_ number: Int) -> Bool {
        return number/Constants.billion != .zero
    }
    private static func isMillion(_ number: Int) -> Bool {
        return number/Constants.million != .zero
    }
    private static func isThousand(_ number: Int) -> Bool {
        return number/Constants.thousand != .zero
    }
    
    private static func toBillionAbbreviatedFormat(_ number: Int) -> String {
        return "\((number.toDouble()/Constants.billion.toDouble()).clean)b"
    }
    private static func toMillionAbbreviatedFormat(_ number: Int) -> String {
        return "\((number.toDouble()/Constants.million.toDouble()).clean)m"
    }
    private static func toThousandAbbreviatedFormat(_ number: Int) -> String {
        return "\((number.toDouble()/Constants.thousand.toDouble()).clean)k"
    }
}

private enum Constants {
    static let billion  = 1_000_000_000
    static let million  = 1_000_000
    static let thousand = 1_000
}
