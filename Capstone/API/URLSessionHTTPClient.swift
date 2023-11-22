import Foundation

struct HTTPStatusError: Error { }

protocol HTTPClient {
    func post(from url: URL, body: Data) async throws -> Data
}

final class URLSessionHTTPClient: HTTPClient {
    private let urlSession: URLSession
    private let authorizationKey: String
    
    init(
        urlSession: URLSession = .shared,
        authorizationKey: String = ""
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
        
        let (data, response) = try await urlSession.data(for: urlRequest)
        
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
            print(json)
        } catch {
            print("errorMsg")
        }
        
        guard let response = response as? HTTPURLResponse,
              (200 ... 299).contains(response.statusCode)  else {
            throw HTTPStatusError()
        }
        
        return data
    }
}
