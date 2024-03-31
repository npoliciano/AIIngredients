//
//  CapstoneApp.swift
//  Capstone
//
//  Created by Nicolle on 14/11/23.
//

import SwiftUI

@main
struct CapstoneApp: App {
  init() {  // Configures the application's state for UI test
    setupForTestingIfNeeded()
  }

  var body: some Scene {
    WindowGroup {
      OnboardingFlowView()
    }
  }

  // Checks if the application was launched with specific arguments (UITesting)
  private func setupForTestingIfNeeded() {
    guard ProcessInfo.processInfo.arguments.contains("UITesting") else {
      return
    }

    // It clears any saved settings or data specific to this app, ensuring that tests start with a clean state.
    clearUserDefaults()
  }

  // It retrieves the app's bundle identifier and uses it to remove its persistent domain from UserDefaults.
  private func clearUserDefaults() {
    guard let bundleIdentifier = Bundle.main.bundleIdentifier else {
      return
    }
    UserDefaults.standard.removePersistentDomain(forName: bundleIdentifier)
  }
}
