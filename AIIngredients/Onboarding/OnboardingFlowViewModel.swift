//
//  OnboardingFlowViewModel.swift
//  AIIngredients
//
//  Created by Nicolle on 21/11/23.
//

import Foundation

final class OnboardingFlowViewModel: ObservableObject {
  @Published var onboardingStatus: OnboardingStatus? {
    didSet {
      userDefaults.onboardingStatus = onboardingStatus
    }
  }

  private let userDefaults: UserDefaults

  init(userDefaults: UserDefaults = .standard) {
    self.userDefaults = userDefaults
    onboardingStatus = userDefaults.onboardingStatus
  }

  func nextStep() {
    switch onboardingStatus {
    case .none:
      onboardingStatus = .pendingName
    case .pendingName:
      onboardingStatus = .pendingPreferences
    case .pendingPreferences:
      onboardingStatus = .complete
    case .complete:
      break
    }
  }
}

enum OnboardingStatus: String, Codable {
  case pendingName
  case pendingPreferences
  case complete
}
