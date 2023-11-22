//
//  UserPreferencesView.swift
//  Capstone
//
//  Created by Nicolle on 15/11/23.
//

import SwiftUI

struct UserPreferencesView: View {
    let onTap: () -> Void
    @StateObject var viewModel = UserPreferencesViewModel()
    
    var body: some View {
        VStack {
            Form {
                Section("Dietary Preferences") {
                    Toggle("Gluten Free", isOn: $viewModel.preferences.glutenFree)
                    
                    Toggle("Lactose Free", isOn: $viewModel.preferences.lactoseFree)
                    
                    Toggle("Sugar Free", isOn: $viewModel.preferences.sugarFree)
                    
                    Toggle("Vegan", isOn: $viewModel.preferences.vegan)
                    
                    Toggle("Vegeterian", isOn: $viewModel.preferences.vegetarian)
                }
            }
            
            Button {
                viewModel.onTap()
                onTap()
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
        UserPreferencesView(onTap: {})
    }
}
