//
//  CapstoneApp.swift
//  Capstone
//
//  Created by Nicolle on 14/11/23.
//

import SwiftUI

@main
struct CapstoneApp: App {
    init(){
        // override apple's buggy alerts tintColor
        UIView.appearance().tintColor = UIColor(named: "AccentColor")
    }
    
    var body: some Scene {
        WindowGroup {
            OnboardingFlowView()
        }
    }
}
