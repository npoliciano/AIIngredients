//
//  DietaryPreferencesView.swift
//  Capstone
//
//  Created by Nicolle on 26/11/23.
//

import SwiftUI

struct DietaryPreferencesView: View {
  typealias Str = Strings.DietaryPreferences
  var title: String = ""
  @Binding var preferences: DietaryPreferences

  var body: some View {
    Section(title) {
      Toggle(Str.glutenFree, isOn: $preferences.glutenFree)
        .accessibilityIdentifier("glutenFreeToggle")

      Toggle(Str.lactoseFree, isOn: $preferences.lactoseFree)
        .accessibilityIdentifier("lactoseFreeToggle")

      Toggle(Str.sugarFree, isOn: $preferences.sugarFree)
        .accessibilityIdentifier("sugarFreeToggle")

      Toggle(Str.vegan, isOn: $preferences.vegan)
        .accessibilityIdentifier("veganToggle")

      Toggle(Str.vegetarian, isOn: $preferences.vegetarian)
        .accessibilityIdentifier("vegetarianToggle")
    }
  }
}

struct DietaryPreferencesView_Previews: PreviewProvider {
  static var previews: some View {
    List {
      DietaryPreferencesView(
        title: "Dietary Preferences",
        preferences: .constant(
          DietaryPreferences(
            glutenFree: false,
            lactoseFree: false,
            sugarFree: false,
            vegan: false,
            vegetarian: true
          )
        )
      )
    }
  }
}
