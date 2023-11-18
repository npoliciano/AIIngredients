//
//  ShoppingListView.swift
//  Capstone
//
//  Created by Nicolle on 14/11/23.
//

import SwiftUI

struct ShoppingListView: View {
    @State private var path = NavigationPath()
    
    var items: [String]
    
    var body: some View {
        NavigationStack(path: $path) {
            Group {
                if items.isEmpty {
                    EmptyListView(onTap: {
                        path.append(BuildYourMealDestination())
                    })
                } else {
                    List(items, id: \.self) { item in
                        HStack {
                            Image(systemName: "square")
                            Text(item)
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    PlusButton(action: {
                        path.append(BuildYourMealDestination())
                    })
                }
            }
            .navigationDestination(for: BuildYourMealDestination.self) { _ in
                BuildYourMealView()
                    .toolbar(.hidden, for: .tabBar)
            }
            .navigationTitle("Hello, Nicolle")
        }
    }
}

struct BuildYourMealDestination: Hashable { }

struct ShoppingListView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingListView(items: [])
    }
}
