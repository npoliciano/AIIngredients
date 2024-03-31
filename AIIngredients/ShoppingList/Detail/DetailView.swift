//
//  DetailView.swift
//  AIIngredients
//
//  Created by Nicolle on 22/11/23.
//

import SwiftUI

struct DetailView: View {
  typealias Str = Strings.Detail
  @StateObject var viewModel: DetailViewModel
  @FocusState var focused: Bool

  @State private var isDeleting = false
  @State private var confirmDelete = false

  @State var isEditing = false

  @Environment(\.dismiss)
  private var dismiss

  var body: some View {
    List {
      Section(Str.mealName) {
        EditableMealName(name: $viewModel.meal.name)
          .focused($focused)
          .listRowSeparator(.hidden)
      }

      Section(Str.mayContain) {
        CategoriesView(categories: viewModel.meal.categories)
          .listRowSeparator(.hidden)
      }

      Section(Str.ingredients) {
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
    .navigationTitle(Str.mealDetails)
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
          Text(Str.done)
        } else {
          Image(systemName: "pencil")
        }
      }
    }
    .alert(Str.confirmDeletion, isPresented: $isDeleting) {
      Button(Str.cancel, role: .cancel) { }
      Button(Str.delete, role: .destructive) {
        viewModel.delete()
        dismiss()
      }
    } message: {
      Text(Str.mealDeletionAlert(viewModel.meal.name))
    }
    .alert(Str.error, isPresented: $viewModel.isErrorPresented) {
      Button(Str.gotIt, role: .cancel) { }
    } message: {
      Text(Str.emptyFieldAlert)
    }
    .alert(Str.confirmDeletion, isPresented: $viewModel.isEmptyIngredientsErrorPresented) {
      Button(Str.cancel, role: .cancel) { }
      Button(Str.delete, role: .destructive) {
        viewModel.delete()
        dismiss()
      }
    } message: {
      Text(Str.emptyIngredientsAlert)
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
