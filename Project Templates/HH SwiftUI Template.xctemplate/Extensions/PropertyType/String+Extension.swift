//___FILEHEADER___

import Foundation

public extension String {
    static let empty = ""

    var trim: Self {
        trimmingCharacters(in: .whitespacesAndNewlines)
    }

    func replace(_ target: String, with replacement: String) -> Self {
        self.replacingOccurrences(of: target, with: replacement)
    }
}

public extension String {
    /// Converts a string to a Date object using a specified date format.
    ///
    /// - Parameter dateFormat: The format in which the date is represented in the string.
    /// - Returns: A Date object if conversion is successful, otherwise nil.
    func toDate(dateFormat: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.date(from: self)
    }
}
