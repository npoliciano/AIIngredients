//
//  SelectableIngredientView.swift
//  Capstone
//
//  Created by Nicolle on 24/11/23.
//

import SwiftUI

struct SelectableIngredientView: View {
    let name: String
    let quantity: String
    
    @State var isSelected = false
    
    var body: some View {
        HStack {
            Image(systemName: isSelected ? "square.inset.filled" : "square")
                .opacity(0.3)
            IngredientView(
                name: name,
                quantity: quantity
            )
            .strikethrough(isSelected)
            .opacity(isSelected ? 0.5 : 1)
        }
        
        .onTapGesture {
            withAnimation {
                isSelected.toggle()
            }
        }
    }
}

struct SelectableIngredientView_Previews: PreviewProvider {
    static var previews: some View {
        SelectableIngredientView(name: "Cheddar Cheese", quantity: "200g")
    }
}
