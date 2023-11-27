//
//  FeaturesOnboardingView.swift
//  Capstone
//
//  Created by Nicolle on 14/11/23.
//

import SwiftUI

struct FeaturesOnboardingView: View {
    let onStart: () -> Void
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        TabView {
            FeaturesOnboardingPageView(
                image: "Placeholder",
                featureTitle: "AI-Powered Ingredient Lists",
                featureDescription: "Input any meal you're planning to shop for, and our AI will instantly generate a detailed ingredient list for you. Experience the ease and innovation in shopping for your meals!",
                onStart: onStart
            )
            
            FeaturesOnboardingPageView(
                image: "Placeholder",
                featureTitle: "Manage Your Shopping List",
                featureDescription: "Easily edit and organize your shopping list. Maintain total control and save time when shopping!",
                onStart: onStart
            )
            
            FeaturesOnboardingPageView(
                image: "Placeholder",
                featureTitle: "Personalized Dietary Preferences",
                featureDescription: "Customize your meals. Choose preferences like gluten-free or vegan and enjoy ingredients tailored for you!",
                onStart: onStart
            )
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: colorScheme == .light ? .always : .interactive))
        .padding(.vertical, -20)
    }
}

struct FeaturesOnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        FeaturesOnboardingView(onStart: {})
    }
}
