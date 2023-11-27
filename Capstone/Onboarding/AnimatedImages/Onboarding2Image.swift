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
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    var body: some View {
        Image(.onboarding21)
            .resizable()
            .scaledToFit()
            .background(
                GeometryReader { proxy in
                    Color.clear
                        .onAppear {
                            size = proxy.size
                        }
                }
            )
            .overlay(
                Group {
                    if verticalSizeClass != .compact {
                        Image(.onboarding22)
                            .resizable()
                            .scaledToFit()
                            .rotationEffect(.degrees(isRotating))
                            .frame(width: size.width/2.5, height: size.height/2.5)
                            .offset(y: -size.height/8)
                    } else {
                        EmptyView()
                    }
                }
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
