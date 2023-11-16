//
//  UserPreferencesView.swift
//  Capstone
//
//  Created by Nicolle on 15/11/23.
//

import SwiftUI

struct UserPreferencesView: View {
    let onStart: () -> Void
    @State private var glutenFree: Bool = false
    @State private var lactoseFree: Bool = false
    @State private var sugarFree: Bool = false
    @State private var vegan: Bool = false
    @State private var vegetarian: Bool = false
    
    var body: some View {
        VStack {
            Form {
                Section("Restrictions") {
                    Toggle("Gluten", isOn: $glutenFree)
                    
                    Toggle("Lactose", isOn: $lactoseFree)
                    
                    Toggle("Sugar", isOn: $sugarFree)
                    
                    Toggle("Vegan", isOn: $vegan)
                    
                    Toggle("Vegeterian", isOn: $vegetarian)
                }
            }
            
            Button {
                onStart()
            } label: {
                Text("Next")
                    .font(.headline)
                    .bold()
                    .foregroundColor(Color.white)
                    .frame(width: 100)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(16)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.white, lineWidth: 2))
            }
        }
    }
}

struct UserPreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        UserPreferencesView(onStart: {})
    }
}
