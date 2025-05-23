//
//  SignUpView.swift
//  Tummy Tales
//
//  Created by Rehan Shaik on 14/05/25.
//

import SwiftUI

struct SignUpView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color("Lytpink")
                    .ignoresSafeArea()
                
                VStack {
                    Image("Tummy")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 60)
                        .padding(.top, 250)
                    
                    Spacer()
                    
                    
                    
                    BButton(button: "Sign up")
                        .fontWeight(.bold)
                        .padding(.bottom, 6)
                    
                    NavigationLink {
                        LoginView()
                    } label: {
                        Text("Create Account")
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, maxHeight: 60)
                            .background(Color.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black, lineWidth: 1)
                            )
                            .cornerRadius(10)
                            .padding(.horizontal)
                            .padding(.bottom, 20)
                        
                    }

                    
                   
                    
                    
                }
            }
        }
    }
}

#Preview {
    SignUpView()
}
