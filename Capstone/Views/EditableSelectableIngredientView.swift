//
//  EditableSelectableIngredientView.swift
//  Capstone
//
//  Created by Nicolle on 24/11/23.
//

import SwiftUI

struct EditableSelectableIngredientView: View {
    @Binding var item: Item
    @Environment(\.editMode) private var editMode
    
    var body: some View {
        VStack {
            if editMode?.wrappedValue.isEditing == true {
                HStack {
                    TextField("", text: $item.name)
                        .font(.subheadline)
                    Spacer()
                    TextField("", text: $item.quantity)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.trailing)
                }
            } else {
                SelectableIngredientView(
                    name: item.name,
                    quantity: item.quantity
                )
                .padding(.trailing, -0.5)
            }
        }
    }
}

struct EditableSelectableIngredientView_Previews: PreviewProvider {
    static var previews: some View {
        EditableSelectableIngredientView(
            item: .constant(Item(name: "Cheddar Cheese", quantity: "200g"))
        )
    }
}
