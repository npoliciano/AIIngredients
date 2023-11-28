//
//  LabeledTextField.swift
//  Capstone
//
//  Created by Nicolle on 25/11/23.
//

import SwiftUI

struct LabeledTextField: View {
    let label: String
    let placeholder: String
    @Binding var text: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.footnote)
                .fontWeight(.medium)
            TextField(placeholder, text: $text)
        }
    }
}

struct LabeledTextField_Previews: PreviewProvider {
    static var previews: some View {
        LabeledTextField(
            label: "Meal",
            placeholder: "E.g. greek salad, fried rice...",
            text: .constant("")
        )
    }
}
