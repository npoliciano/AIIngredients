//
//  DetailView.swift
//  Capstone
//
//  Created by Nicolle on 22/11/23.
//

import SwiftUI

struct DetailView: View {
    @StateObject var viewModel: DetailViewModel
    @FocusState var focused: Bool
    
    @Environment(\.editMode) private var editMode
    
    var body: some View {
        List {
            Section("Meal name") {
                EditableMealName(name: $viewModel.list.name)
                    .focused($focused)
                    .listRowSeparator(.hidden)
            }
            
            Section("Ingredients") {
                ForEach($viewModel.list.items) { $item in
                    EditableSelectableIngredientView(item: $item)
                        .padding(.vertical, 4)
                        .listRowSeparator(.hidden)
                }
                .onDelete { indexSet in
                    viewModel.list.items.remove(atOffsets: indexSet)
                }
                .onMove { indexSet, index in
                    viewModel.list.items.move(fromOffsets: indexSet, toOffset: index)
                }
            }
            .padding(.bottom, 4)
            .listSectionSeparator(.hidden)
        }
        .listStyle(.plain)
        .navigationTitle("Meal Details")
        .toolbar {
            EditButton()
        }
        .onChange(of: editMode?.wrappedValue.isEditing) { isEditing in
            if isEditing == false {
                viewModel.updateList()
            }
        }
    }
}

struct EditableMealName: View {
    @Binding var name: String
    @Environment(\.editMode) private var editMode
    
    var body: some View {
        VStack {
            if editMode?.wrappedValue.isEditing == true {
                TextField("", text: $name)
            } else {
                Text(name)
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DetailView(viewModel: DetailViewModel(list: GeneratedList(name: "some name", items: [Item(name: "some item", quantity: "some quantity")])))
        }
    }
}
