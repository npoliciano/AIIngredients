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
  @State private var confirmDelete = false

  @State var isEditing = false

  @Environment(\.dismiss)
  private var dismiss

  var body: some View {
    List {
      Section("Meal name") {
        EditableMealName(name: $viewModel.meal.name)
          .focused($focused)
          .listRowSeparator(.hidden)
      }

      Section("May contain") {
        CategoriesView(categories: viewModel.meal.categories)
          .listRowSeparator(.hidden)
      }

      Section("Ingredients") {
        ForEach($viewModel.meal.ingredients) { $ingredient in
          HStack {
            EditableSelectableIngredientView(
              isEditing: isEditing,
              ingredient: $ingredient
            )
            .padding(.vertical, 4)
            .listRowSeparator(.hidden)

            if isEditing {
              Button {
                withAnimation {
                  viewModel.delete(ingredient: ingredient)
                }
              } label: {
                Image(systemName: "minus.circle.fill")
                  .font(.title2)
                  .foregroundStyle(.red)
              }
              .padding(.leading, 24)
            }
          }
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
        if isEditing {
          viewModel.updateList()
        }

        if !viewModel.isErrorPresented {
          isEditing.toggle()
        }
      } label: {
        if isEditing {
          Text("Done")
        } else {
          Image(systemName: "pencil")
        }
      }
    }
    .alert("Confirm Deletion", isPresented: $isDeleting) {
      Button("Cancel", role: .cancel) { }
      Button("Delete", role: .destructive) {
        viewModel.delete()
        dismiss()
      }
    } message: {
      Text("Are you sure you want to delete \(viewModel.meal.name)? This action cannot be undone.")
    }
    .alert("Error", isPresented: $viewModel.isErrorPresented) {
      Button("Got it", role: .cancel) { }
    } message: {
      Text("No field can be left empty. Please enter a value or delete.")
    }
    .alert("Confirm Deletion", isPresented: $viewModel.isEmptyIngredientsErrorPresented) {
      Button("Cancel", role: .cancel) { }
      Button("Delete", role: .destructive) {
        viewModel.delete()
        dismiss()
      }
    } message: {
      Text("You can not delete all ingredients. Would you like to delete the meal?")
    }
  }
}

struct EditableMealName: View {
  @Binding var name: String
  @Environment(\.editMode)
  private var editMode

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
        categories: [.dairy, .proteins],
        ingredients: [
          Ingredient(name: "some ingredient", quantity: "some quantity")
        ]
      )))
    }
  }
}
