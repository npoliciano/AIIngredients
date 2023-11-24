//
//  UserDefault+Extensions.swift
//  Capstone
//
//  Created by Nicolle on 21/11/23.
//

import Foundation

extension UserDefaults {
    var onboardingStatus: OnboardingStatus? {
        get {
            if let data = self.data(forKey: "onboardingStatus") {
                return try? JSONDecoder().decode(OnboardingStatus.self, from: data)
            }
            return nil
        }
        set {
            if let encoded = try? JSONEncoder().encode(newValue) {
                self.set(encoded, forKey: "onboardingStatus")
            }
        }
    }
    
    var userName: String {
        get {
            self.string(forKey: "userName") ?? ""
        }
        set {
            self.set(newValue, forKey: "userName")
        }
    }
    
    var dietaryPreferences: DietaryPreferences? {
        get {
            if let data = self.data(forKey: "dietaryPreferences") {
                return try? JSONDecoder().decode(DietaryPreferences.self, from: data)
            }
            return nil
        }
        set {
            if let encoded = try? JSONEncoder().encode(newValue) {
                self.set(encoded, forKey: "dietaryPreferences")
            }
        }
    }
    
    
    var shoppingLists: [GeneratedList] {
        get {
            if let data = self.data(forKey: "shoppingLists") {
                return (try? JSONDecoder().decode([GeneratedList].self, from: data)) ?? []
            }
            return []
        }
        set {
            if let encoded = try? JSONEncoder().encode(newValue) {
                self.set(encoded, forKey: "shoppingLists")
            }
        }
    }
}
