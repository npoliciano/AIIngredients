//
//  ShoppingListView.swift
//  Capstone
//
//  Created by Nicolle on 14/11/23.
//

import SwiftUI

struct ShoppingListView: View {
    @State private var path = NavigationPath()
    @State private var expanded = 1
    
    @StateObject var viewModel = ShoppingListViewModel()
    
    var isExpanded: Bool {
        expanded == 0
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            Group {
                if viewModel.shoppingLists.isEmpty {
                    EmptyListView(onTap: {
                        path.append(ShoppingListDestination.buildYourMeal)
                    })
                } else {
                    VStack {
                        Picker("", selection: $expanded) {
                            Text("Expanded").tag(0)
                            Text("Collapsed").tag(1)
                        }
                        .pickerStyle(.segmented)
                        .padding()
                        
                        List($viewModel.shoppingLists) { $meal in
                            Section {
                                ForEach(Array(meal.ingredients.indices), id: \.self) { index in
                                    if index < 3 || isExpanded {
                                        SelectableIngredientView(ingredient: $meal.ingredients[index])
                                            .padding(.vertical, 4)
                                            .padding(.bottom, 4)
                                    }
                                }
                                
                                if meal.ingredients.count > 3, !isExpanded {
                                    VStack(alignment: .leading) {
                                        Divider()
                                        Button {
                                            path.append(ShoppingListDestination.detail(meal))
                                        } label: {
                                            HStack(spacing: 4) {
                                                Text("See all")
                                                    .font(.callout)
                                                
                                                Image(systemName: "chevron.right")
                                                    .imageScale(.small)
                                            }
                                            .foregroundStyle(Color.accentColor)
                                        }
                                        .padding(.top, 4)
                                        
                                    }
                                    .padding(.bottom, 9)
                                }
                            } header: {
                                Text(meal.name)
                                    .font(.headline)
                                    .foregroundStyle(.primary)
                            }
                            .listRowSeparator(.hidden)
                            .listSectionSeparator(.hidden)
                        }
                        .listStyle(.plain)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    ImageButton(systemName: "plus.circle", action: {
                        path.append(ShoppingListDestination.buildYourMeal)
                    })
                }
            }
            .navigationDestination(for: ShoppingListDestination.self) { destination in
                Group {
                    switch destination {
                    case .buildYourMeal:
                        BuildYourMealView()
                    case .detail(let meal):
                        DetailView(viewModel: DetailViewModel(meal: meal))
                    }
                }
                .toolbar(.hidden, for: .tabBar)
            }
            .navigationTitle("Hello, \(viewModel.userName)")
        }
    }
}

enum ShoppingListDestination: Hashable {
    case buildYourMeal
    case detail(Meal)
}

struct ShoppingListView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingListView()
    }
}
