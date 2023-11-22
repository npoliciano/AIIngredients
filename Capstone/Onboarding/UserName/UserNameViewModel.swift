//
//  UserNameViewModel.swift
//  Capstone
//
//  Created by Nicolle on 21/11/23.
//

import Foundation

final class UserNameViewModel: ObservableObject {
    @Published var userName: String = ""
    
    func onTap() {
        if !userName.isEmpty {
            UserDefaults.standard.userName = userName
        }
    }
}
