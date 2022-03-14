import UIKit

extension UICollectionView {
    
    func getLayout<L: UICollectionViewFlowLayout>(ofType type: L.Type) -> L {
        collectionViewLayout as! L
    }
    
}
