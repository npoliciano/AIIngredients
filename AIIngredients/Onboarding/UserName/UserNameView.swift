//
//  UserNameView.swift
//  AIIngredients
//
//  Created by Nicolle on 14/11/23.
//

import SwiftUI

struct UserNameView: View {
  typealias Str = Strings.UserName
  @StateObject var viewModel = UserNameViewModel()
  let onTap: () -> Void

  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      HeaderView(
        title: Str.title,
        headline: Str.headline
      )

      LabeledTextField(
        label: Str.label,
        placeholder: Str.placeholder,
        text: $viewModel.userName
      )
      .padding(.top)

      Spacer()

      PrimaryButton(title: Str.next) {
        viewModel.onTap()
        onTap()
      }
      .disabled(viewModel.userName.isEmpty)
    }
    .padding()
  }
}


struct UserNameView_Previews: PreviewProvider {
  static var previews: some View {
    UserNameView(viewModel: UserNameViewModel()) {}
  }
}
