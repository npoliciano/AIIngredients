//
//  BuildYourMealView.swift
//  AIIngredients
//
//  Created by Nicolle on 16/11/23.
//

import SwiftUI

struct BuildYourMealView: View {
  typealias Str = Strings.BuilYourMeal
  enum FocusedField {
    case meal
    case portion
  }

  @StateObject private var viewModel = BuildYourMealViewModel(
    generator: OpenAIListGenerator(
      httpClient: URLSessionHTTPClient()
    )
  )

  @Environment(\.verticalSizeClass)
  private var verticalSizeClass

  @Environment(\.dismiss)
  private var dismiss

  @FocusState var focusedField: FocusedField?

  private var headerHeight: CGFloat {
    isLandscape ? 100 : 300
  }

  private var isLandscape: Bool {
    verticalSizeClass != .regular
  }

  var body: some View {
    ScrollView {
      if !isLandscape {
        GeometryReader { geometry in
          Image("pan")
            .resizable()
            .scaledToFill()
            .frame(width: geometry.size.width, height: getHeightForHeaderImage(geometry))
            .clipped()
            .offset(x: 0, y: getOffsetForHeaderImage(geometry))
        }
        .frame(height: headerHeight)
      }

      VStack(alignment: .leading, spacing: 24) {
        VStack(alignment: .leading, spacing: 8) {
          Text(Str.buildYourMeal)
            .font(.largeTitle)
            .fontWeight(.bold)

          HeaderView(
            title: Str.title,
            headline: Str.headline
          )
        }

        Divider()

        VStack(spacing: 24) {
          LabeledTextField(
            label: Str.meal,
            placeholder: Str.placeholder,
            text: $viewModel.mealName
          )
          .keyboardType(.alphabet)
          .disableAutocorrection(true)
          .submitLabel(.next)
          .focused($focusedField, equals: .meal)

          VStack(alignment: .leading) {
            Text(Str.portionSize)
              .font(.footnote)
              .fontWeight(.medium)

            HStack {
              TextField(Str.portionField, text: $viewModel.portion)
                .keyboardType(.decimalPad)
                .focused($focusedField, equals: .portion)
                .accessibilityIdentifier("portionField")

              Picker(Str.unit, selection: $viewModel.selectedPortionType) {
                ForEach(viewModel.measurements, id: \.self) {
                  Text($0.rawValue)
                    .accessibilityIdentifier($0.rawValue)
                }
              }
              .accessibilityIdentifier("measurementPicker")
            }
          }

          VStack(alignment: .leading) {
            Text(Str.quantity)
              .font(.footnote)
              .fontWeight(.medium)
            Stepper("\(viewModel.quantity)", value: $viewModel.quantity, in: viewModel.quantityRange)
              .foregroundColor(.secondary)
          }
        }
        .toolbar {
          ToolbarItemGroup(placement: .keyboard) {
            Button {
              focusedField = .portion
            } label: {
              Image(systemName: "chevron.down")
            }
            .disabled(focusedField == .portion)
            .accessibilityIdentifier("GoDown")

            Button {
              focusedField = .meal
            } label: {
              Image(systemName: "chevron.up")
            }
            .disabled(focusedField == .meal)
            .accessibilityIdentifier("GoUp")

            Spacer()
            Button(Str.done) {
              focusedField = nil
            }
            .accessibilityIdentifier("Done")
          }
        }

        Spacer()

        PrimaryButton(
          title: Str.generate,
          isLoading: viewModel.isLoading
        ) {
          viewModel.onTap()
        }
      }
      .disabled(viewModel.isLoading)
      .padding(.horizontal)
      .padding(.vertical, 16)
    }
    .adaptsToKeyboard()
    .ignoresSafeArea(isLandscape ? .keyboard : .all)
    .sheet(item: $viewModel.meal) { meal in
      ShoppingListReviewView(
        viewModel: ShoppingListReviewViewModel(meal: meal)
      ) {
        dismiss()
      }
    }
    .alert(
      viewModel.alertError?.title ?? "",
      isPresented: $viewModel.isErrorPresented,
      presenting: viewModel.alertError,
      actions: { _ in
        Button(Str.gotIt) {
          viewModel.alertError = nil
        }
      }, message: { alertError in
        Text(alertError.message)
      }
    )
  }

  // MARK: Parallax Header Calculations

  private func getScrollOffset(_ geometry: GeometryProxy) -> CGFloat {
    geometry.frame(in: .global).minY
  }

  private func getOffsetForHeaderImage(_ geometry: GeometryProxy) -> CGFloat {
    let offset = getScrollOffset(geometry)

    // Image was pulled down
    if offset > 0 {
      return -offset
    }

    return 0
  }

  private func getHeightForHeaderImage(_ geometry: GeometryProxy) -> CGFloat {
    let offset = getScrollOffset(geometry)
    let imageHeight = geometry.size.height

    if offset > 0 {
      return imageHeight + offset
    }

    return imageHeight
  }
}

struct BuildYourMealView_Previews: PreviewProvider {
  static var previews: some View {
    BuildYourMealView()
  }
}
