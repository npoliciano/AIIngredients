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
        title: "Required Fields Missing",
        message: "Please enter the \"Meal\" and \"Portion size\" details. Both fields are required to proceed."
      )
    case (true, _):
      alertError = AlertError(
        title: "Required Field Missing",
        message: "Please enter the \"Meal\" details. This field is required to proceed."
      )
    case (_, true):
      alertError = AlertError(
        title: "Required Field Missing",
        message: "Please enter the \"Portion size\" details. This field is required to proceed."
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
        let message = (error as? AppError)?.message ?? "Something went wrong. Please, try again later."

        self.alertError = AlertError(
          title: "Sorry!",
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
  var message: String {
    switch self {
    case .server:
      // swiftlint:disable:next line_length
      return "We encountered an issue generating the ingredients list. Please check the details of your request and try again"
    case .network:
      return "It seems like we're having trouble connecting. Please check your internet connection and try again"
    }
  }
}
