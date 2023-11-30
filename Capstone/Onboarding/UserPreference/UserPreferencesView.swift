//
//  UserPreferencesView.swift
//  Capstone
//
//  Created by Nicolle on 15/11/23.
//

import SwiftUI

struct UserPreferencesView: View {
  typealias Str = Strings.UserPreferences
  let onTap: () -> Void
  @StateObject var viewModel = UserPreferencesViewModel()

  var body: some View {
    VStack(alignment: .leading) {
      ScrollView {
        VStack(alignment: .leading, spacing: 24) {
          HeaderView(
            title: Str.title,
            headline: Str.headline
          )

          VStack(alignment: .leading) {
            Text(Str.preferences)
              .font(.headline)
              .foregroundColor(.secondary)

            DietaryPreferencesView(preferences: $viewModel.preferences)
          }
        }
        .padding()
      }
      PrimaryButton(title: Str.next) {
        viewModel.onTap()
        onTap()
      }
      .padding()
    }
  }
}

struct UserPreferencesView_Previews: PreviewProvider {
  static var previews: some View {
    UserPreferencesView {}
  }
}
