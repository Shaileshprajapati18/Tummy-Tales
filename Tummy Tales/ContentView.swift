//
//  ContentView.swift
//  Tummy Tales
//
//  Created by Rehan Shaik on 14/05/25.
//

import SwiftUI

struct NextButton: View {
    @Binding var isActive: Bool
    var imageName: String = "chevron.right"

    var body: some View {
        Button(action: {
            isActive = true
        }) {
            Image(systemName: imageName)
                .foregroundColor(.black)
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .shadow(radius: 2)
        }
    }
}



//@State private var navigate = false
//NextButton(isActive: $navigate)
//.navigationDestination(isPresented: $navigate) {
//    SomeOtherView()
//}
