//___FILEHEADER___

import Foundation

enum NewsRequest {
    case getNews(topic: String)
}

extension NewsRequest: BaseRequest {
    
    var endpoint: String {
        return Endpoint.News.everything
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var header: [String : String]? {
        return ["Authorization": "Bearer " + Configs.API_KEY]
    }
    
    var body: [String : String]? {
        switch self {
        case .getNews(let topic):
            return [
                "q": topic,
                "pageSize": "20"
            ]
        }
    }
    
}
