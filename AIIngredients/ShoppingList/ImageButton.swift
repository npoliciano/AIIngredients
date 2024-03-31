//
//  ImageButton.swift
//  AIIngredients
//
//  Created by Nicolle on 14/11/23.
//

import SwiftUI

struct ImageButton: View {
  let systemName: String
  let action: () -> Void

  var body: some View {
    Button {
      action()
    } label: {
      Image(systemName: systemName)
        .font(.title3)
        .bold()
    }
  }
}

struct PlusButton_Previews: PreviewProvider {
  static var previews: some View {
    ImageButton(systemName: "plus.circle") {}
  }
}
