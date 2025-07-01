//
//  BButton.swift
//  Tummy Tales
//
//  Created by Rehan Shaik on 14/05/25.
//

import SwiftUI

struct BButton: View {
    var button: String
    var body: some View {
        
            Text(button)
                .foregroundColor(.white)
        
        .frame(maxWidth: .infinity, maxHeight: 60)
        .background(Color.black)
        .cornerRadius(10)
        .padding()

    }
}

#Preview {
    BButton(button: "dd")
}
