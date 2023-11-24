//
//  Prompt.swift
//  Capstone
//
//  Created by Nicolle on 19/11/23.
//

import Foundation

extension DietaryPreferences {
    var prompt: String {
        var preferences: [String] = []
        
        if glutenFree {
            preferences.append("gluten free")
        }
        
        if lactoseFree {
            preferences.append("lactose free")
        }
        
        if sugarFree {
            preferences.append("sugar free")
        }
        
        if vegan {
            preferences.append("vegan")
        }
        
        if vegetarian {
            preferences.append("vegetarian")
        }
        
        return preferences.joined(separator: ", ")
    }
}

extension ListGeneratorInput {
    func prompt(preferences: DietaryPreferences) -> String {
        """
        Create a deterministic JSON format shopping list for my weekly diet based on the meal and the dietary restrictions I've input. Include all the necessary ingredients to prepare the meal, suggesting as few composite ingredients as possible. For example, if I mention "alfredo chicken lasagna," assume that I will prepare the alfredo sauce from scratch instead of buying it pre-made. Do not suggest buying pre-made products; all recipes must be prepared manually. Then, suggest natural ingredients for this meal and avoid processed ones whenever possible, with a strong focus on healthy homemade cooking. If the meal lacks specific details, make reasonable inferences based on the meal's name.
        
        Dietary Restrictions: \(preferences.prompt)
        
        The meal:
        - \(portion)\(measurement == Measurements.unespecified ? "" : measurement.rawValue) \(meal)
        - \(quantity) per week
        
        The output JSON format:
        
        ```json
        { "id": String, "mealName": String, "items": [{ "id": UUID, "name": String, "quantity": String }]}
        ```
        Where the `id` is a UUID string
        
        This is a an example of how the json will look like:
        ```json
        { "id": "297f3ae7-0ae5-4030-b46d-93b9e3280823", "mealName": "Cheesecake", "items": [{ "id": "5f4f359a-4fc8-4c24-b1f5-62f62c2e3a9d", "name": "Cream Cheese", "quantity": "250g" }]}
        ```
        """
    }
}
