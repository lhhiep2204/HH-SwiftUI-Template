//___FILEHEADER___

import Foundation

extension UserDefaults {

    class func object(forKey key: UserDefaultKey) -> Any? {
        let defaults = UserDefaults.standard

        let object = defaults.object(forKey: key.rawValue)
        return object
    }

    class func setObject(_ object: Any?, forKey key: UserDefaultKey) {
        let defaults = UserDefaults.standard

        defaults.set(object, forKey: key.rawValue)
        defaults.synchronize()
    }

    class func removeObject(forKey key: UserDefaultKey) {
        let defaults = UserDefaults.standard

        defaults.removeObject(forKey: key.rawValue)
        defaults.synchronize()
    }

}
