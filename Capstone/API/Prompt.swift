//
//  Prompt.swift
//  Capstone
//
//  Created by Nicolle on 19/11/23.
//

import Foundation

extension Restrictions {
    var prompt: String {
        var restrictions: [String] = []
        
        if glutenFree {
            restrictions.append("gluten free")
        }
        
        if lactoseFree {
            restrictions.append("lactose free")
        }
        
        if sugarFree {
            restrictions.append("sugar free")
        }
        
        if vegan {
            restrictions.append("vegan")
        }
        
        if vegetarian {
            restrictions.append("vegetarian")
        }
        
        return restrictions.joined(separator: ", ")
    }
}

extension ListGeneratorInput {
    func prompt(restrictions: Restrictions) -> String {
        """
        Create a deterministic JSON format shopping list for my weekly diet based on the meals I've input. Include all the necessary ingredients to prepare the meals, suggesting as few composite ingredients as possible. For example, if I mention "white sauce lasagna," assume that I will prepare the white sauce and list the individual necessary ingredients. If any meal lacks specific details, make reasonable inferences based on the meal's name. Do not suggest buying pre-made recipes; all recipes must be prepared manually. Suggest natural ingredients and avoid processed ones whenever possible, with a strong focus on healthy homemade cooking. Specify the ingredients that make up each meal.
        
        Restrictions: \(restrictions.prompt)
        
        List of meals:
        - \(portion)\(measurement == "unespecified" ? "" : measurement) \(meal)
        
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
