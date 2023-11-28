//
//  PrimaryButton.swift
//  Capstone
//
//  Created by Nicolle on 25/11/23.
//

import SwiftUI

struct PrimaryButton: View {
  let title: String
  let isLoading: Bool
  var onTap: () -> Void

  init(title: String, isLoading: Bool = false, onTap: @escaping () -> Void) {
    self.title = title
    self.isLoading = isLoading
    self.onTap = onTap
  }

  var body: some View {
    Button {
      onTap()
    } label: {
      Group {
        if isLoading {
          ProgressView()
            .tint(.white)
            .progressViewStyle(.circular)
        } else {
          Text(title)
            .foregroundColor(Color.white)
            .padding()
            .cornerRadius(16)
        }
      }
      .frame(maxWidth: .infinity)
      .frame(height: 50)
      .background(
        RoundedRectangle(cornerRadius: 16)
          .fill(Color.accentColor)
      )
    }
  }
}

struct PrimaryButton_Previews: PreviewProvider {
  static var previews: some View {
    PrimaryButton(title: "Generate") {}
  }
}
