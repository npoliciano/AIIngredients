//
//  ShoppingListPreviewView.swift
//  AIIngredients
//
//  Created by Nicolle on 14/11/23.
//

import SwiftUI

struct ShoppingListReviewView: View {
  private typealias Str = Strings.ShoppingListReview
  @StateObject var viewModel: ShoppingListReviewViewModel
  let onConfirm: () -> Void

  @Environment(\.dismiss)
  var dismiss

  var body: some View {
    VStack(alignment: .leading) {
      ScrollView {
        VStack(alignment: .leading, spacing: 16) {
          Text(Str.title)
            .font(.largeTitle)
            .fontWeight(.bold)
            .padding(.top)

          Text(Str.headline)
          .foregroundColor(.secondary)
          .padding(.bottom)

          VStack(alignment: .leading, spacing: 20) {
            Label(viewModel.name, systemImage: "cart")
              .fontWeight(.medium)
              .foregroundStyle(.secondary)

            Divider()

            Text(Str.mayContain)
              .font(.caption)
              .fontWeight(.medium)
              .foregroundStyle(.tertiary)

            CategoriesView(categories: viewModel.categories)

            Divider()

            LazyVStack(spacing: 16) {
              ForEach(viewModel.ingredients) { ingredient in
                IngredientView(
                  name: ingredient.name,
                  quantity: ingredient.quantity
                )
              }
            }
          }
          .padding(4)
        }
        .padding()
      }

      VStack(spacing: 16) {
        PrimaryButton(title: Str.confirmSelection) {
          viewModel.onConfirm()
          onConfirm()
        }

        Button(Str.makeChanges) {
          dismiss()
        }
      }
      .padding()
    }
  }
}

struct ShoppingListReviewView_Previews: PreviewProvider {
  static var previews: some View {
    ShoppingListReviewView(
      viewModel: ShoppingListReviewViewModel(meal: Meal(
        name: "Ceasar Salad",
        categories: [.dairy, .proteins, .carbo, .seasonings, .veggies],
        ingredients: [
          Ingredient(name: "Letuce", quantity: "as needed"),
          Ingredient(name: "Cheese", quantity: "20 g"),
          Ingredient(name: "Milk", quantity: "200 ml"),
          Ingredient(name: "Ceasar Sauce", quantity: "30 g"),
          Ingredient(name: "Letuce", quantity: "as needed"),
          Ingredient(name: "Cheese", quantity: "20 g"),
          Ingredient(name: "Milk", quantity: "200 ml"),
          Ingredient(name: "Ceasar Sauce", quantity: "30 g"),
          Ingredient(name: "Letuce", quantity: "as needed"),
          Ingredient(name: "Cheese", quantity: "20 g"),
          Ingredient(name: "Milk", quantity: "200 ml"),
          Ingredient(name: "Ceasar Sauce", quantity: "30 g"),
          Ingredient(name: "Letuce", quantity: "as needed"),
          Ingredient(name: "Cheese", quantity: "20 g"),
          Ingredient(name: "Milk", quantity: "200 ml"),
          Ingredient(name: "Ceasar Sauce", quantity: "30 g")
        ])
      )
    ) {}
  }
}
