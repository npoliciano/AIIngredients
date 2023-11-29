//
//  Strings.swift
//  Capstone
//
//  Created by Nicolle on 28/11/23.
//

import Foundation

// swiftlint:disable line_length
enum Strings {
  enum FeaturesOnboarding {
    static let feature1 = "AI-Powered Ingredient Lists"
    static let description1 = "Input any meal you're planning to shop for, and our AI will instantly generate a detailed ingredient list for you. Experience the ease and innovation in shopping for your meals!"
    static let feature2 = "Personalized Dietary Preferences"
    static let description2 = "Customize your meals. Choose preferences like gluten-free or vegan and enjoy ingredients tailored for you!"
    static let feature3 = "Manage Your Shopping List"
    static let description3 = "Easily edit and organize your shopping list. Maintain total control and save time when shopping!"
  }

  enum OnboardingPage {
    static let start = "Start"
  }

  enum UserName {
    static let title = "Who are you?"
    static let headline = "We're excited to have you on board. Let's personalize your experience. Please enter your name below."
    static let label = "First name"
    static let placeholder = "John Appleseed"
    static let next = "Next"
  }

  enum UserPreferences {
    static let title = "Tailor Your Experience to Your Taste!"
    static let headline = "Let us know what suits your diet, and we'll customize your experience accordingly. Please select any dietary preferences that apply to you from the options below."
    static let preferences = "Preferences"
    static let next = "Next"
  }

  enum DietaryPreferences {
    static let glutenFree = "Gluten Free"
    static let lactoseFree = "Lactose Free"
    static let sugarFree = "Sugar Free"
    static let vegan = "Vegan"
    static let vegetarian = "Vegeterian"
  }

  enum Categories {
    static let protein = "Proteins"
    static let carbo = "Grains and Carbohydrates"
    static let veggies = "Fruits and Vegetables"
    static let dairy = "Dairy and Alternatives"
    static let seasonings = "Seasonings and Condiments"
  }

  enum OnboardingFlow {
    static let dietaryPreferences = "Dietary Preferences"
    static let enterYourName = "Enter your name"
  }

  enum Home {
    static let home = "Home"
    static let user = "User"
  }

  enum Detail {
    static let mealName = "Meal name"
    static let mayContain = "May contain"
    static let ingredients = "Ingredients"
    static let mealDetails = "Meal Details"
    static let done = "Done"
    static let confirmDeletion = "Confirm Deletion"
    static let cancel = "Cancel"
    static let delete = "Delete"
    static let error = "Error"
    static let gotIt = "Got it"
    static let emptyFieldAlert = "No field can be left empty. Please enter a value or delete."
    static let emptyIngredientsAlert = "You can not delete all ingredients. Would you like to delete the meal?"
  }

  enum ShoppingList {
    static let summary = "Summary"
    static let all = "All"
    static func greetings(_ name: String) -> String { "Hello, \(name)" }
  }

  enum EmptyList {
    static let text = "Your list is currently empty, but don't worry, start adding new meals now to make the most of our app!"
    static let startAdding = "Start Adding"
  }

  enum Meal {
    static let seeAll = "See all"
  }

  enum ShoppingListReview {
    static let title = "Review Your Shopping List"
    static let headline = "Satisfied with your ingredients? If there's anything amiss, go ahead and customize the list to your taste!"
    static let mayContain = "MAY CONTAIN"
    static let confirmSelection = "Confirm Selection"
    static let makeChanges = "Make Changes"
  }

  enum UserDetail {
    static let dietaryPreferences = "Dietary Preferences"
    static let appVersionTitle = "App Version"
    static let appVersion = "v0.1"
    static let text = "Please note, our AI's results may not always be accurate or complete. We're constantly refining our technology, but urge caution, especially for dietary restrictions or allergies. Your feedback is crucial to our improvement."
  }
}
// swiftlint:enable line_length
