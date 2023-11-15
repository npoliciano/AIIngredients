//
//  NewShoppingListView.swift
//  Capstone
//
//  Created by Nicolle on 14/11/23.
//

import SwiftUI

struct NewShoppingListView: View {
    @State var recipeName: String = ""
    @State var quantity: String = "0g"
    @State var portion: String = "1"
    
    @State var isShowingPreview = false
    
    var body: some View {
        VStack {
            Form {
                Section {
                    TextField("Stroganoff", text: $recipeName)
                } header: {
                    Text("Recipe Name")
                }
                Section {
                    TextField("0g", text: $quantity)
                } header: {
                    Text("Quantity")
                }
                Section {
                    TextField("1", text: $portion)
                } header: {
                    Text("Portion")
                }
            }
            Button("Generate") {
                isShowingPreview = true
            }
            .font(.headline)
            .bold()
            .foregroundColor(Color.white)
            .frame(width: 100)
            .padding()
            .background(Color.blue)
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.white, lineWidth: 2)
            )
            Spacer()
        }
        .sheet(isPresented: $isShowingPreview) {
            ShoppingListPreviewView(onOk: {
                isShowingPreview = false
            })
        }
    }
}

struct NewShoppingListView_Previews: PreviewProvider {
    static var previews: some View {
        NewShoppingListView()
    }
}
