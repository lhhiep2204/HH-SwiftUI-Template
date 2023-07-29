//___FILEHEADER___

import Combine
import Foundation

protocol INewsService {
    func getNews(topic: String) -> AnyPublisher<News, NetworkError>
}

struct NewsService: BaseService, INewsService {
    
    func getNews(topic: String) -> AnyPublisher<News, NetworkError> {
        return makeRequest(request: NewsRequest.getNews(topic: topic))
    }
    
}
