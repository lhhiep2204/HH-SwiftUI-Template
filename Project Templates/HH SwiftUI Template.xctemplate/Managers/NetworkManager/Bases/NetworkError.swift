//___FILEHEADER___

import Foundation

/// An enumeration representing common network errors.
public enum NetworkError: Error {
    case invalidUrl
    case invalidResponse
    case unauthorized
    case errorCode(Int)
    case description(String)
}

public extension NetworkError {
    /// A computed property that returns a human-readable error message for each case.
    var message: String {
        switch self {
        case .invalidUrl: "Invalid URL"
        case .invalidResponse: "Invalid response"
        case .unauthorized: "Unauthorized"
        case .errorCode(let statusCode): "Response failed with status code - \(statusCode)"
        case .description(let errorMessage): errorMessage
        }
    }
}
