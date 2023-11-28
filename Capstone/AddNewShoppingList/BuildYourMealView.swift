//
//  BuildYourMealView.swift
//  Capstone
//
//  Created by Nicolle on 16/11/23.
//

import SwiftUI

struct BuildYourMealView: View {
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

  var headerHeight: CGFloat {
    verticalSizeClass == .regular ? 300 : 100
  }

  var body: some View {
    ScrollView {
      GeometryReader { geometry in
        Image("pan")
          .resizable()
          .scaledToFill()
          .frame(width: geometry.size.width, height: getHeightForHeaderImage(geometry))
          .clipped()
          .offset(x: 0, y: getOffsetForHeaderImage(geometry))
      }
      .frame(height: headerHeight)

      VStack(alignment: .leading, spacing: 24) {
        VStack(alignment: .leading, spacing: 8) {
          Text("Build Your Meal")
            .font(.largeTitle)
            .fontWeight(.bold)

          HeaderView(
            title: "Get ready to cook with ease!",
            headline: "Type in the recipe you wish to prepare, specify the quantity and portion size"
          )
        }

        Divider()

        VStack(spacing: 24) {
          LabeledTextField(
            label: "Meal",
            placeholder: "E.g. greek salad, fried rice...",
            text: $viewModel.mealName
          )
          .keyboardType(.alphabet)
          .disableAutocorrection(true)
          .submitLabel(.next)
          .focused($focusedField, equals: .meal)

          VStack(alignment: .leading) {
            Text("Portion size")
              .font(.footnote)
              .fontWeight(.medium)

            HStack {
              TextField("E.g. 3 units, 0.5 kg, 70 ml...", text: $viewModel.portion)
                .keyboardType(.decimalPad)
                .focused($focusedField, equals: .portion)

              Picker("Unit", selection: $viewModel.selectedPortionType) {
                ForEach(viewModel.measurements, id: \.self) {
                  Text($0.rawValue)
                }
              }
            }
          }

          VStack(alignment: .leading) {
            Text("Quantity per week")
              .font(.footnote)
              .fontWeight(.medium)
            Stepper("\(viewModel.quantity)", value: $viewModel.quantity, in: viewModel.quantityRange)
              .foregroundColor(.secondary)
          }
        }
        .toolbar {
          ToolbarItemGroup(placement: .keyboard) {
            if focusedField == .meal {
              Button {
                focusedField = .portion
              } label: {
                Image(systemName: "chevron.right")
              }
            } else {
              Button {
                focusedField = .meal
              } label: {
                Image(systemName: "chevron.left")
              }
            }

            Spacer()
            Button("Done") {
              focusedField = nil
            }
          }
        }

        Spacer()

        PrimaryButton(
          title: "Generate",
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
    .ignoresSafeArea(.all)
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
        Button("Got it") {
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
