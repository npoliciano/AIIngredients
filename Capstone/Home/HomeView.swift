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
            ShoppingListView(items: [
                    "Item 1",
                    "Item 2",
                    "Item 3",
                    "Item 4",
                    "Item 5",
                    "Item 6"
            ])
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
