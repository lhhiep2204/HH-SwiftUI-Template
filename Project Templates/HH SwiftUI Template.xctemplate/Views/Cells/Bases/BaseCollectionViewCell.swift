//___FILEHEADER___

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure<T>(data: T) {}
    func configure<T>(data: T, indexPath: IndexPath) {}

}
