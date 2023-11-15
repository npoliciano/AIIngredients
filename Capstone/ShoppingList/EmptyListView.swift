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
                .padding()
            
            Text("Your list is currently empty, but don't worry, start adding new items now to make the most of our app!")
                .padding(.horizontal, 30)
            
            Button {
                onTap()
            } label: {
                Text("Add")
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

struct EmptyListView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyListView(onTap: {})
    }
}
