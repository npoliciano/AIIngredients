//
//  BuildYourMealView.swift
//  Capstone
//
//  Created by Nicolle on 16/11/23.
//

import SwiftUI

struct BuildYourMealView: View {
    @State var meal = ""
    @State var portion = ""
    @State var quantity = 1
    @State var selectedPortionType = ""
    
    @State var isLoading = false
    @State var isShowingError = false
    
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
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
                    .background(Color(red: 246/255, green: 243/255, blue: 239/255))
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
                        TextField("E.g. greek salad, fried rice...", text: $meal)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Portion size")
                            .font(.footnote)
                            .fontWeight(.medium)
                        HStack {
                            TextField("E.g. 3 units, 0.5 kg, 70 ml ...", text: $portion)
                                .keyboardType(.decimalPad)
                            Picker("Unit", selection: $selectedPortionType) {
                                Text("g")
                                Text("kg")
                                Text("pieces")
                                Text("units")
                                Text("ml")
                                Text("litres")
                                Text("unespecified")
                            }
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Quantity per week")
                            .font(.footnote)
                            .fontWeight(.medium)
                        Stepper("\(quantity)", value: $quantity, in: 0 ... Int.max)
                            .foregroundColor(.secondary)
                    }
                }
                
                Spacer()
                
                Button {
                    
                } label: {
                    Group {
                        if isLoading {
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
            .padding(.horizontal)
            .padding(.vertical, 16)
        }
        .ignoresSafeArea(.all)
        .alert(isPresented: $isShowingError) {
            Alert(title: Text("Error"), message: Text("An error occurred."),
                  dismissButton: .default(Text("OK")))
        }
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
