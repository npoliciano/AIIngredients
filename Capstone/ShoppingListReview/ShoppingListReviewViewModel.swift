//
//  ShoppingListReviewViewModel.swift
//  Capstone
//
//  Created by Nicolle on 21/11/23.
//

import Foundation

final class ShoppingListReviewViewModel: ObservableObject {
  private let meal: Meal
  private let userDefaults: UserDefaults

  var name: String {
    meal.name
  }

  var ingredients: [Ingredient] {
    meal.ingredients
  }

  var categories: [Category] {
    meal.categories
  }

  init(meal: Meal, userDefaults: UserDefaults = .standard) {
    self.meal = meal
    self.userDefaults = userDefaults
  }

  func onConfirm() {
    saveList()
  }

  private func saveList() {
    var allMeals = userDefaults.shoppingLists
    allMeals.append(meal)
    userDefaults.shoppingLists = allMeals

    NotificationCenter.default.post(
      name: .onUpdateShoppingList,
      object: nil
    )
  }
}
