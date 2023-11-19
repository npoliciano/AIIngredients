//
//  OpenAIPromptTests.swift
//  CapstoneTests
//
//  Created by Nicolle on 19/11/23.
//

import XCTest

@testable import Capstone

final class PromptTests: XCTestCase {
    func testCreatePrompt() {
        // Arrange
        let input = ListGeneratorInput(meal: "Ceasar Salad", portion: "50", measurement: "g", quantity: 5)
        let restrictions = Restrictions(
            glutenFree: true,
            lactoseFree: false,
            sugarFree: true,
            vegan: false,
            vegetarian: true
        )
        
        // Act
        let prompt = input.prompt(restrictions: restrictions)
        
        // Assert
        XCTAssertEqual(
            prompt,
        """
        Create a deterministic JSON format shopping list for my weekly diet based on the meals I've input. Include all the necessary ingredients to prepare the meals, suggesting as few composite ingredients as possible. For example, if I mention "white sauce lasagna," assume that I will prepare the white sauce and list the individual necessary ingredients. If any meal lacks specific details, make reasonable inferences based on the meal's name. Do not suggest buying pre-made recipes; all recipes must be prepared manually. Suggest natural ingredients and avoid processed ones whenever possible, with a strong focus on healthy homemade cooking. Specify the ingredients that make up each meal.
        
        Restrictions: gluten free, sugar free, vegetarian
        
        List of meals:
        - 50g Ceasar Salad
        
        The output JSON should follow the following format:
        
        ```json
        {
          "recipes": [
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
        )
    }
    
    func testCreatePromptWhenMeasurementIsUnespecified() {
        // Arrange
        let input = ListGeneratorInput(meal: "Ceasar Salad", portion: "50", measurement: "unespecified", quantity: 5)
        let restrictions = Restrictions(
            glutenFree: false,
            lactoseFree: true,
            sugarFree: false,
            vegan: true,
            vegetarian: false
        )
        
        // Act
        let prompt = input.prompt(restrictions: restrictions)
        
        // Assert
        XCTAssertEqual(
            prompt,
        """
        Create a deterministic JSON format shopping list for my weekly diet based on the meals I've input. Include all the necessary ingredients to prepare the meals, suggesting as few composite ingredients as possible. For example, if I mention "white sauce lasagna," assume that I will prepare the white sauce and list the individual necessary ingredients. If any meal lacks specific details, make reasonable inferences based on the meal's name. Do not suggest buying pre-made recipes; all recipes must be prepared manually. Suggest natural ingredients and avoid processed ones whenever possible, with a strong focus on healthy homemade cooking. Specify the ingredients that make up each meal.
        
        Restrictions: lactose free, vegan
        
        List of meals:
        - 50 Ceasar Salad
        
        The output JSON should follow the following format:
        
        ```json
        {
          "recipes": [
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
        )
    }
}
