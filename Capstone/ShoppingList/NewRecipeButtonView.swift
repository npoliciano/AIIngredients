//
//  NewRecipeButtonView.swift
//  Capstone
//
//  Created by Nicolle on 14/11/23.
//

import SwiftUI

struct NewRecipeButtonView: View {
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: "plus.circle")
                .font(.title3)
                .bold()
        }
    }
}

struct NewRecipeButtonView_Previews: PreviewProvider {
    static var previews: some View {
        NewRecipeButtonView(action: {})
    }
}
