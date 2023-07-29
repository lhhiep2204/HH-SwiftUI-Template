//___FILEHEADER___

import Combine
import UIKit

class BaseViewController<VM: BaseViewModel>: UIViewController {
    
    // MARK: - Properties
    var subscriptions = Set<AnyCancellable>()
    var viewModel: VM
    
    init(_ viewModel: VM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.bindViewToViewModel()
        self.bindViewModelToView()
    }
    
    func bindViewToViewModel() { }
    
    func bindViewModelToView() { }

}

