//
//  OnboardingFlowView.swift
//  Capstone
//
//  Created by Nicolle on 14/11/23.
//

import SwiftUI

struct OnboardingFlowView: View {
  typealias Str = Strings.OnboardingFlow
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
      // full screen cover to prevent from going back
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
    UserPreferencesView {
      viewModel.nextStep()
      isHomePresented = true
    }
    .navigationBarTitle(Str.dietaryPreferences)
    .fullScreenCover(isPresented: $isHomePresented) {
      HomeView()
    }
  }

  private var userNameView: some View {
    NavigationStack(path: $path) {
      UserNameView {
        viewModel.nextStep()
        path.append(UserPreferencesDestination())
      }
      .navigationBarTitle(Str.enterYourName)
      .navigationDestination(for: UserPreferencesDestination.self) { _ in
        UserPreferencesView {}
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
