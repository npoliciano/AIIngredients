//
//  EditableSelectableIngredientView.swift
//  Capstone
//
//  Created by Nicolle on 24/11/23.
//

import SwiftUI

struct EditableSelectableIngredientView: View {
    let isEditing: Bool
    @Binding var ingredient: Ingredient

    var body: some View {
        VStack {
            if isEditing {
                HStack {
                    TextField("", text: $ingredient.name)
                        .font(.subheadline)
                    Spacer()
                    TextField("", text: $ingredient.quantity)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.trailing)
                }
            } else {
                SelectableIngredientView(ingredient: $ingredient)
                    .padding(.trailing, -0.5)
            }
        }
    }
}

struct EditableSelectableIngredientView_Previews: PreviewProvider {
    static var previews: some View {
        EditableSelectableIngredientView(
            isEditing: true,
            ingredient: .constant(Ingredient(name: "Cheddar Cheese", quantity: "200g"))
        )
    }
}
