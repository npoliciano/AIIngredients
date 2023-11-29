//
//  FeaturesOnboardingView.swift
//  Capstone
//
//  Created by Nicolle on 14/11/23.
//

import SwiftUI

struct FeaturesOnboardingView: View {
  typealias Str = Strings.FeaturesOnboarding
  let onStart: () -> Void

  @Environment(\.colorScheme)
  var colorScheme

  var body: some View {
    TabView {
      FeaturesOnboardingPageView(
        image: "Onboarding1",
        featureTitle: Str.feature1,
        featureDescription: Str.description1,
        onboardingImage: {
          Onboarding1Image()
        },
        onStart: onStart
      )

      FeaturesOnboardingPageView(
        image: "Onboarding2",
        featureTitle: Str.feature2,
        featureDescription: Str.description2,
        onboardingImage: {
          Onboarding2Image()
        },
        onStart: onStart
      )
      FeaturesOnboardingPageView(
        image: "Onboarding3",

        featureTitle: Str.feature3,
        featureDescription: Str.description3,
        onboardingImage: {
          Onboarding3Image()
        },
        onStart: onStart
      )
    }
    .tabViewStyle(.page)
    .indexViewStyle(.page(backgroundDisplayMode: colorScheme == .light ? .always : .interactive))
    .padding(.bottom, -10)
  }
}

struct FeaturesOnboardingView_Previews: PreviewProvider {
  static var previews: some View {
    FeaturesOnboardingView {}
  }
}
