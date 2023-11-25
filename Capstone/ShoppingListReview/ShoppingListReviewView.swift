//
//  ShoppingListPreviewView.swift
//  Capstone
//
//  Created by Nicolle on 14/11/23.
//

import SwiftUI

struct ShoppingListReviewView: View {
    @StateObject var viewModel: ShoppingListReviewViewModel
    let onConfirm: () -> Void
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Review Your Shopping List")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top)
                    
                    Text("Satisfied with your ingredients? If there's anything amiss, go ahead and customize the list to your taste!")
                        .foregroundColor(.secondary)
                        .padding(.bottom)
                    
                    VStack(alignment: .leading, spacing: 20) {
                        Label(viewModel.name, systemImage: "cart")
                            .fontWeight(.medium)
                            .foregroundStyle(.secondary)
                        
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
                Button {
                    viewModel.onConfirm()
                    onConfirm()
                } label: {
                    Text("Confirm Selection")
                        .foregroundColor(Color.white)
                        .padding()
                        .cornerRadius(16)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.accentColor)
                        )
                }
                
                Button("Make Changes") {
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
            ),
            onConfirm: {}
        )
    }
}
