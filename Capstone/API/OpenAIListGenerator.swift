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
    private let preferences: DietaryPreferences

    init(httpClient: HTTPClient, preferences: DietaryPreferences? = UserDefaults.standard.dietaryPreferences) {
        self.httpClient = httpClient
        self.preferences = preferences ?? DietaryPreferences(
            glutenFree: false,
            lactoseFree: false,
            sugarFree: false,
            vegan: false,
            vegetarian: false
        )
    }

    func generate(
        from input: ListGeneratorInput,
        completion: @escaping (Result<Meal, Error>) -> Void
    ) {
        let url = URL(string: "https://api.openai.com/v1/chat/completions")!

        let requestBody = OpenAIRequestBody(messages: [
            .init(content: input.prompt(preferences: preferences))
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

                let mealJSON = try decoder.decode(MealJSON.self, from: Data(content))

                // Map MealJSON to Meal
                let newMeal = Meal(json: mealJSON)

                await MainActor.run {
                    completion(.success(newMeal))
                }
            } catch {
                await MainActor.run {
                    completion(.failure(error))
                }
            }
        }
    }
}

struct OpenAIRequestBody: Codable, Equatable {
    let model = "gpt-3.5-turbo-1106"
    let responseFormat = ResponseFormat()
    let messages: [Message]

    struct Message: Codable, Equatable {
        var role = "assistant"
        let content: String
    }

    struct ResponseFormat: Codable, Equatable {
        var type = "json_object"
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
