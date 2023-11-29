//
//  CapstoneApp.swift
//  Capstone
//
//  Created by Nicolle on 14/11/23.
//

import SwiftUI

@main
struct CapstoneApp: App {
  init() {
    setupForTestingIfNeeded()
  }

  var body: some Scene {
    WindowGroup {
      OnboardingFlowView()
    }
  }

  private func setupForTestingIfNeeded() {
    guard ProcessInfo.processInfo.arguments.contains("UITesting") else {
      return
    }

    clearUserDefaults()
  }

  private func clearUserDefaults() {
    guard let bundleIdentifier = Bundle.main.bundleIdentifier else {
      return
    }
    UserDefaults.standard.removePersistentDomain(forName: bundleIdentifier)
  }
}
