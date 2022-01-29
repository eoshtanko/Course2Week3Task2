import UIKit

class CustomFlowLayout: UICollectionViewLayout {
    
    private var cache: [UICollectionViewLayoutAttributes] = []
    
    private var contentHeight: CGFloat = 0
    
    private var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        return collectionView.bounds.width
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
        guard
            cache.isEmpty == true,
            let collectionView = collectionView
        else {
            return
        }
        
        let columnWidth = contentWidth / CGFloat(Const.numberOfColumns)
        
        var xOffset: [CGFloat] = []
        for column in 0..<Const.numberOfColumns {
            xOffset.append(CGFloat(column) * columnWidth)
        }
        
        var yOffset: [CGFloat] = .init(repeating: 0, count: Const.numberOfColumns)
        yOffset[0] = -Const.itemSpacing / 2; yOffset[1] = -Const.itemSpacing / 2
        
        var column = 0
        
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            
            let photoHeight = item == 0 ? Const.firstPictureHight : Const.picturesHight
            
            let frame = CGRect(x: xOffset[column],
                               y: yOffset[column],
                               width: columnWidth,
                               height: photoHeight)
            
            let insetFrame = frame.insetBy(dx: Const.itemSpacing / 2, dy: Const.itemSpacing / 2)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            
            cache.append(attributes)
            
            contentHeight = frame.maxY
            yOffset[column] = yOffset[column] + photoHeight
            
            let nextColumn = column < Const.numberOfColumns - 1 ? column + 1 : 0
            column = yOffset[nextColumn] < yOffset[column] ? nextColumn : column
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes: [UICollectionViewLayoutAttributes] = []
        
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }
}

extension CustomFlowLayout {
    private enum Const {
        static let numberOfColumns = 2
        static let itemSpacing: CGFloat = 16
        static let firstPictureHight: CGFloat = 300 + Const.itemSpacing
        static let picturesHight: CGFloat = 200 + Const.itemSpacing
    }
}
