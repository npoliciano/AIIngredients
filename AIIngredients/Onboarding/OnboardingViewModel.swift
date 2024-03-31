//
//  OnboardingViewModel.swift
//  Capstone
//
//  Created by Nicolle on 21/11/23.
//

import Foundation

final class OnboardingViewModel: ObservableObject {
  @Published var image = "Placeholder"
  @Published var featureTitle = "Feature A"
  // swiftlint:disable:next line_length
  @Published var featureDescription = "Enter your desired recipe, and watch as we provide you with a convenient weekly list of ingredients along with their quantities"
}
