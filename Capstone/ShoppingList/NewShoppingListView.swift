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
    @State var isShowingError = false
    @State var isLoading = false
    
    @Environment(\.dismiss) var dismiss
    
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
            Button(action: {
                isLoading = true
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    isLoading = false
                    if recipeName.isEmpty {
                        isShowingError = true
                    } else {
                        isShowingPreview = true
                    }
                }
            }) {
                if isLoading {
                    ProgressView()
                        .controlSize(.large)
                } else {
                    Text("Generate")
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
                }
            }
            .alert(isPresented: $isShowingError) {
                Alert(title: Text("Error"), message: Text("An error occurred."),
                      dismissButton: .default(Text("OK")))
            }
            Spacer()
        }
        .sheet(isPresented: $isShowingPreview) {
            ShoppingListPreviewView(onOk: {
                dismiss()
            })
        }
    }
}

struct NewShoppingListView_Previews: PreviewProvider {
    static var previews: some View {
        NewShoppingListView()
    }
}
