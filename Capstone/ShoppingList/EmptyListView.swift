//
//  EmptyListView.swift
//  Capstone
//
//  Created by Nicolle on 15/11/23.
//

import SwiftUI

struct EmptyListView: View {
  let onTap: () -> Void

  var body: some View {
    VStack(spacing: 16) {
      Image(systemName: "cart.badge.plus")
        .font(.system(size: 60))
        .foregroundStyle(.tertiary)

      Text("Your list is currently empty, but don't worry, start adding new meals now to make the most of our app!")
        .foregroundStyle(.secondary)
        .padding(.horizontal, 30)
        .multilineTextAlignment(.center)
        .padding(.bottom)

      PrimaryButton(title: "Start Adding") {
        onTap()
      }
    }
    .padding(30)
  }
}

struct EmptyListView_Previews: PreviewProvider {
  static var previews: some View {
    EmptyListView {}
  }
}
