//
//  OnboardingPageView.swift
//  Capstone
//
//  Created by Nicolle on 14/11/23.
//

import SwiftUI

struct OnboardingPageView: View {
  let image: String
  let featureTitle: String
  let featureDescription: String
  let onStart: () -> Void
  
  var body: some View {
    VStack(spacing: 58){
      
      Image(image)
        .resizable()
        .scaledToFit()
        .padding()
      
      Text(featureTitle)
      
      Text(featureDescription)
        .padding()
      
      Button {
        onStart()
      } label: {
        Text("Start")
          .font(.headline)
          .bold()
          .foregroundColor(Color.white)
          .frame(width: 100)
          .padding()
          .background(Color.blue)
          .cornerRadius(16)
          .overlay(
            RoundedRectangle(cornerRadius: 16)
              .stroke(Color.white, lineWidth: 2))
      }
    }
  }
}

struct OnboardingPageView_Previews: PreviewProvider {
  static var previews: some View {
    OnboardingPageView(image: "Placeholder", featureTitle: "Feature A", featureDescription: "Enter your desired recipe, and watch as we provide you with a convenient weekly list of ingredients along with their quantities", onStart: {})
  }
}
