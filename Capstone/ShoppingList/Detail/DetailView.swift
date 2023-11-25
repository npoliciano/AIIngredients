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
    
    @Environment(\.editMode) private var editMode
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
            EditButton()
        }
        .onChange(of: editMode?.wrappedValue.isEditing) { isEditing in
            if isEditing == false {
                viewModel.updateList()
            }
        }
        .alert("Confirm Deletion", isPresented: $isDeleting) {
            Button("Cancel", role: .cancel, action: {})
            Button("Delete", role: .destructive) {
                viewModel.delete()
                dismiss()
            }
        } message: {
            Text("Are you sure you want to delete \(viewModel.meal.name)? This action cannot be undone.")
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
            DetailView(viewModel: DetailViewModel(meal: Meal(name: "some name", ingredients: [Ingredient(name: "some ingredient", quantity: "some quantity")])))
        }
    }
}
