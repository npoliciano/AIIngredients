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
            ShoppingListView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            UserDetailView(onStart: {})
                .tabItem {
                    Label("User", systemImage: "person.circle.fill")
                }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
