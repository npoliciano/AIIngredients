//
//  UserNameViewModel.swift
//  AIIngredients
//
//  Created by Nicolle on 21/11/23.
//

import Foundation

final class UserNameViewModel: ObservableObject {
  @Published var userName: String = ""

  private let userDefaults: UserDefaults

  init(userDefaults: UserDefaults = .standard) {
    self.userDefaults = userDefaults
  }

  func onTap() {
    if !userName.isEmpty {
      userDefaults.userName = userName
    }
  }
}
