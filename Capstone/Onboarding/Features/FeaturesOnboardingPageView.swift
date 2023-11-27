//
//  FeaturesOnboardingPageView.swift
//  Capstone
//
//  Created by Nicolle on 14/11/23.
//

import SwiftUI

struct FeaturesOnboardingPageView<OnboardingImage: View>: View {
    let image: String
    let featureTitle: String
    let featureDescription: String
    @ViewBuilder let onboardingImage: () -> OnboardingImage
    let onStart: () -> Void
    
    @Environment (\.verticalSizeClass) private var verticalSizeClass
    
    var body: some View {
        VStack(spacing: 24) {
            HStack {
                Spacer()
                
                Button {
                    onStart()
                } label: {
                    Text("Start")
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
//            Spacer()
            
            onboardingImage()
                .padding()
            
//            Spacer()
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
            featureDescription: "Input any meal you're planning to shop for, and our AI will instantly generate a detailed ingredient list for you. Experience the ease and innovation in shopping for your meals!",
            onboardingImage: {
                Onboarding1Image()
            },
            onStart: {}
        )
    }
}
