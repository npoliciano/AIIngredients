//
//  ContentView.swift
//  Capstone
//
//  Created by Nicolle on 14/11/23.
//

import SwiftUI

struct ContentView: View {
    @State private var path = NavigationPath()
    @State private var isShowingUserName = false
    @State private var isShowingHome = false
    @State private var onboardingStatus: OnboardingStatus = .pendingWalkthrough
    
    var body: some View {
        switch onboardingStatus {
        case .pendingWalkthrough:
            OnboardingView(onStart: {
                isShowingUserName = true
            })
            .fullScreenCover(isPresented: $isShowingUserName) {
                userNameView
            }
        case .pendingName:
            userNameView
        case .pendingPreferences:
            NavigationStack {
                userDetailView
            }
        case .complete:
            HomeView()
        }
    }
    
    // MARK: Screens
    
    private var userDetailView: some View {
        UserDetailView(onStart: {
            isShowingHome = true
        })
        .fullScreenCover(isPresented: $isShowingHome) {
            HomeView()
        }
    }
    
    private var userNameView: some View {
        NavigationStack(path: $path) {
            UserNameView(onStart: {
                path.append(Destination.userDetail)
            })
            .navigationDestination(for: Destination.self) { destination in
                userDetailView
            }
        }
    }
}

enum Destination: Hashable {
    case userDetail
    case newRecipe
}

enum OnboardingStatus {
    case pendingWalkthrough
    case pendingName
    case pendingPreferences
    case complete
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
