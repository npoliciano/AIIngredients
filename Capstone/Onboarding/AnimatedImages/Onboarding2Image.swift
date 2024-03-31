//
//  Onboarding2Image.swift
//  Capstone
//
//  Created by Nicolle on 26/11/23.
//

import SwiftUI

struct Onboarding2Image: View {
  @State private var isRotating = -10.0
  @State var size: CGSize = .zero

  var body: some View { // Images have different sizes
    Image("Onboarding2_1")
      .resizable()
      .scaledToFit()
      .background(
        // The layout is dynamically calculated based on the size of the main image
        GeometryReader { proxy in
          Color.clear
            .onAppear {
              size = proxy.size
            }
        }
      )
      .overlay(
        Image("Onboarding2_2")
          .resizable()
          .scaledToFit()
          .rotationEffect(.degrees(isRotating))
          .frame(width: size.width, height: size.height / 2.5)
          .offset(x: size.width / 3.5, y: -size.height / 12)
          .shadow(radius: 5)
        , alignment: .topLeading
      )
      .onAppear {
        withAnimation(
          .linear(duration: 1)
          .speed(0.5)
          .repeatForever()
        ) {
          isRotating = 10
        }
      }
  }
}

struct Onboarding2Image_Previews: PreviewProvider {
  static var previews: some View {
    Onboarding2Image()
  }
}
