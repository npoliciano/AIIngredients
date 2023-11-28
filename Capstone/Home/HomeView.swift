//
//  HomeView.swift
//  Capstone
//
//  Created by Nicolle on 14/11/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView {
            Group {
                ShoppingListView()
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }
                UserDetailView(onStart: {})
                    .tabItem {
                        Label("User", systemImage: "person.circle.fill")
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
