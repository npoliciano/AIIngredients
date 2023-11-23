//
//  OpenAIListGenerator.swift
//  Capstone
//
//  Created by Nicolle on 19/11/23.
//

import Foundation

extension String: Error { }

final class OpenAIListGenerator: ListGenerator {
    private let userDefaultsKey = "dietaryPreferences"
    private let httpClient: HTTPClient
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    private func getPreferences() -> DietaryPreferences {
        if let savedPreferences = UserDefaults.standard.dietaryPreferences {
            return savedPreferences
        }
        return DietaryPreferences(
            glutenFree: false,
            lactoseFree: false,
            sugarFree: false,
            vegan: false,
            vegetarian: false
        )
    }
    
    func generate(
        from input: ListGeneratorInput,
        completion: @escaping (Result<GeneratedList, Error>) -> Void
    ) {
        let url = URL(string: "https://api.openai.com/v1/chat/completions")!
        
        let requestBody = OpenAIRequestBody(messages: [
            .init(content: input.prompt(preferences: getPreferences()))
        ])

        Task {
            do {
                let body = try JSONEncoder().encode(requestBody)
                let data = try await httpClient.post(from: url, body: body)
                
                let decoder = JSONDecoder()
                let response = try decoder.decode(OpenAIResponse.self, from: data)
                
                
                guard let content = response.choices.first?.message.content.utf8 else {
                    throw AppError.server
                }
                
                let generatedList = try decoder.decode(GeneratedList.self, from: Data(content))
                
                await MainActor.run {
                    completion(.success(generatedList))
                }
            } catch {
                await MainActor.run {
                    completion(.failure(error))
                }
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
