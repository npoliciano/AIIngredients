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
        completion: @escaping (Result<GeneratedList, Error>) -> Void
    )
}

final class BuildYourMealViewModel: ObservableObject {
    struct Error: Swift.Error, Equatable {
        let title: String
        let message: String
    }
    
    @Published var meal = ""
    @Published var portion = ""
    @Published var selectedPortionType = Measurements.g
    @Published var quantity = 1
    
    @Published var isLoading = false
    @Published var isErrorPresented = false
    @Published var generatedList: GeneratedList?
    
    let quantityRange = 1 ... Int.max
    let measurements = Measurements.allCases
    
    var error: Error? {
        didSet {
            isErrorPresented = error != nil
        }
    }
    
    private let generator: ListGenerator
    
    init(generator: ListGenerator) {
        self.generator = generator
    }
    
    func onTap() {
        switch (meal.isEmpty, portion.isEmpty) {
        case (true, true):
            error = Error(
                title: "Required Fields Missing",
                message: "Please enter the \"Meal\" and \"Portion size\" details. Both fields are required to proceed."
            )
        case (true, _):
            error = Error(
                title: "Required Field Missing",
                message: "Please enter the \"Meal\" details. This field is required to proceed."
            )
        case (_, true):
            error = Error(
                title: "Required Field Missing",
                message: "Please enter the \"Portion size\" details. This field is required to proceed."
            )
        default:
            let input = ListGeneratorInput(
                meal: meal,
                portion: portion,
                measurement: selectedPortionType,
                quantity: quantity
            )
            
            generate(from: input)
        }
    }
    
    private func generate(from input: ListGeneratorInput) {
        isLoading = true
        generatedList = nil
        
        generator.generate(from: input) { result in
            switch result {
            case .success(let list):
                self.generatedList = list
            case .failure(let error):
                var message = "Something went wrong. Please, try again later."
                if let error = error as? String {
                    message = error
                }
                
                self.error = Error(
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
    case g
    case kg
    case pieces
    case units
    case ml
    case litres
    case unespecified
}
