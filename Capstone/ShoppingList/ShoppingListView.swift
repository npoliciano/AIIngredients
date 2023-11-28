//
//  ShoppingListView.swift
//  Capstone
//
//  Created by Nicolle on 14/11/23.
//

import SwiftUI

struct ShoppingListView: View {
  @State private var path = NavigationPath()
  @State private var expanded = 0
  @State private var isShowingDetail = false

  @StateObject var viewModel = ShoppingListViewModel()

  var isExpanded: Bool {
    expanded == 1
  }

  var body: some View {
    NavigationStack(path: $path) {
      Group {
        if viewModel.shoppingLists.isEmpty {
          EmptyListView {
            isShowingDetail = true
            path.append(ShoppingListDestination.buildYourMeal)
          }
        } else {
          VStack {
            Picker("", selection: $expanded) {
              Text("Summary").tag(0)
              Text("All").tag(1)
            }
            .pickerStyle(.segmented)
            .padding()

            MealsView(
              shoppingLists: $viewModel.shoppingLists,
              isExpanded: isExpanded
            ) { meal in
              isShowingDetail = true
              path.append(ShoppingListDestination.detail(meal))
            }
          }
        }
      }
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          ImageButton(systemName: "plus.circle") {
            isShowingDetail = true
            path.append(ShoppingListDestination.buildYourMeal)
          }
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
      .navigationTitle(isShowingDetail ? "" : "Hello, \(viewModel.userName)")
      .onDisappear {
        //            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        //                isShowingDetail = true
        //            }
      }
      .onAppear {
        isShowingDetail = false
      }
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
