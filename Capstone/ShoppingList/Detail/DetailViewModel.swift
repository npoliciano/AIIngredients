//
//  DetailViewModel.swift
//  Capstone
//
//  Created by Nicolle on 23/11/23.
//

import Foundation
import SwiftUI

final class DetailViewModel: ObservableObject {
  @Published var meal: Meal {
    // Whenever meal is set, the code updates the corresponding meal in the user defaults' shopping lists
    didSet {
      var allMeals = userDefaults.shoppingLists

      // When the meal is updated, it then searches for the meal with the same id as the updated meal in the allMeals array.
      guard let index = allMeals.firstIndex(where: { $0.id == meal.id }) else {
        return
      }

      var storedMeal = allMeals[index]

      // It iterates through each ingredient in the updated meal's ingredients list.
      for ingredient in meal.ingredients {
        storedMeal.ingredients = storedMeal.ingredients.map {
          if $0.id == ingredient.id { // For each ingredient, it looks for a matching ingredient in the stored meal
            var storedIngredient = $0
            storedIngredient.isSelected = ingredient.isSelected
            return storedIngredient
          }
          return $0
        }
      }

      // After iterating through all the ingredients and updating them as necessary, the modified storedMeal replaces the old one in the allMeals array at the same index.
      allMeals[index] = storedMeal
      saveAndNotify(updatedList: allMeals)
    }
  }

  @Published var isErrorPresented = false
  @Published var isEmptyIngredientsErrorPresented = false

  private let userDefaults: UserDefaults

  init(meal: Meal, userDefaults: UserDefaults = .standard) {
    self.meal = meal
    self.userDefaults = userDefaults
  }

  func updateList() {
    guard !meal.name.isEmpty, meal.ingredients.allSatisfy({
      !$0.name.isEmpty && !$0.quantity.isEmpty
    }) else {
      isErrorPresented = true
      return
    }

    var allMeals = userDefaults.shoppingLists

    guard let index = allMeals.firstIndex(where: { $0.id == meal.id }) else {
      return
    }

    allMeals[index] = meal

    saveAndNotify(updatedList: allMeals)
  }

  func delete() {
    var allMeals = userDefaults.shoppingLists
    allMeals.removeAll { $0.id == meal.id }

    saveAndNotify(updatedList: allMeals)
  }

  func delete(ingredient: Ingredient) {
    if meal.ingredients.count > 1 {
      meal.ingredients.removeAll { $0.id == ingredient.id }
      return
    }

    isEmptyIngredientsErrorPresented = true
  }

  private func saveAndNotify(updatedList: [Meal]) {
    userDefaults.shoppingLists = updatedList
    NotificationCenter.default.post(
      name: .onUpdateShoppingList,
      object: nil
    )
  }
}
