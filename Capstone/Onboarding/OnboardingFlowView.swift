//
//  OnboardingFlowView.swift
//  Capstone
//
//  Created by Nicolle on 14/11/23.
//

import SwiftUI

struct OnboardingFlowView: View {
    @State private var path = NavigationPath()
    @State private var isUserNamePresented = false
    @State private var isHomePresented = false

    @StateObject var viewModel = OnboardingFlowViewModel()

    var body: some View {
        switch viewModel.onboardingStatus {
        case .none:
            FeaturesOnboardingView(onStart: {
                viewModel.nextStep()
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
            viewModel.nextStep()
            isHomePresented = true
        })
        .navigationBarTitle("Dietary Preferences")
        .fullScreenCover(isPresented: $isHomePresented) {
            HomeView()
        }
    }

    private var userNameView: some View {
        NavigationStack(path: $path) {
            UserNameView(onTap: {
                viewModel.nextStep()
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

struct OnboardingFlowView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingFlowView()
    }
}
