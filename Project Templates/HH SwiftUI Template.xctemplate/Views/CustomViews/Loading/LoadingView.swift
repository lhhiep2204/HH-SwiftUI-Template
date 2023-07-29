//___FILEHEADER___

import UIKit

class LoadingView: UIView {
    
    // MARK: - Outlets
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    // MARK: - Constructors
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0,
                                 y: 0,
                                 width: UIScreen.main.bounds.width,
                                 height: UIScreen.main.bounds.height))
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(frame: CGRect(x: 0,
                                 y: 0,
                                 width: UIScreen.main.bounds.width,
                                 height: UIScreen.main.bounds.height))
        self.setupView()
    }
    
}

// MARK: - Methods
extension LoadingView {
    
    private func setupView() {
        Bundle.main.loadNibNamed("LoadingView", owner: self, options: nil)
        self.addSubview(self.contentView)
        self.contentView.frame = self.bounds
    }
    
}
