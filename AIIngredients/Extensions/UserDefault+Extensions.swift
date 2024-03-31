//
//  UserDefault+Extensions.swift
//  AIIngredients
//
//  Created by Nicolle on 21/11/23.
//

import Foundation

extension UserDefaults {
  typealias Key = UserDefaultsKeys
  var onboardingStatus: OnboardingStatus? {
    get {
      if let data = self.data(forKey: Key.onboardingStatus) {
        return try? JSONDecoder().decode(OnboardingStatus.self, from: data)
      }
      return nil
    }
    set {
      if let encoded = try? JSONEncoder().encode(newValue) {
        self.set(encoded, forKey: Key.onboardingStatus)
      }
    }
  }

  var userName: String {
    get {
      self.string(forKey: Key.userName) ?? ""
    }
    set {
      self.set(newValue, forKey: Key.userName)
    }
  }

  var dietaryPreferences: DietaryPreferences? {
    get {
      if let data = self.data(forKey: Key.dietaryPreferences) {
        return try? JSONDecoder().decode(DietaryPreferences.self, from: data)
      }
      return nil
    }
    set {
      if let encoded = try? JSONEncoder().encode(newValue) {
        self.set(encoded, forKey: Key.dietaryPreferences)
      }
    }
  }


  var shoppingLists: [Meal] {
    get {
      if let data = self.data(forKey: Key.shoppingLists) {
        return (try? JSONDecoder().decode([Meal].self, from: data)) ?? []
      }
      return []
    }
    set {
      if let encoded = try? JSONEncoder().encode(newValue) {
        self.set(encoded, forKey: Key.shoppingLists)
      }
    }
  }
}
