//
//  ShoppingListPreviewView.swift
//  Capstone
//
//  Created by Nicolle on 14/11/23.
//

import SwiftUI

struct ShoppingListPreviewView: View {
    var onOk: () -> Void
    
    var body: some View {
        VStack {
            Text("Your list")
            
            Button("OK") {
                onOk()
            }
        }
    }
}

struct ShoppingListPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingListPreviewView(onOk: { })
    }
}
