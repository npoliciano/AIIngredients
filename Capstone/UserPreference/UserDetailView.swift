//
//  UserDetailView.swift
//  Capstone
//
//  Created by Nicolle on 14/11/23.
//

import SwiftUI

struct UserDetailView: View {
    @State var glutenPreference = false
    @State var lactosePreference = false
    @State var sugarPreference = false
    @State var veggiePreference = false
    @State var name: String = ""
    let onStart: () -> Void
    
    var body: some View {
        VStack {
            Form {
                Section("Name") {
                    TextField("Name", text: $name)
                }
                
                Section("Restrictions") {
                    Toggle("Gluten", isOn: $glutenPreference)
                    
                    Toggle("Lactose", isOn: $lactosePreference)
                    
                    Toggle("Sugar", isOn: $sugarPreference)
                    
                    Toggle("Veggie", isOn: $veggiePreference)
                }
            }
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        onStart()
                    } label: {
                        Text("Next")
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
            .navigationBarTitle("Preferences")
        }
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailView(onStart: {})
    }
}
