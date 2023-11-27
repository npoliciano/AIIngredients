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
            Image(.onboarding11)
                .resizable()
                .scaledToFit()
            
            Image(.onboarding12)
                .resizable()
                .scaledToFit()
                .scaleEffect(isAnimating ? 1.05: 1)
                .opacity(isAnimating ? 1 : 0.9)
                .animation(repeatingAnimation, value: isAnimating)
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
