//
//  BuildYourMealView.swift
//  Capstone
//
//  Created by Nicolle on 16/11/23.
//

import SwiftUI

final class ListGeneratorDummy: ListGenerator {
    func generate(
        from input: ListGeneratorInput,
        completion: @escaping (Result<GeneratedList, Error>) -> Void
    ) {
        let list = GeneratedList(name: "Greek Salad", items: [
            Item(name: "Lettuce", quantity: "as needed"),
            Item(name: "Cheese", quantity: "20g"),
            Item(name: "Tomato", quantity: "1 unit"),
            Item(name: "Ceasar Sauce", quantity: "10g"),
        ])
        
        completion(.success(list))
    }
}

struct BuildYourMealView: View {
    @StateObject
    private var viewModel = BuildYourMealViewModel(generator: ListGeneratorDummy())
    
    @Environment(\.verticalSizeClass)
    private var verticalSizeClass
    
    @Environment(\.dismiss)
    private var dismiss
    
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
                        .fontWeight(.heavy)
                    
                    Text("Get ready to cook with ease!")
                        .font(.title3)
                    Text("Type in the recipe you wish to prepare, specify the quantity and portion size")
                        .foregroundStyle(.secondary)
                }
                
                Divider()
                
                VStack(spacing: 24) {
                    VStack(alignment: .leading) {
                        Text("Meal")
                            .font(.footnote)
                            .fontWeight(.medium)
                        TextField("E.g. greek salad, fried rice...", text: $viewModel.meal)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Portion size")
                            .font(.footnote)
                            .fontWeight(.medium)
                        HStack {
                            TextField("E.g. 3 units, 0.5 kg, 70 ml...", text: $viewModel.portion)
                                .keyboardType(.decimalPad)
                            Picker("Unit", selection: $viewModel.selectedPortionType) {
                                ForEach(viewModel.measurements, id: \.self) {
                                    Text($0)
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
                
                Spacer()
                
                Button {
                    viewModel.onTap()
                } label: {
                    Group {
                        if viewModel.isLoading {
                            ProgressView()
                                .tint(.white)
                                .progressViewStyle(.circular)
                        } else {
                            Text("Generate")
                                .foregroundColor(Color.white)
                                .padding()
                                .cornerRadius(16)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.accentColor)
                    )
                }
                
            }
            .disabled(viewModel.isLoading)
            .padding(.horizontal)
            .padding(.vertical, 16)
        }
        .ignoresSafeArea(.all)
        .sheet(item: $viewModel.generatedList) { list in
            ShoppingListReviewView(onOk: {
                dismiss()
            })
        }
        .alert(
            viewModel.error?.title ?? "",
            isPresented: $viewModel.isErrorPresented,
            presenting: viewModel.error,
            actions: { error in
                Button("Got it") {
                    viewModel.error = nil
                }
            }, message: { error in
                Text(error.message)
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
