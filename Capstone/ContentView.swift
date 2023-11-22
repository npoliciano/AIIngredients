//
//  ContentView.swift
//  Capstone
//
//  Created by Nicolle on 14/11/23.
//

import SwiftUI

struct ContentView: View {
    @State private var path = NavigationPath()
    @State private var isUserNamePresented = false
    @State private var isHomePresented = false
    
    @AppStorage("onboardingStatus") var onboardingStatus: OnboardingStatus?
    
    var body: some View {
        switch onboardingStatus {
        case .none:
            OnboardingView(onStart: {
                onboardingStatus = .pendingName
                isUserNamePresented = true
            })
            .fullScreenCover(isPresented: $isUserNamePresented) {
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
        UserPreferencesView(onTap: {
            onboardingStatus = .complete
            isHomePresented = true
        })
        .fullScreenCover(isPresented: $isHomePresented) {
            HomeView()
        }
    }
    
    private var userNameView: some View {
        NavigationStack(path: $path) {
            UserNameView(onStart: {
                onboardingStatus = .pendingPreferences
                path.append(UserPreferencesDestination())
            })
            .navigationBarTitle("Enter your name")
            .navigationDestination(for: UserPreferencesDestination.self) { _ in
                UserPreferencesView(onTap: {})
            }
        }
    }
}

struct UserPreferencesDestination: Hashable { }

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
