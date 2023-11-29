//
//  BuildYourMealViewModel.swift
//  Capstone
//
//  Created by Nicolle on 17/11/23.
//

import Foundation

protocol ListGenerator {
  func generate(
    from input: ListGeneratorInput,
    completion: @escaping (Result<Meal, Error>) -> Void
  )
}

final class BuildYourMealViewModel: ObservableObject {
  typealias Str = Strings.BuilYourMealViewModel
  struct AlertError: Equatable {
    let title: String
    let message: String
  }

  @Published var mealName = ""
  @Published var portion = ""
  @Published var selectedPortionType = Measurements.grams
  @Published var quantity = 1

  @Published var isLoading = false
  @Published var isErrorPresented = false
  @Published var meal: Meal?

  let quantityRange = 1 ... Int.max
  let measurements = Measurements.allCases

  var alertError: AlertError? {
    didSet {
      isErrorPresented = alertError != nil
    }
  }

  private let generator: ListGenerator

  init(generator: ListGenerator) {
    self.generator = generator
  }

  func onTap() {
    switch (mealName.isEmpty, portion.isEmpty) {
    case (true, true):
      alertError = AlertError(
        title: Str.emptyFieldsAlertTitle,
        message: Str.emptyMealAndPortionAlert
      )
    case (true, _):
      alertError = AlertError(
        title: Str.emptyFieldAlertTitle,
        message: Str.emptyMealAlert
      )
    case (_, true):
      alertError = AlertError(
        title: Str.emptyFieldAlertTitle,
        message: Str.emptyPortionAlert
      )
    default:
      let input = ListGeneratorInput(
        meal: mealName,
        portion: portion,
        measurement: selectedPortionType,
        quantity: quantity
      )

      generate(from: input)
    }
  }

  private func generate(from input: ListGeneratorInput) {
    isLoading = true
    meal = nil

    generator.generate(from: input) { result in
      switch result {
      case .success(let list):
        self.meal = list
      case .failure(let error):
        let message = (error as? AppError)?.message ?? Str.failureOnGenerateMessage

        self.alertError = AlertError(
          title: Str.alertTitle,
          message: message
        )
      }
      self.isLoading = false
    }
  }
}

struct ListGeneratorInput: Encodable, Equatable {
  let meal: String
  let portion: String
  let measurement: Measurements
  let quantity: Int
}

enum Measurements: String, CaseIterable, Encodable {
  case grams = "g"
  case kilograms = "kg"
  case pieces
  case units
  case milliliters = "ml"
  case litres
  case unespecified
}

extension AppError {
  typealias Str = Strings.AppError
  var message: String {
    switch self {
    case .server:
      return Str.serverError
    case .network:
      return Str.networkError
    }
  }
}
