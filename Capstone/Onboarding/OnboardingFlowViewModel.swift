//
//  OnboardingFlowViewModel.swift
//  Capstone
//
//  Created by Nicolle on 21/11/23.
//

import Foundation

final class OnboardingFlowViewModel: ObservableObject {
    @Published var onboardingStatus = UserDefaults.standard.onboardingStatus {
        didSet {
            UserDefaults.standard.onboardingStatus = onboardingStatus
        }
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
