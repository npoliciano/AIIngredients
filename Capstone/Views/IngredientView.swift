//
//  IngredientView.swift
//  Capstone
//
//  Created by Nicolle on 24/11/23.
//

import SwiftUI

struct IngredientView: View {
  let name: String
  let quantity: String

  var body: some View {
    HStack {
      Text(name)
        .font(.subheadline)
      Spacer()
      Text(quantity)
        .font(.subheadline)
        .foregroundStyle(.secondary)
    }
  }
}

struct IngredientView_Previews: PreviewProvider {
  static var previews: some View {
    IngredientView(
      name: "Olive Oil",
      quantity: "10 ml"
    )
  }
}
