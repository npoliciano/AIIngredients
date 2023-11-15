//
//  RecipeListView.swift
//  Capstone
//
//  Created by Nicolle on 14/11/23.
//

import SwiftUI

struct RecipeListView: View {
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
          NewRecipeButtonView(action: {
            path.append(Destination.newRecipe)
          })
        }
      }
      .navigationDestination(for: Destination.self) { destination in
        if destination == .newRecipe {
          NewRecipeView()
        }
      }
      .navigationTitle("Hello, Nicolle")
    }
  }
}

struct RecipeListView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationStack {
      RecipeListView()
    }
  }
}
