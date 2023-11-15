//
//  ShoppingListView.swift
//  Capstone
//
//  Created by Nicolle on 14/11/23.
//

import SwiftUI

struct ShoppingListView: View {
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                HStack {
                    Image(systemName: "square")
                    Text("A List Item")
                }
                HStack {
                    Image(systemName: "square")
                    Text("A List Item")
                }
            }
            .listStyle(.plain)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    PlusButton(action: {
                        path.append(Destination.newRecipe)
                    })
                }
            }
            .navigationDestination(for: Destination.self) { destination in
                if destination == .newRecipe {
                    NewShoppingListView()
                        .navigationBarTitle("Add a new Recipe")
                        .toolbar(.hidden, for: .tabBar)
                }
            }
            .navigationTitle("Hello, Nicolle")
        }
    }
}

struct ShoppingListView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingListView()
    }
}
