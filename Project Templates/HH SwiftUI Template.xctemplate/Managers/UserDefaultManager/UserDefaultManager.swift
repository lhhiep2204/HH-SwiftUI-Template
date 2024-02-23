//___FILEHEADER___

import Foundation

class UserDefaultManager {
    public class var isLogin: Bool? {
        get {
            return UserDefaults.get(forKey: UserDefaultKey.isLogin) as? Bool
        }
        set {
            UserDefaults.set(newValue, forKey: UserDefaultKey.isLogin)
        }
    }
}
