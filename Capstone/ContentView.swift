//
//  ContentView.swift
//  Capstone
//
//  Created by Nicolle on 14/11/23.
//

import SwiftUI

struct ContentView: View {
  @State private var path = NavigationPath()
  @State var isShowingUserName = false
  @State var isShowingHome = false
  
  var body: some View {
    OnboardingView(onStart: {
      isShowingUserName = true
    })
    .fullScreenCover(isPresented: $isShowingUserName) {
      NavigationStack(path: $path) {
        UserNameView(onStart: {
          path.append(Destination.userDetail)
        })
        .navigationDestination(for: Destination.self) { destination in
          UserDetailView(onStart: {
            isShowingHome = true
          })
          .fullScreenCover(isPresented: $isShowingHome) {
            HomeView()
          }
        }
      }
    }
  }
}

enum Destination: Hashable {
  case userDetail
  case newRecipe
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
