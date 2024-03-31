//
//  FeaturesOnboardingPageView.swift
//  Capstone
//
//  Created by Nicolle on 14/11/23.
//

import SwiftUI

// The struct is generic, taking a View type as a parameter.
struct FeaturesOnboardingPageView<OnboardingImage: View>: View {
  typealias Str = Strings.OnboardingPage
  let image: String
  let featureTitle: String
  let featureDescription: String
  // This is a view builder that allows injecting custom views for the onboarding image.
  @ViewBuilder let onboardingImage: () -> OnboardingImage
  let onStart: () -> Void

  // This property observes the environment's vertical size class (compact or regular) to adjust the layout.
  @Environment (\.verticalSizeClass)
  private var verticalSizeClass

  var body: some View {
    VStack(spacing: 24) {
      HStack {
        Spacer()

        Button {
          onStart()
        } label: {
          Text(Str.start)
            .font(.headline)
            .bold()
            .frame(width: 90)
            .padding(8)
            .overlay(
              RoundedRectangle(cornerRadius: 24)
                .stroke(Color.accentColor, lineWidth: 2))
        }
      }

      if verticalSizeClass == .compact {
        HStack(spacing: 24) {
          illustration
          textContent
        }
      } else {
        VStack(spacing: 24) {
          illustration
          textContent
        }
      }

      Divider()
    }
    .padding(24)
    .padding(.bottom, 24)
  }

  private var illustration: some View {
    VStack {
      onboardingImage()
        .padding()
    }
  }

  private var textContent: some View {
    VStack(alignment: .leading, spacing: 16) {
      Text(featureTitle)
        .font(.title)
        .fontWeight(.heavy)
        .lineLimit(3)

      Text(featureDescription)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    .multilineTextAlignment(.leading)
    .padding()
  }
}

struct FeaturesOnboardingPageView_Previews: PreviewProvider {
  static var previews: some View {
    FeaturesOnboardingPageView(
      image: "Placeholder",
      featureTitle: "AI-Powered Ingredient Lists",
      // swiftlint:disable:next line_length
      featureDescription: "Input any meal you're planning to shop for, and our AI will instantly generate a detailed ingredient list for you. Experience the ease and innovation in shopping for your meals!",
      onboardingImage: {
        Onboarding1Image()
      },
      onStart: {}
    )
  }
}
