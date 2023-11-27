import Foundation

enum AppError: Error {
    case server
    case network
}

protocol HTTPClient {
    func post(from url: URL, body: Data) async throws -> Data
}

final class URLSessionHTTPClient: HTTPClient {
    private let urlSession: URLSession
    private let authorizationKey: String
    
    init(
        urlSession: URLSession = .shared,
        authorizationKey: String = .openAIKey
    ) {
        self.urlSession = urlSession
        self.authorizationKey = authorizationKey
    }
    
    func post(from url: URL, body: Data) async throws -> Data {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = body
        urlRequest.allHTTPHeaderFields = [
            "Authorization": "Bearer \(authorizationKey)",
            "Content-Type": "application/json"
        ]
        do {
            let (data, response) = try await urlSession.data(for: urlRequest)
//            let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
//            print(json)
            
            guard let response = response as? HTTPURLResponse,
                  (200 ... 299).contains(response.statusCode)  else {
                throw AppError.server
            }
            
            return data
        } catch let error as AppError {
            throw error
        } catch {
            throw AppError.network
        }
    }
}
