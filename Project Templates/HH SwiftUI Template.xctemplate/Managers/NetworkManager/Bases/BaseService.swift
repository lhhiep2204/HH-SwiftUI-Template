//___FILEHEADER___

import Combine
import Foundation

/// A protocol defining the base structure for network service interactions.
public protocol BaseService {
    /// Makes a generic network request and returns a Combine publisher for the specified response type.
    ///
    /// - Parameter request: The request to be sent.
    /// - Returns: A publisher for the decoded response or a network error.
    func makeRequest<T: Decodable>(request: BaseRequest) -> AnyPublisher<T, NetworkError>
}

public extension BaseService {
    func makeRequest<T: Decodable>(request: BaseRequest) -> AnyPublisher<T, NetworkError> {
        return makeRequest(request: request, retryCount: 3)
    }
}

extension BaseService {
    private func makeRequest<T: Decodable>(request: BaseRequest, retryCount: Int = 3) -> AnyPublisher<T, NetworkError> {
        guard let urlRequest = createURLRequest(from: request) else {
            return Fail(error: .invalidUrl)
                .eraseToAnyPublisher()
        }

        return session
            .dataTaskPublisher(for: urlRequest)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw NetworkError.invalidResponse
                }

                let statusCode = httpResponse.statusCode
                guard (200...299).contains(statusCode) else {
                    switch statusCode {
                    case 401 where retryCount != 0:
                        throw NetworkError.unauthorized
                    default:
                        throw NetworkError.errorCode(statusCode)
                    }
                }

                self.httpResponseLogger(data, response)

                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .mapError { mapNetworkError($0) }
            .catch { error -> AnyPublisher<T, NetworkError> in
                guard case .unauthorized = error else {
                    return Fail(error: error)
                        .eraseToAnyPublisher()
                }

                return refreshToken()
                    .flatMap { makeRequest(request: request, retryCount: retryCount - 1) }
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }

    private func refreshToken() -> AnyPublisher<Void, NetworkError> {
        guard let urlRequest = createURLRequest(from: RefreshTokenRequest()) else {
            return Fail(error: .invalidUrl)
                .eraseToAnyPublisher()
        }

        return session
            .dataTaskPublisher(for: urlRequest)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw NetworkError.invalidResponse
                }

                let statusCode = httpResponse.statusCode
                guard (200...299).contains(statusCode) else {
                    throw NetworkError.errorCode(statusCode)
                }

                // TODO: Update access token
                /// do {
                ///     let tokenInfo = try JSONDecoder().decode(TokenInfo.self, from: data)
                ///     print("\(tokenInfo)")
                /// } catch {
                ///     throw NetworkError.invalidResponse
                /// }
            }
            .receive(on: DispatchQueue.main)
            .mapError { mapNetworkError($0) }
            .eraseToAnyPublisher()
    }

    private var session: URLSession {
        let configuration = URLSessionConfiguration.default
        // Configure the session if needed
        return URLSession(configuration: configuration)
    }

    private func createURLRequest(from request: BaseRequest) -> URLRequest? {
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
        case .post, .put, .patch, .delete:
            if let body = request.body {
                do {
                    urlRequest.httpBody = try JSONEncoder().encode(body)
                } catch {
                    print("JSON encoding error:", error)
                    return nil
                }
            }
        }

        httpRequestLogger(urlRequest)

        return urlRequest
    }

    private func mapNetworkError(_ error: Error) -> NetworkError {
        return (error as? NetworkError) ?? .description(error.localizedDescription)
    }
}

#if DEBUG
private extension BaseService {
    /// Log details of an HTTP request.
    ///
    /// - Parameter request: The URLRequest to be logged.
    func httpRequestLogger(_ request: URLRequest) {
        var output = "🟡 Request:\n"
        var curl = ""

        if let url = request.url {
            output += "- URL: \(url)\n"
            curl += "curl -v '\(url.absoluteString)'"
        }

        if let method = request.httpMethod {
            output += "- Method: \(method)\n"
            curl += " -X \(method)"
        }

        if let headers = request.allHTTPHeaderFields {
            output += "- Headers:\n"
            for (key, value) in headers {
                output += " -H '\(key): \(value)'\n"
                curl += " -H '\(key): \(value)'"
            }
        }

        if let httpBody = request.httpBody, let bodyString = String(data: httpBody, encoding: .utf8) {
            output += "- Body: \(bodyString)\n"
            curl += " -d '\(bodyString)'"
        }

        print(output)
        print(curl + "\n")
    }

    /// Log details of an HTTP response.
    ///
    /// - Parameters:
    ///   - data: The response data.
    ///   - response: The URLResponse to be logged.
    func httpResponseLogger(_ data: Data,
                            _ response: URLResponse) {
        var output = "🟢 Response:\n"

        if let httpResponse = response as? HTTPURLResponse {
            if let url = httpResponse.url {
                output += "- URL: \(url)\n"
            }

            output += "- Status code: \(httpResponse.statusCode)\n"
            if let headers = httpResponse.allHeaderFields as? [String: Any] {
                output += "- Response Headers:\n"
                for (key, value) in headers {
                    output += " -H '\(key): \(value)'\n"
                }
            }
        }

        if let responseString = String(data: data, encoding: .utf8) {
            output += "- Response Data: \(responseString)\n"
        }

        print(output)
    }
}
#endif
