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
        Create a deterministic JSON format shopping list for my weekly diet based on the meals I've input. Include all the necessary ingredients to prepare the meals, suggesting as few composite ingredients as possible. For example, if I mention "white sauce lasagna," assume that I will prepare the white sauce and list the individual necessary ingredients. If any meal lacks specific details, make reasonable inferences based on the meal's name. Do not suggest buying pre-made recipes; all recipes must be prepared manually. Suggest natural ingredients and avoid processed ones whenever possible, with a strong focus on healthy homemade cooking. Specify the ingredients that make up each meal.
        
        Dietary Preferences: \(preferences.prompt)
        
        List of meals:
        - \(portion)\(measurement == Measurements.unespecified ? "" : measurement.rawValue) \(meal)
        
        The output JSON should follow the following format:
        
        ```json
        {
          "shoppingList": [
            {
              "name": String,
              "items": [
                {
                  "name": String,
                  "quantity": String
                }
              ]
            }
          ]
        }
        ```
        """
    }
}
