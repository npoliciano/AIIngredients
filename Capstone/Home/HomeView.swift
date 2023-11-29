//
//  HomeView.swift
//  Capstone
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
      .toolbarBackground(Color(uiColor: .systemBackground), for: .tabBar)
      .toolbarBackground(.visible, for: .tabBar)
    }
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}
