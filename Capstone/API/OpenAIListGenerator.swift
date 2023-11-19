//
//  OpenAIListGenerator.swift
//  Capstone
//
//  Created by Nicolle on 19/11/23.
//

import Foundation

extension String: Error { }

final class OpenAIListGenerator: ListGenerator {
    private let httpClient: HTTPClient
    private let restrictions: Restrictions
    
    init(httpClient: HTTPClient, restrictions: Restrictions) {
        self.httpClient = httpClient
        self.restrictions = restrictions
    }
    
    func generate(
        from input: ListGeneratorInput,
        completion: @escaping (Result<GeneratedList, Error>) -> Void
    ) {
        let url = URL(string: "https://api.openai.com/v1/chat/completions")!
        
        let requestBody = OpenAIRequestBody(messages: [
            .init(content: input.prompt(restrictions: restrictions))
        ])
        
        Task {
            do {
                let body = try JSONEncoder().encode(requestBody)
                let data = try await httpClient.post(from: url, body: body)
                
                let decoder = JSONDecoder()
                let response = try decoder.decode(OpenAIResponse.self, from: data)
                
                guard let message = response.choices.first?.message.content.utf8 else {
                    completion(.failure(""))
                    return
                }
                
                guard let generatedList = try decoder.decode(ShoppingList.self, from: Data(message)).shoppingList.first else {
                    completion(.failure(""))
                    return
                }
                
                completion(.success(generatedList))
            } catch {
                completion(.failure(error))
            }
        }
    }
}

struct OpenAIRequestBody: Encodable {
    let model = "gpt-3.5-turbo-1106"
    let responseFormat = ResponseFormat()
    let messages: [Message]
    
    struct Message: Encodable {
        let role = "assistant"
        let content: String
    }
    
    struct ResponseFormat: Encodable {
        let type = "json_object"
    }
    
    enum CodingKeys: String, CodingKey {
        case model
        case responseFormat = "response_format"
        case messages
    }
}

struct OpenAIResponse: Decodable {
    let choices: [Choice]
    
    struct Choice: Decodable {
        let message: Message
    }
    
    struct Message: Decodable {
        let content: String
    }
}

struct ShoppingList: Decodable {
    let shoppingList: [GeneratedList]
}
