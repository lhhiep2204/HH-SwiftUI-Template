//___FILEHEADER___

import Foundation

enum NetworkError: Error {
    case invalidUrl
    case invalidParams
    case invalidResponse
    case error(Int)
    case others(String)
}

extension NetworkError {
    
    var message: String {
        switch self {
        case .invalidUrl:
            return "Invalid URL"
        case .invalidParams:
            return "Invalid Params"
        case .invalidResponse:
            return "Invalid response"
        case .error(let errorCode):
            return handleErrorCode(errorCode)
        case .others(let errorMessage):
            return errorMessage
        }
    }
    
    private func handleErrorCode(_ errorCode: Int) -> String {
        switch errorCode {
        case 401:
            return "Unauthorized"
        case 403:
            return "Request forbidden"
        case 404:
            return "Request not found"
        default:
            return String(HTTPURLResponse.localizedString(forStatusCode: errorCode))
        }
    }
    
}
