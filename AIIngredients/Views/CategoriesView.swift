//
//  CategoriesView.swift
//  AIIngredients
//
//  Created by Nicolle on 27/11/23.
//

import SwiftUI

struct CategoriesView: View {
  typealias Str = Strings.Categories
  let categories: [Category]

  var body: some View {
    VStack(alignment: .leading, spacing: 16) {
      ForEach(categories, id: \.self) { category in
        HStack(spacing: 8) {
          switch category {
          case .proteins:
            Image("meat")
              .resizable()
              .scaledToFit()
              .frame(width: 22, height: 24)
              .foregroundStyle(Color("Salmon"))
            Text(Str.protein)
          case .carbo:
            Image(systemName: "circle.hexagongrid")
              .frame(width: 22)
              .foregroundStyle(Color("Maroon"))
            Text(Str.carbo)
          case .veggies:
            Image(systemName: "carrot")
              .frame(width: 22)
              .foregroundStyle(Color("Aspargus"))
            Text(Str.veggies)
          case .dairy:
            Image("dairy")
              .resizable()
              .scaledToFit()
              .frame(width: 22, height: 20)
              .foregroundStyle(Color("Sky"))
            Text(Str.dairy)
          case .seasonings:
            Image(systemName: "loupe")
              .frame(width: 22)
              .foregroundStyle(.brown)
            Text(Str.seasonings)
          }
        }
      }
    }
    .font(.subheadline)
  }
}

struct CategoriesView_Previews: PreviewProvider {
  static var previews: some View {
    CategoriesView(categories: [.proteins, .dairy, .seasonings, .carbo, .veggies])
  }
}
