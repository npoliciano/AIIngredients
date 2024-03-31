//
//  ShoppingListViewModel.swift
//  AIIngredients
//
//  Created by Nicolle on 21/11/23.
//

import Foundation

final class ShoppingListViewModel: ObservableObject {
  @Published var shoppingLists: [Meal] = [] {
    didSet { // It updates the userDefault whenever shoppingLists changes
      userDefaults.shoppingLists = shoppingLists.reversed()
    }
  }

  var userName: String
  private let userDefaults: UserDefaults

  init(userDefaults: UserDefaults = .standard) {
    self.userDefaults = userDefaults
    userName = userDefaults.userName
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(loadLists),
      name: .onUpdateShoppingList,
      object: nil
    )
    loadLists() // It loads the initial data
  }

  deinit {
    NotificationCenter.default.removeObserver(self)
  }

  // It retrieves the shopping lists from userDefaults, reverses them, and updates the shoppingLists property.
  // Marked with @objc to allow it to be called by Objective-C APIs (NotificationCenter)
  @objc private func loadLists() {
    let allLists = userDefaults.shoppingLists
    shoppingLists = allLists.reversed()
  }
}
