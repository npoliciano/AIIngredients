//
//  SelectableIngredientView.swift
//  Capstone
//
//  Created by Nicolle on 24/11/23.
//

import SwiftUI

struct SelectableIngredientView: View {
    @Binding var ingredient: Ingredient

    var body: some View {
        HStack {
            Image(systemName: ingredient.isSelected ? "square.inset.filled" : "square")
                .opacity(0.3)
            IngredientView(
                name: ingredient.name,
                quantity: ingredient.quantity
            )
            .strikethrough(ingredient.isSelected)
            .opacity(ingredient.isSelected ? 0.5 : 1)
        }

        .onTapGesture {
            withAnimation {
                ingredient.isSelected.toggle()
            }
        }
    }
}

struct SelectableIngredientView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SelectableIngredientView(ingredient: .constant(Ingredient(name: "Cheddar Cheese", quantity: "200g")))
            SelectableIngredientView(ingredient: .constant(Ingredient(name: "Cheddar Cheese", quantity: "200g", isSelected: true)))
        }
    }
}
