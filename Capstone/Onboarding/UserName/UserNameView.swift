//
//  UserNameView.swift
//  Capstone
//
//  Created by Nicolle on 14/11/23.
//

import SwiftUI

struct UserNameView: View {
    @StateObject var viewModel = UserNameViewModel()
    let onTap: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HeaderView(
                title: "Who are you?",
                headline: "We're excited to have you on board. Let's personalize your experience. Please enter your name below."
            )

            LabeledTextField(
                label: "First name",
                placeholder: "John Appleseed",
                text: $viewModel.userName
            )
            .padding(.top)

            Spacer()

            PrimaryButton(title: "Next", onTap: {
                viewModel.onTap()
                onTap()
            })
            .disabled(viewModel.userName.isEmpty)
        }
        .padding()
    }
}


struct UserNameView_Previews: PreviewProvider {
    static var previews: some View {
        UserNameView(viewModel: UserNameViewModel(), onTap: {})
    }
}
