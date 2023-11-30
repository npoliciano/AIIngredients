//
//  Onboarding1Image.swift
//  Capstone
//
//  Created by Nicolle on 26/11/23.
//

import SwiftUI

struct Onboarding1Image: View {
  @State var isAnimating = false

  var repeatingAnimation: Animation {
    Animation.linear(duration: 0.9).repeatForever()
  }

  var body: some View {
    ZStack {
      Image("Onboarding1_1")
        .resizable()
        .scaledToFit()

      Image("Onboarding1_2")
        .resizable()
        .scaledToFit()
        .scaleEffect(isAnimating ? 1.05 : 1)
        .opacity(isAnimating ? 1 : 0.9)
        .animation(repeatingAnimation, value: isAnimating)
        .shadow(radius: 5)
    }
    .onAppear {
      self.isAnimating = true
    }
  }
}

struct Onboarding1Image_Previews: PreviewProvider {
  static var previews: some View {
    Onboarding1Image()
  }
}
