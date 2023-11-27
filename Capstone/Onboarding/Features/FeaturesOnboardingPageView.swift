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
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            onboardingImage()
                .padding()
                
            Spacer()
            
            VStack(alignment: .leading, spacing: 16) {
                Text(featureTitle)
                    .font(.title)
                    .offset(x: 0)
                    .fontWeight(.heavy)
                
                Text(featureDescription)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .multilineTextAlignment(.leading)
            .padding()
            
            Divider()
        }
        .overlay(
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
            },
            alignment: .topTrailing
        )
        .padding(24)
        .padding(.bottom, 24)
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
