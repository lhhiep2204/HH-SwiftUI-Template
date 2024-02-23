//___FILEHEADER___

import Foundation

// MARK: - HTTPMethod Enum
/// An enumeration representing various HTTP methods.
public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

// MARK: - BaseRequest Protocol
/// A protocol defining the basic structure for a network request.
public protocol BaseRequest {
    var baseURL: String { get }
    var endpoint: String { get }
    var method: HTTPMethod { get }
    var header: [String: String]? { get }
    var body: [String: String]? { get }
}

public extension BaseRequest {
    var baseURL: String {
        Configs.API.baseURL
    }

    var header: [String: String]? {
        nil
    }

    var body: [String: String]? {
        nil
    }
}

struct RefreshTokenRequest: BaseRequest {
    var baseURL: String {
        // TODO: Replace with the project's base URL
        "https://example-api.com/"
    }

    var endpoint: String {
        // TODO: Replace with the specific endpoint for refreshing tokens in the project
        "sampleEndpoint"
    }

    var method: HTTPMethod {
        .post
    }

    var body: [String : String]? {
        // TODO: Replace both the key and value with the actual refresh token parameter and value in your project
        ["refresh_token": "refreshToken"]
    }
}
