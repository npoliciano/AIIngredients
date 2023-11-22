//
//  UserDetailView.swift
//  Capstone
//
//  Created by Nicolle on 14/11/23.
//

import SwiftUI

struct UserDetailView: View {
    @StateObject var viewModel = UserDetailViewModel()
    let onStart: () -> Void
    
    var body: some View {
        
        VStack() {
            Text(viewModel.userName)
                .font(.largeTitle)
                .padding()
            
            Form {
                Section("DietaryPreferences") {
                    Toggle("Gluten", isOn: $viewModel.preferences.glutenFree)
                    
                    Toggle("Lactose", isOn: $viewModel.preferences.lactoseFree)
                    
                    Toggle("Sugar", isOn: $viewModel.preferences.sugarFree)
                    
                    Toggle("Vegan", isOn: $viewModel.preferences.vegan)
                    
                    Toggle("Vegeterian", isOn: $viewModel.preferences.vegetarian)
                }
            }
        }
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailView(onStart: {})
    }
}
