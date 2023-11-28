//
//  DietaryPreferencesView.swift
//  Capstone
//
//  Created by Nicolle on 26/11/23.
//

import SwiftUI

struct DietaryPreferencesView: View {
  var title: String = ""
  @Binding var preferences: DietaryPreferences

  var body: some View {
    Section(title) {
      Toggle("Gluten Free", isOn: $preferences.glutenFree)

      Toggle("Lactose Free", isOn: $preferences.lactoseFree)

      Toggle("Sugar Free", isOn: $preferences.sugarFree)

      Toggle("Vegan", isOn: $preferences.vegan)

      Toggle("Vegeterian", isOn: $preferences.vegetarian)
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
