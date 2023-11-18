//
//  ShoppingListPreviewView.swift
//  Capstone
//
//  Created by Nicolle on 14/11/23.
//

import SwiftUI

struct ShoppingListReviewView: View {
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

struct ShoppingListReviewView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingListReviewView(onOk: { })
    }
}
