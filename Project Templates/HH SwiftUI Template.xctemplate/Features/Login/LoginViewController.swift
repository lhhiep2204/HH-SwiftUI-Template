//___FILEHEADER___

import Combine
import UIKit

class LoginViewController: BaseViewController<LoginViewModel> {
    
    // MARK: - Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    // MARK: - Properties
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Override methods
    override func bindViewToViewModel() {
        self.emailTextField.publisher
            .assign(to: \.email, on: self.viewModel)
            .store(in: &self.subscriptions)
        
        self.passwordTextField.publisher
            .assign(to: \.password, on: self.viewModel)
            .store(in: &self.subscriptions)
    }
    
    override func bindViewModelToView() {
        self.viewModel.$email
            .assign(to: \.text, on: self.emailTextField)
            .store(in: &self.subscriptions)
        
        self.viewModel.$password
            .assign(to: \.text, on: self.passwordTextField)
            .store(in: &self.subscriptions)
        
        self.viewModel.validatedCredentials
            .assign(to: \.isEnabled, on: self.loginButton)
            .store(in: &self.subscriptions)
        
        self.viewModel.state
            .sink { [weak self] state in
                guard let self = self else { return }
                
                CommonManager.hideLoading()
                switch state {
                case .loginSuccess:
                    self.loginSuccess()
                case .error(let message):
                    self.showAlert(title: "Error", message: message)
                default: break
                }
            }
            .store(in: &self.subscriptions)
    }
    
}

// MARK: - Methods
extension LoginViewController {
    
    private func loginSuccess() {
        self.showAlert(title: "Login success!")
    }
    
}

// MARK: - Actions
extension LoginViewController {
    
    @IBAction func actionLogin(_ sender: Any) {
        CommonManager.showLoading()
        self.viewModel.action.send(.login)
    }
    
}
