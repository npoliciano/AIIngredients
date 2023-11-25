//
//  MealsView.swift
//  Capstone
//
//  Created by Nicolle on 25/11/23.
//

import SwiftUI

struct MealsView: View {
    @Binding var shoppingLists: [Meal]
    let isExpanded: Bool
    let onTapMeal: (Meal) -> Void
    
    private func allSelected(meal: Meal) -> Bool {
        meal.ingredients.allSatisfy { $0.isSelected }
    }
    
    var body: some View {
        List($shoppingLists) { $meal in
            Section {
                ForEach(Array(meal.ingredients.indices), id: \.self) { index in
                    if index < 3 || isExpanded {
                        SelectableIngredientView(ingredient: $meal.ingredients[index])
                            .padding(.vertical, 4)
                            .padding(.bottom, 4)
                    }
                }
                
                if meal.ingredients.count > 3, !isExpanded {
                    VStack(alignment: .leading) {
                        Divider()
                        Button {
                            onTapMeal(meal)
                        } label: {
                            HStack(spacing: 4) {
                                Text("See all")
                                    .font(.callout)
                                
                                Image(systemName: "chevron.right")
                                    .imageScale(.small)
                            }
                            .foregroundStyle(Color.accentColor)
                        }
                        .padding(.top, 4)
                        
                    }
                    .padding(.bottom, 9)
                }
            } header: {
                HStack {
                    Text(meal.name)
                        .font(.title3)
                        .fontWeight(.medium)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(allSelected(meal: meal) ? .secondary : .primary)
                        .strikethrough(allSelected(meal: meal))
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.secondary)
                }
                .padding(.bottom, 8)
                .foregroundStyle(.primary)
                .contentShape(Rectangle())
                .onTapGesture {
                    onTapMeal(meal)
                }
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
    }
}

struct MealsView_Previews: PreviewProvider {
    static let meals = [
        Meal(name: "Chicken Pie", ingredients: [
            Ingredient(name: "Chicken Breast", quantity: "200g"),
            Ingredient(name: "Chicken Breast", quantity: "200g"),
            Ingredient(name: "Chicken Breast", quantity: "200g"),
            Ingredient(name: "Chicken Breast", quantity: "200g"),
            Ingredient(name: "Chicken Breast", quantity: "200g"),
            Ingredient(name: "Chicken Breast", quantity: "200g"),
        ]),
        Meal(name: "Chicken Pie", ingredients: [
            Ingredient(name: "Chicken Breast", quantity: "200g"),
            Ingredient(name: "Chicken Breast", quantity: "200g"),
            Ingredient(name: "Chicken Breast", quantity: "200g"),
            Ingredient(name: "Chicken Breast", quantity: "200g"),
            Ingredient(name: "Chicken Breast", quantity: "200g"),
            Ingredient(name: "Chicken Breast", quantity: "200g"),
        ]),
        Meal(name: "Chicken Pie", ingredients: [
            Ingredient(name: "Chicken Breast", quantity: "200g"),
            Ingredient(name: "Chicken Breast", quantity: "200g"),
            Ingredient(name: "Chicken Breast", quantity: "200g"),
            Ingredient(name: "Chicken Breast", quantity: "200g"),
            Ingredient(name: "Chicken Breast", quantity: "200g"),
            Ingredient(name: "Chicken Breast", quantity: "200g"),
        ])
    ]
    
    static var previews: some View {
        MealsView(
            shoppingLists: .constant(meals),
            isExpanded: false,
            onTapMeal: { _ in }
        )
        .previewDisplayName("Collapsed")
        
        MealsView(
            shoppingLists: .constant(meals),
            isExpanded: true,
            onTapMeal: { _ in }
        )
        .previewDisplayName("Expanded")
    }
}
