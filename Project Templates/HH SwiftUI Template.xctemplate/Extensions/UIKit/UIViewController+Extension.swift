//___FILEHEADER___

import Combine
import UIKit

// MARK: Navigation
extension UIViewController {
    
    func push(viewController: UIViewController, animated: Bool = true) {
        self.navigationController?.pushViewController(viewController, animated: animated)
    }
    
    func present(viewController: UIViewController, animated: Bool = true) {
        self.navigationController?.present(viewController, animated: animated)
    }
    
    func pop(animated: Bool = true) {
        self.navigationController?.popViewController(animated: animated)
    }
    
    func popTo(viewController: UIViewController, animated: Bool = true) {
        self.navigationController?.popToViewController(viewController, animated: animated)
    }
    
    func popToRoot(animated: Bool = true) {
        self.navigationController?.popToRootViewController(animated: animated)
    }
    
}

// MARK: - Alert
extension UIViewController {
    
    struct AlertAction {
        var title: String
        var style: UIAlertAction.Style
        
        static func action(title: String, style: UIAlertAction.Style = .default) -> AlertAction {
            return AlertAction(title: title, style: style)
        }
    }
    
    @discardableResult
    func showAlert(title: String, message: String? = nil, buttons: AlertAction...) -> AnyPublisher<String, Never> {
        let alert = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        
        return Future { resolve in
            if buttons.isEmpty {
                let buttonAction = UIAlertAction(title: "Close", style: .cancel)
                alert.addAction(buttonAction)
            } else {
                for item in buttons {
                    alert.addAction(UIAlertAction(title: item.title,
                                                            style: item.style,
                                                            handler: { _ in
                        resolve(.success(item.title))
                    }))
                }
            }
            
            self.present(alert, animated: true, completion: nil)
        }.handleEvents(receiveCancel: {
            self.dismiss(animated: true)
        }).eraseToAnyPublisher()
    }
    
}
