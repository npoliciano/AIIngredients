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
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 24) {
                HeaderView(
                    title: "Tailor Your Experience to Your Taste!",
                    headline: "Let us know what suits your diet, and we'll customize your experience accordingly. Please select any dietary preferences that apply to you from the options below."
                )
                
                VStack(alignment: .leading) {
                    Text("Preferences")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                    DietaryPreferencesView(preferences: $viewModel.preferences)
                }
            }
            
            Spacer()
            
            PrimaryButton(title: "Next", onTap: {
                viewModel.onTap()
                onTap()
            })
        }
        .padding()
    }
}

struct UserPreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        UserPreferencesView(onTap: {})
    }
}
