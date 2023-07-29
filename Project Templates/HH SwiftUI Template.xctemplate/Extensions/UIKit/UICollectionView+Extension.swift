//___FILEHEADER___

import UIKit

extension UICollectionView {
    
    func registerCells<T: UICollectionViewCell>(_ cellNibs: T.Type...) {
        _ = cellNibs.map { self.registerReusedCell(cellNib: $0) }
    }
    
    func registerReusedCell<T: UICollectionViewCell>(cellNib: T.Type, bundle: Bundle? = nil) {
        let nib = UINib(nibName: cellNib.dequeueIdentifier, bundle: bundle)
        self.register(nib, forCellWithReuseIdentifier: cellNib.dequeueIdentifier)
    }

    func dequeueReusable<T: UICollectionViewCell>(cellNib: T.Type, indexPath: IndexPath) -> T? {
        return self.dequeueReusableCell(withReuseIdentifier: cellNib.dequeueIdentifier, for: indexPath) as? T
    }
    
    func registerSupplementaryView<T: UICollectionReusableView>(supplementaryViewNib: T.Type, bundle: Bundle? = nil) {
        let nib = UINib(nibName: supplementaryViewNib.dequeueIdentifierView, bundle: bundle)
        self.register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: supplementaryViewNib.dequeueIdentifierView)
    }
    
    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(supplementaryViewNib: T.Type, indexPath: IndexPath) -> T? {
        return self.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: supplementaryViewNib.dequeueIdentifierView, for: indexPath) as? T
    }

}

extension UICollectionViewCell {

    static var dequeueIdentifier: String {
        return String(describing: self)
    }
    
}

extension UICollectionReusableView {
    
    static var dequeueIdentifierView: String {
        return String(describing: self)
    }
    
}
