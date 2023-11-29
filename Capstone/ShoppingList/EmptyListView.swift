//
//  EmptyListView.swift
//  Capstone
//
//  Created by Nicolle on 15/11/23.
//

import SwiftUI

struct EmptyListView: View {
  typealias Str = Strings.EmptyList
  let onTap: () -> Void

  var body: some View {
    VStack(spacing: 16) {
      Image(systemName: "cart.badge.plus")
        .font(.system(size: 60))
        .foregroundStyle(.tertiary)

      Text(Str.text)
        .foregroundStyle(.secondary)
        .padding(.horizontal, 30)
        .multilineTextAlignment(.center)
        .padding(.bottom)

      PrimaryButton(title: Str.startAdding) {
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
