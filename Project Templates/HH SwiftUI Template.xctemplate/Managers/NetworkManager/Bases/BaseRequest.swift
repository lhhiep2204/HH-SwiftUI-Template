//___FILEHEADER___

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
}

protocol BaseRequest {
    var baseURL: String { get }
    var endpoint: String { get }
    var method: HTTPMethod { get }
    var header: [String: String]? { get }
    var body: [String: String]? { get }
}

extension BaseRequest {
    
    var baseURL: String {
        return Configs.API.baseURL
    }
    
    var header: [String: String]? {
        return nil
    }
    
    var body: [String: String]? {
        return nil
    }
    
}
