//___FILEHEADER___

import UIKit

class BaseTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    func configure<T>(data: T) {}
    func configure<T>(data: T, indexPath: IndexPath) {}

}
