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
        NavigationStack {
            Form {
                DietaryPreferencesView(title: "Dietary Preferences", preferences: $viewModel.preferences)
                
                Section {
                    HStack {
                        Text("App Version")
                        Spacer()
                        Text("v0.1")
                            .foregroundColor(.secondary)
                    }
                } footer: {
                    Text("Please note, our AI's results may not always be accurate or complete. We're constantly refining our technology, but urge caution, especially for dietary restrictions or allergies. Your feedback is crucial to our improvement.")
                        .padding(.vertical)
                }
            }
            .navigationTitle("Nicolle")
        }
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailView(onStart: {})
    }
}
