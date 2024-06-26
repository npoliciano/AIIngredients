//
//  HomeView.swift
//  AIIngredients
//
//  Created by Nicolle on 14/11/23.
//

import SwiftUI

struct HomeView: View {
  typealias Str = Strings.Home
  var body: some View {
    TabView {
      Group {
        ShoppingListView()
          .tabItem {
            Label(Str.home, systemImage: "house.fill")
          }
        UserDetailView {}
          .tabItem {
            Label(Str.user, systemImage: "person.circle.fill")
          }
      }
      // Sets the toolbar's background color to match the system's background color (adapting to light/dark mode)
      .toolbarBackground(Color(uiColor: .systemBackground), for: .tabBar)
      // Ensures that this background is visible
      .toolbarBackground(.visible, for: .tabBar)
    }
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}
