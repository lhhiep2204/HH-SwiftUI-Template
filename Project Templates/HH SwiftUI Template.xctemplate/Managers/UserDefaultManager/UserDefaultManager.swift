//___FILEHEADER___

import Foundation

class UserDefaultManager {

    public class func clearAllData() {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
    }
    
    public class var isLogin: Bool? {
        get {
            return UserDefaults.object(forKey: UserDefaultKey.isLogin) as? Bool
        }
        set {
            UserDefaults.setObject(newValue, forKey: UserDefaultKey.isLogin)
        }
    }
    
}
