//___FILEHEADER___

import UIKit

extension UITableView {
    
    func registerCells<T: UITableViewCell>(_ cellNibs: T.Type...) {
        _ = cellNibs.map { self.registerReusedCell(cellNib: $0) }
    }
    
    private func registerReusedCell<T: UITableViewCell>(cellNib: T.Type) {
        let nib = UINib(nibName: cellNib.dequeueIdentifier, bundle: nil)
        self.register(nib, forCellReuseIdentifier: cellNib.dequeueIdentifier)
    }
    
    func dequeueReusable<T: UITableViewCell>(cellNib: T.Type, indexPath: IndexPath? = nil) -> T? {
        if let indexPath = indexPath {
            return self.dequeueReusableCell(withIdentifier: cellNib.dequeueIdentifier, for: indexPath) as? T
        } else {
            return self.dequeueReusableCell(withIdentifier: cellNib.dequeueIdentifier) as? T
        }
    }
    
    // Remove the separator lines of blank cells at the bottom of tableView.
    func removeBottomSeparatorLine() {
        self.tableFooterView = UIView(frame: CGRect.zero)
    }
    
}

extension UITableView {
    
    func items<Element>(_ builder: @escaping (UITableView, IndexPath, Element) -> UITableViewCell) -> ([Element]) -> Void {
        let dataSource = CombineTableViewDataSource(builder: builder)
        return { items in
            dataSource.pushElements(items, to: self)
        }
    }
    
}

extension UITableViewCell {
    
    static var dequeueIdentifier: String {
        return String(describing: self)
    }
    
}
