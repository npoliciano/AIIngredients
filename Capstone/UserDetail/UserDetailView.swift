//
//  UserDetailView.swift
//  Capstone
//
//  Created by Nicolle on 14/11/23.
//

import SwiftUI

struct UserDetailView: View {
  typealias Str = Strings.UserDetail
  @StateObject var viewModel = UserDetailViewModel()
  let onStart: () -> Void

  var body: some View {
    NavigationStack {
      Form {
        DietaryPreferencesView(title: Str.dietaryPreferences, preferences: $viewModel.preferences)

        Section {
          HStack {
            Text(Str.appVersionTitle)
            Spacer()
            Text(Str.appVersion)
              .foregroundColor(.secondary)
          }
        } footer: {
          Text(Str.text)
            .padding(.vertical)
        }
      }
      .navigationTitle($viewModel.userName)
    }
  }
}

struct UserDetailView_Previews: PreviewProvider {
  static var previews: some View {
    UserDetailView {}
  }
}
