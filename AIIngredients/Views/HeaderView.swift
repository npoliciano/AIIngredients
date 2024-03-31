//
//  HeaderView.swift
//  AIIngredients
//
//  Created by Nicolle on 25/11/23.
//

import SwiftUI

struct HeaderView: View {
  let title: String
  let headline: String

  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text(title)
        .font(.title3)
      Text(headline)
        .foregroundStyle(.secondary)
    }
  }
}

struct HeaderView_Previews: PreviewProvider {
  static var previews: some View {
    // swiftlint:disable:next line_length
    HeaderView(title: "Tailor Your Experience to Your Taste!", headline: "Let us know what suits your diet, and we'll customize your experience accordingly. Please select any dietary preferences that apply to you from the options below.")
  }
}
