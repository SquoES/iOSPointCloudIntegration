import UIKit

class GridCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    private var contentSize: CGSize = .zero
    private var itemsAttributes: [IndexPath: UICollectionViewLayoutAttributes] = .init()
    
    var itemsPerLine: Int = 2 { didSet { invalidateLayout() } }
    var itemHeight: ItemHeight = .equal { didSet { invalidateLayout() } }
    
    var horizontalItemsSpacing: CGFloat = .zero { didSet { invalidateLayout() } }
    var verticalItemsSpacing: CGFloat = .zero { didSet { invalidateLayout() } }
    
    override var collectionViewContentSize: CGSize {
        contentSize
    }
    
    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else {
            return
        }
        
        let itemWidth: CGFloat = (collectionView.frame.width - horizontalItemsSpacing * CGFloat(itemsPerLine - 1)) / CGFloat(itemsPerLine)
        let itemHeight: CGFloat = itemHeight.itemHeight(forItemWidth: itemWidth)
        
        var y: CGFloat = .zero
        var itemsExists: Bool = false
        
        for section in 0..<collectionView.numberOfSections {
            for row in 0..<collectionView.numberOfItems(inSection: section) {
                
                let indexPath = IndexPath(row: row, section: section)
                
                let x = CGFloat(row % itemsPerLine) * (itemWidth + horizontalItemsSpacing)
                y = CGFloat(row / itemsPerLine) * (itemHeight + verticalItemsSpacing)
                
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = CGRect(x: x, y: y,
                                          width: itemWidth,
                                          height: itemHeight)
                itemsAttributes[indexPath] = attributes
                
                itemsExists = true
            }
        }
        
        contentSize = .init(width: collectionView.frame.width,
                            height: itemsExists ? y + itemHeight : .zero)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        itemsAttributes.values.filter { $0.frame.intersects(rect) }
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        itemsAttributes[indexPath]
    }
    
}

extension GridCollectionViewFlowLayout {
    
    enum ItemHeight {
        case equal
        case aspect(CGFloat)
        case scaledAspect(width: CGFloat, height: CGFloat)
        
        private var aspect: CGFloat {
            switch self {
            case .equal:
                return 1.0
                
            case let .aspect(aspect):
                return aspect
                
            case let .scaledAspect(width, height):
                return height / width
            }
        }
        
        fileprivate func itemHeight(forItemWidth itemWidth: CGFloat) -> CGFloat {
            return itemWidth * aspect
        }
    }
    
}
