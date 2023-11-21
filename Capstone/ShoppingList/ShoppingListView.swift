//
//  ShoppingListView.swift
//  Capstone
//
//  Created by Nicolle on 14/11/23.
//

import SwiftUI

struct ShoppingListView: View {
    @State private var path = NavigationPath()
    
    @StateObject var viewModel = ShoppingListViewModel()
    
    var body: some View {
        NavigationStack(path: $path) {
            Group {
                if viewModel.shoppingList.isEmpty {
                    EmptyListView(onTap: {
                        path.append(BuildYourMealDestination())
                    })
                } else {
                    List(viewModel.shoppingList) { list in
                        Section(header: Text(list.name)) {
                            ForEach(list.items) { item in
                                HStack {
                                    Image(systemName: "square")
                                    Text(item.name)
                                }
                                .padding(.vertical, 4)
                                .listRowSeparator(.hidden)
                            }
                        }
                        .padding(.bottom, 4)
                        .listSectionSeparator(.hidden)
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
        ShoppingListView()
    }
}
