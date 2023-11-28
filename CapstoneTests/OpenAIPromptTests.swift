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
    let input = ListGeneratorInput(meal: "Ceasar Salad", portion: "50", measurement: .grams, quantity: 5)
    let preferences = DietaryPreferences(
      glutenFree: true,
      lactoseFree: false,
      sugarFree: true,
      vegan: false,
      vegetarian: true
    )

    // Act
    let prompt = input.prompt(preferences: preferences)

    // Assert
    // swiftlint:disable line_length
    XCTAssertEqual(
      prompt,
        """
        Create a deterministic JSON format shopping list for my weekly diet based on the meal and the dietary restrictions I've input. Include all the necessary ingredients to prepare the meal, suggesting as few composite ingredients as possible. For example, if I mention "alfredo chicken lasagna," assume that I will prepare the alfredo sauce from scratch instead of buying it pre-made. Do not suggest buying pre-made products; all recipes must be prepared manually. Then, suggest natural ingredients for this meal and avoid processed ones whenever possible, with a strong focus on healthy homemade cooking. If the meal lacks specific details, make reasonable inferences based on the meal's name.

        Based on generated list of ingredients inform the categories the given meal fits. The categories are: PROTEINS, GRAINS_AND_CARBOHYDRATES, FRUITS_AND_VEGETABLES, DAIRY_AND_ALTERNATIVES, SEASONINGS_AND_CONDIMENTS

        Dietary Restrictions: gluten free, sugar free, vegetarian

        The meal:
        - 50g Ceasar Salad
        - 5 per week

        The output JSON format:

        ```json
        { "mealName": String, categories: [String], "ingredients": [{"name": String, "quantity": String }]}
        ```

        This is a an example of how the json will look like:
        ```json
        { "mealName": "Cheesecake", categories: ["GRAINS_AND_CARBOHYDRATES", "DAIRY_AND_ALTERNATIVES"], "ingredients": [{ "name": "Cream Cheese", "quantity": "250g" }]}
        ```
        """
    )
    // swiftlint:enable line_length
  }

  func testCreatePromptWhenMeasurementIsUnespecified() {
    // Arrange
    let input = ListGeneratorInput(meal: "Alfredo Chicken", portion: "200", measurement: .unespecified, quantity: 3)
    let preferences = DietaryPreferences(
      glutenFree: false,
      lactoseFree: true,
      sugarFree: false,
      vegan: true,
      vegetarian: false
    )

    // Act
    let prompt = input.prompt(preferences: preferences)

    // Assert
    // swiftlint:disable line_length
    XCTAssertEqual(
      prompt,
        """
        Create a deterministic JSON format shopping list for my weekly diet based on the meal and the dietary restrictions I've input. Include all the necessary ingredients to prepare the meal, suggesting as few composite ingredients as possible. For example, if I mention "alfredo chicken lasagna," assume that I will prepare the alfredo sauce from scratch instead of buying it pre-made. Do not suggest buying pre-made products; all recipes must be prepared manually. Then, suggest natural ingredients for this meal and avoid processed ones whenever possible, with a strong focus on healthy homemade cooking. If the meal lacks specific details, make reasonable inferences based on the meal's name.

        Based on generated list of ingredients inform the categories the given meal fits. The categories are: PROTEINS, GRAINS_AND_CARBOHYDRATES, FRUITS_AND_VEGETABLES, DAIRY_AND_ALTERNATIVES, SEASONINGS_AND_CONDIMENTS

        Dietary Restrictions: lactose free, vegan

        The meal:
        - 200 Alfredo Chicken
        - 3 per week

        The output JSON format:

        ```json
        { "mealName": String, categories: [String], "ingredients": [{"name": String, "quantity": String }]}
        ```

        This is a an example of how the json will look like:
        ```json
        { "mealName": "Cheesecake", categories: ["GRAINS_AND_CARBOHYDRATES", "DAIRY_AND_ALTERNATIVES"], "ingredients": [{ "name": "Cream Cheese", "quantity": "250g" }]}
        ```
        """
    )
    // swiftlint:enable line_length
  }
}
