//___FILEHEADER___

import UIKit

extension UIView {
    
    func rounded() {
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.masksToBounds = true
    }
    
    func configBorder(borderWidth: CGFloat = 1,
                      borderColor: UIColor = .clear,
                      cornerRadius: CGFloat = 14) {
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
    }
    
}
