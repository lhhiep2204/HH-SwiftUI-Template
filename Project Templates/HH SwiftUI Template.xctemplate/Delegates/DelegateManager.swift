//___FILEHEADER___

import UIKit

final class DelegateManager {
    
    // MARK: - Properties
    static let shared = DelegateManager()
    
}

// MARK: - Methods
extension DelegateManager {
    
    func configure() {
        self.setRootViewController(LoginViewController(LoginViewModel()))
    }
    
    func setRootViewController(_ viewController: UIViewController,
                               navigationBarHidden: Bool = true) {
        let window = SceneDelegate.shared?.window
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.setNavigationBarHidden(navigationBarHidden, animated: true)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
}
