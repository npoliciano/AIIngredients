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
    
    @AppStorage("onboardingStatus") var onboardingStatus: OnboardingStatus?
    
    var body: some View {
        switch onboardingStatus {
        case .none:
            OnboardingView(onStart: {
                onboardingStatus = .pendingName
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
            onboardingStatus = .complete
            isShowingHome = true
        })
        .fullScreenCover(isPresented: $isShowingHome) {
            HomeView()
        }
    }
    
    private var userNameView: some View {
        NavigationStack(path: $path) {
            UserNameView(onStart: {
                onboardingStatus = .pendingPreferences
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

enum OnboardingStatus: String {
    case pendingName
    case pendingPreferences
    case complete
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
