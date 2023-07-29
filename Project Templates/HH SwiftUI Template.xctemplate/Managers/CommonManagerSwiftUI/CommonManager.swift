//___FILEHEADER___

import UIKit

class CommonManager {
    
    // MARK: - Properties
    
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
