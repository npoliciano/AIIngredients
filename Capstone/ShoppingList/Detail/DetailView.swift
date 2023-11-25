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
    
    @State private var isDeleting = false
    
    @State var editMode = EditMode.inactive
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        List {
            Section("Meal name") {
                EditableMealName(name: $viewModel.meal.name)
                    .focused($focused)
                    .listRowSeparator(.hidden)
            }
            
            Section("Ingredients") {
                ForEach($viewModel.meal.ingredients) { $ingredient in
                    EditableSelectableIngredientView(ingredient: $ingredient)
                        .padding(.vertical, 4)
                        .listRowSeparator(.hidden)
                }
                .onDelete { indexSet in
                    viewModel.meal.ingredients.remove(atOffsets: indexSet)
                }
                .onMove { indexSet, index in
                    viewModel.meal.ingredients.move(fromOffsets: indexSet, toOffset: index)
                }
            }
            .padding(.bottom, 4)
            .listSectionSeparator(.hidden)
        }
        .listStyle(.plain)
        .navigationTitle("Meal Details")
        .toolbar {
            Button {
                isDeleting = true
            } label: {
                Image(systemName: "trash")
            }
            Button {
                if editMode == .active {
                    viewModel.updateList()
                }
                
                if !viewModel.isErrorPresented {
                    editMode = editMode == .active ? .inactive : .active
                }
            } label: {
                if editMode == .active {
                    Text("Done")
                } else {
                    Image(systemName: "pencil")
                }
            }
        }
        .environment(\.editMode, $editMode)
        .alert("Confirm Deletion", isPresented: $isDeleting) {
            Button("Cancel", role: .cancel, action: {})
            Button("Delete", role: .destructive) {
                viewModel.delete()
                dismiss()
            }
        } message: {
            Text("Are you sure you want to delete \(viewModel.meal.name)? This action cannot be undone.")
        }
        .alert("Error", isPresented: $viewModel.isErrorPresented) {
            Button("Got it", role: .cancel, action: {})
        } message: {
            Text("No field can be left empty. Please enter a value or delete.")
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
            DetailView(viewModel: DetailViewModel(meal: Meal(
                name: "some name",
                ingredients: [
                    Ingredient(name: "some ingredient", quantity: "some quantity")
                ]
            )))
        }
    }
}
