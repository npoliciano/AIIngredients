//
//  CategoriesView.swift
//  Capstone
//
//  Created by Nicolle on 27/11/23.
//

import SwiftUI

struct CategoriesView: View {
    let categories: [Category]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            ForEach(categories, id: \.self) { category in
                HStack(spacing: 8) {
                    switch category {
                    case .proteins:
                        Image(.meat)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 22, height: 24)
                            .foregroundStyle(Color(.salmon))
                        Text("Proteins")
                    case .carbo:
                        Image(systemName: "circle.hexagongrid")
                            .frame(width: 22)
                            .foregroundStyle(Color(.maroon))
                        Text("Grains and Carbohydrates")
                    case .veggies:
                        Image(systemName: "carrot")
                            .frame(width: 22)
                            .foregroundStyle(Color(.aspargus))
                        Text("Fruits and Vegetables")
                    case .dairy:
                        Image(.dairy)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 22, height: 20)
                            .foregroundStyle(Color(.sky))
                        Text("Dairy and Alternatives")
                    case .seasonings:
                        Image(systemName: "loupe")
                            .frame(width: 22)
                            .foregroundStyle(.brown)
                        Text("Seasonings and Condiments")
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
