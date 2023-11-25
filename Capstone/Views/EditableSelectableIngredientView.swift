//
//  EditableSelectableIngredientView.swift
//  Capstone
//
//  Created by Nicolle on 24/11/23.
//

import SwiftUI

struct EditableSelectableIngredientView: View {
    @Binding var ingredient: Ingredient
    @Environment(\.editMode) private var editMode
    
    var body: some View {
        VStack {
            if editMode?.wrappedValue.isEditing == true {
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
            ingredient: .constant(Ingredient(name: "Cheddar Cheese", quantity: "200g"))
        )
    }
}
