//
//  ShoppingListPreviewView.swift
//  Capstone
//
//  Created by Nicolle on 14/11/23.
//

import SwiftUI

struct ShoppingListReviewView: View {
    let generatedList: GeneratedList
    let onOk: () -> Void
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Review Your Shopping List")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Satisfied with your ingredients? If there's anything amiss, go ahead and customize the list to your taste!")
                        .foregroundColor(.secondary)
                        .padding(.bottom)
                    
                    VStack(alignment: .leading, spacing: 20) {
                        Label(generatedList.name, systemImage: "cart")
                            .fontWeight(.medium)
                            .foregroundStyle(.secondary)
                        
                        Divider()
                        
                        LazyVStack(spacing: 16) {
                            ForEach(generatedList.items) { item in
                                HStack {
                                    Text(item.name)
                                        .font(.subheadline)
                                    Spacer()
                                    Text(item.quantity)
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                }
                            }
                        }
                    }
                    .padding(4)
                }
            }
            
            VStack(spacing: 16) {
                Button {
                    onOk()
                } label: {
                    Text("Confirm Selection")
                        .foregroundColor(Color.white)
                        .padding()
                        .cornerRadius(16)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.accentColor)
                        )
                }
                
                Button("Make Changes") {
                    onOk()
                }
                .padding(.bottom)
            }
        }
        .padding()
    }
}

struct ShoppingListReviewView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingListReviewView(
            generatedList: GeneratedList(
                name: "Ceasar Salad",
                items: [
                    Item(name: "Letuce", quantity: "as needed"),
                    Item(name: "Cheese", quantity: "20 g"),
                    Item(name: "Milk", quantity: "200 ml"),
                    Item(name: "Ceasar Sauce", quantity: "30 g")
                ]),
            onOk: { }
        )
    }
}
