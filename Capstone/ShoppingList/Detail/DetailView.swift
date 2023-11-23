//
//  DetailView.swift
//  Capstone
//
//  Created by Nicolle on 22/11/23.
//

import SwiftUI

struct DetailView: View {
    @State var list: GeneratedList
    
    @FocusState var focusedItem: Item?
    @State private var isEditing = false
    
    var body: some View {
        List {
            Section(header: Text(list.name)) {
                ForEach($list.items) { $item in
                    ZStack(alignment: .topLeading) {
                        TextField("", text: $item.name)
                            .opacity(isEditing ? 1 : 0)
                            .focused($focusedItem, equals: item)
                            .animation(.easeInOut(duration: 0.5), value: isEditing)
                        
                        HStack {
                            Image(systemName: "square")
                            Text(item.name)
                        }
                        .opacity(isEditing ? 0 : 1)
                        .animation(.easeInOut(duration: 0.5), value: isEditing)
                    }
                    .padding(.vertical, 4)
                    .listRowSeparator(.hidden)
                }
            }
            .padding(.bottom, 4)
            .listSectionSeparator(.hidden)
        }
        .listStyle(.plain)
        .navigationTitle("Meal Details")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if isEditing {
                    Button("Done") {
                        withAnimation {
                            isEditing = false
                        }
                    }
                } else {
                    ImageButton(systemName: "pencil", action: {
                        withAnimation {
                            isEditing = true
                            focusedItem = list.items.first
                        }
                    })
                }
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DetailView(list: GeneratedList(name: "Alfredo chicken", items: [
                Item(name: "Chicken breast", quantity: "200 g"),
                Item(name: "Salt", quantity: "to taste"),
                Item(name: "Alfredo sauce", quantity: "200 ml")
            ]))
        }
    }
}
