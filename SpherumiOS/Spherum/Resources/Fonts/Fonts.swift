import UIKit

extension UIFont {
    
    static func gilroyFont(ofSize size: CGFloat, weight: UIFont.Weight) -> UIFont? {
        switch weight {
        case .black:
            return .init(name: "Gilroy-Black", size: size)

        case .bold:
            return .init(name: "Gilroy-Bold", size: size)

        case .heavy:
            return .init(name: "Gilroy-Heavy", size: size)

        case .medium:
            return .init(name: "Gilroy-Medium", size: size)

        case .regular:
            return .init(name: "Gilroy-Regular", size: size)

        case .semibold:
            return .init(name: "Gilroy-Semibold", size: size)

        case .thin:
            return .init(name: "Gilroy-Thin", size: size)

        case .ultraLight:
            return .init(name: "Gilroy-UltraLight", size: size)

        default:
            return nil
        }
    }
    
}
