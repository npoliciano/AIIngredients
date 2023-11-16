//
//  ContentView.swift
//  Capstone
//
//  Created by Nicolle on 14/11/23.
//

import SwiftUI

struct ContentView: View {
    @State private var path = NavigationPath()
    @State private var isShowingUserName = false
    @State private var isShowingHome = false
    
    @AppStorage("onboardingStatus") var onboardingStatus: OnboardingStatus?
    
    var body: some View {
        switch onboardingStatus {
        case .none:
            OnboardingView(onStart: {
                onboardingStatus = .pendingName
                isShowingUserName = true
            })
            .fullScreenCover(isPresented: $isShowingUserName) {
                userNameView
            }
        case .pendingName:
            userNameView
        case .pendingPreferences:
            NavigationStack {
                userPreferencesView
            }
        case .complete:
            HomeView()
        }
    }
    
    // MARK: Screens
    
    private var userPreferencesView: some View {
        UserPreferencesView(onStart: {
            onboardingStatus = .complete
            isShowingHome = true
        })
        .fullScreenCover(isPresented: $isShowingHome) {
            HomeView()
        }
    }
    
    private var userNameView: some View {
        NavigationStack(path: $path) {
            UserNameView(onStart: {
                onboardingStatus = .pendingPreferences
                path.append(Destination.userPreferences)
            })
            .navigationBarTitle("Enter your name")
            .navigationDestination(for: Destination.self) { destination in
                UserPreferencesView(onStart: {})
            }
        }
    }
}

enum Destination: Hashable {
    case userPreferences
    case newRecipe
}

enum OnboardingStatus: String {
    case pendingName
    case pendingPreferences
    case complete
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
