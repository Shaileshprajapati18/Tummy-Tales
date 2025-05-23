//
//  FormTextField.swift
//  Tummy Tales
//
//  Created by Rehan Shaik on 16/05/25.
//

import Foundation

import SwiftUI

struct FormTextField: View {
    var title: String
    @Binding var text: String
    var isPicker: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .fontWeight(.semibold)
                .foregroundColor(.black)

            ZStack {
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                    .frame(height: 40)

                HStack {
                    TextField("", text: $text)
                        .padding(.horizontal, 8)
                        .disabled(isPicker)
                    
                    if isPicker {
                        Image(systemName: "chevron.down")
                            .padding(.trailing, 8)
                    }
                }
            }
        }
    }
}
