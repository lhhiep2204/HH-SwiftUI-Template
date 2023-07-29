//___FILEHEADER___

import Combine
import Foundation

protocol BaseService {
    func makeRequest<T: Decodable>(request: BaseRequest) -> AnyPublisher<T, NetworkError>
}

extension BaseService {
    
    func makeRequest<T: Decodable>(request: BaseRequest) -> AnyPublisher<T, NetworkError> {
        guard let urlRequest = urlRequest(request) else {
            return Fail(error: NetworkError.invalidUrl).eraseToAnyPublisher()
        }
        
        return URLSession.shared
            .dataTaskPublisher(for: urlRequest)
            .tryMap {
                guard let statusCode = ($0.response as? HTTPURLResponse)?.statusCode else {
                    throw NetworkError.invalidResponse
                }
                
                switch statusCode {
                case 200...299:
                    return $0.data
                default:
                    throw NetworkError.error(statusCode)
                }
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .mapError({ error in
                return (error as? NetworkError) ?? NetworkError.others(error.localizedDescription)
            })
            .eraseToAnyPublisher()
    }
    
    private func urlRequest(_ request: BaseRequest) -> URLRequest? {
        guard let url = URL(string: request.baseURL + request.endpoint) else {
            return nil
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.header
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        switch request.method {
        case .get:
            var urlComponent = URLComponents(url: url, resolvingAgainstBaseURL: true)
            urlComponent?.queryItems = request.body?.map { URLQueryItem(name: $0, value: $1) }
            urlRequest.url = urlComponent?.url
        case .post, .put:
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: request.body ?? [:])
            } catch let error {
                print("urlRequest error", error.localizedDescription)
                return nil
            }
        }
        
        return urlRequest
    }
    
}
