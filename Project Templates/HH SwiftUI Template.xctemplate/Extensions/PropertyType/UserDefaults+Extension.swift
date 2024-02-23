//___FILEHEADER___

import Foundation

public extension UserDefaults {
    /// Retrieves an object from UserDefaults for a given key.
    ///
    /// - Parameter key: The key associated with the stored object.
    /// - Returns: The stored object or nil if not found.
    class func get(forKey key: String) -> Any? {
        return standard.object(forKey: key)
    }

    /// Sets an object in UserDefaults for a given key.
    ///
    /// - Parameters:
    ///   - object: The object to be stored.
    ///   - key: The key to associate with the stored object.
    class func set(_ object: Any?, forKey key: String) {
        standard.set(object, forKey: key)
    }

    /// Retrieves and decodes an object of a specific type from UserDefaults for a given key.
    ///
    /// - Parameters:
    ///   - type: The type of the object to decode.
    ///   - key: The key associated with the stored object.
    /// - Returns: The decoded object or nil if not found or unable to decode.
    class func getObject<T: Codable>(type: T.Type, forKey key: String) -> T? {
        guard let data = get(forKey: key) as? Data else { return nil }

        do {
            return try JSONDecoder().decode(type, from: data)
        } catch {
            print("Error retrieving data in UserDefaults for key \(key): \(error)")
            return nil
        }
    }

    /// Encodes and sets an object in UserDefaults for a given key.
    ///
    /// - Parameters:
    ///   - value: The object to be encoded and stored.
    ///   - key: The key to associate with the stored object.
    class func setObject<T: Codable>(_ value: T, forKey key: String) {
        do {
            let data = try JSONEncoder().encode(value)
            set(data, forKey: key)
        } catch {
            print("Error setting data in UserDefaults for key \(key): \(error)")
        }
    }

    /// Removes an object from UserDefaults for a given key.
    ///
    /// - Parameter key: The key associated with the object to be removed.
    class func remove(forKey key: String) {
        standard.removeObject(forKey: key)
    }

    /// Removes all objects from UserDefaults.
    class func removeAllObjects() {
        if let bundleID = Bundle.main.bundleIdentifier {
            standard.removePersistentDomain(forName: bundleID)
        }
    }
}
