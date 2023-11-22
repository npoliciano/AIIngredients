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
        VStack {
            Form {
                Section {
                    TextField("Name", text: $viewModel.userName)
                } header: {
                    Text("Name")
                }
            }
            Button {
                viewModel.onTap()
                onTap()
            } label: {
                Text("Next")
                    .foregroundColor(Color.white)
                    .padding()
                    .cornerRadius(16)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.accentColor)
                    )
            }
            .disabled(viewModel.userName.isEmpty)
            .padding()
        }
    }
}


struct UserNameView_Previews: PreviewProvider {
    static var previews: some View {
        UserNameView(viewModel: UserNameViewModel(), onTap: {})
    }
}
