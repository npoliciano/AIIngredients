//
//  PlusButton.swift
//  Capstone
//
//  Created by Nicolle on 14/11/23.
//

import SwiftUI

struct PlusButton: View {
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

struct PlusButton_Previews: PreviewProvider {
    static var previews: some View {
        PlusButton(action: {})
    }
}
