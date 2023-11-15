//
//  NewRecipeView.swift
//  Capstone
//
//  Created by Nicolle on 14/11/23.
//

import SwiftUI

struct NewRecipeView: View {
  @State var recipeName: String = ""
  @State var quantity: String = "0g"
  @State var portion: String = "1"
  
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
        Button("ADD") {
          print("Button")
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
      .navigationBarTitle("Add a new Recipe")
    }
}

struct NewRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        NewRecipeView()
    }
}
