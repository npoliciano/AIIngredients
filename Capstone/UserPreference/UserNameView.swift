//
//  UserNameView.swift
//  Capstone
//
//  Created by Nicolle on 14/11/23.
//

import SwiftUI

struct UserNameView: View {
  @State var name: String = ""
  let onStart: () -> Void
  
  var body: some View {
    VStack {
      Form {
        Section {
          TextField("Name", text: $name)
        } header: {
          Text("Name")
        }
      }
      .toolbar {
        ToolbarItem(placement: .bottomBar) {
          Button {
            onStart()
          } label: {
            Text("Get Started")
              .font(.headline)
              .bold()
              .foregroundColor(Color.white)
              .frame(width: 100)
              .padding()
              .background(Color.blue)
              .cornerRadius(16)
              .overlay(
                RoundedRectangle(cornerRadius: 16)
                  .stroke(Color.white, lineWidth: 2))
          }
        }
      }
    }
    .navigationBarTitle("Enter your name")
  }
}


struct UserNameView_Previews: PreviewProvider {
  static var previews: some View {
    UserNameView(onStart: {})
  }
}
