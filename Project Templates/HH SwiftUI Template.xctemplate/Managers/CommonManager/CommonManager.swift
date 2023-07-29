//___FILEHEADER___

import UIKit

class CommonManager {
    
    // MARK: - Properties
    private static var loadingView: LoadingView?
    
}

// MARK: - Loading
extension CommonManager {
    
    public class func showLoading() {
        if self.loadingView == nil {
            self.loadingView = LoadingView()
            if let window = UIApplication.shared.keyWindow,
               let loadingView = self.loadingView {
                window.addSubview(loadingView)
                
                loadingView.translatesAutoresizingMaskIntoConstraints = false
                
                let constraints = [loadingView.trailingAnchor.constraint(equalTo: window.trailingAnchor),
                                   loadingView.leadingAnchor.constraint(equalTo: window.leadingAnchor),
                                   loadingView.topAnchor.constraint(equalTo: window.topAnchor),
                                   loadingView.bottomAnchor.constraint(equalTo: window.bottomAnchor)]
                
                NSLayoutConstraint.activate(constraints)
            }
        }
    }
    
    public class func hideLoading() {
        self.loadingView?.removeFromSuperview()
        self.loadingView = nil
    }
    
}

// MARK: - URL
extension CommonManager {
    
    public class func openApplicationSettings() {
        CommonManager.openURL(UIApplication.openSettingsURLString)
    }
    
    public class func openURL(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }
        UIApplication.shared.open(url)
    }
    
}

// MARK: - Validation
extension CommonManager {
    
    public class func validate(input: String, pattern: Regex) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: pattern.rawValue, options: .caseInsensitive)
            let range = NSRange(location: 0, length: input.count)
            let result = regex.matches(in: input, options: [], range: range)
            if !result.isEmpty {
                return true
            }
        } catch {
            print("Regex error: \(error.localizedDescription)")
        }
        return false
    }
    
}
