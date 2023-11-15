//
//  OnboardingView.swift
//  Capstone
//
//  Created by Nicolle on 14/11/23.
//

import SwiftUI

struct OnboardingView: View {
    let onStart: () -> Void
    
    var body: some View {
        TabView {
            OnboardingPageView(image: "Placeholder", featureTitle: "Feature A", featureDescription: "Enter your desired recipe, and watch as we provide you with a convenient weekly list of ingredients along with their quantities", onStart: onStart)
            OnboardingPageView(image: "Placeholder", featureTitle: "Feature B", featureDescription: "Enter your desired recipe, and watch as we provide you with a convenient weekly list of ingredients along with their quantities", onStart: onStart)
            OnboardingPageView(image: "Placeholder", featureTitle: "Feature C", featureDescription: "Enter your desired recipe, and watch as we provide you with a convenient wepath.append(Destination.userName)ekly list of ingredients along with their quantities", onStart: onStart)
        }
        .tabViewStyle(.page)
        .padding(.vertical, -20)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(onStart: {})
    }
}
