//___FILEHEADER___

import Foundation

extension String {
    
    static let empty = ""
    
    var trim: String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
}

extension String {
    
    func toDate(dateFormat: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.date(from: self)
    }
    
}
