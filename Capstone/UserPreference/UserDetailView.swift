//
//  UserDetailView.swift
//  Capstone
//
//  Created by Nicolle on 14/11/23.
//

import SwiftUI

struct UserDetailView: View {
    @State private var glutenFree: Bool = false
    @State private var lactoseFree: Bool = false
    @State private var sugarFree: Bool = false
    @State private var vegan: Bool = false
    @State private var vegetarian: Bool = false
    @State private var userName: String = ""
    let onStart: () -> Void
    
    var body: some View {
        
        VStack() {
            Text(userName)
                .font(.largeTitle)
                .padding()
            
            Form {
                Section("DietaryPreferences") {
                    Toggle("Gluten", isOn: $glutenFree)
                    
                    Toggle("Lactose", isOn: $lactoseFree)
                    
                    Toggle("Sugar", isOn: $sugarFree)
                    
                    Toggle("Vegan", isOn: $vegan)
                    
                    Toggle("Vegeterian", isOn: $vegetarian)
                }
            }
        }
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailView(onStart: {})
    }
}
