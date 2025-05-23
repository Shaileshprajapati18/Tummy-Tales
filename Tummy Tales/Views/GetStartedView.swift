//
//  GetStartedView.swift
//  Tummy Tales
//
//  Created by Rehan Shaik on 19/05/25.
//
import SwiftUI

struct GetStartedView: View {
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
                    
                    VStack(spacing: 16) {
                        Text("Welcome! Your Pregnancy journey \nstarts here, and we are happy to be part \nof it")
                            .multilineTextAlignment(.center)
                            .foregroundColor(.black)

                        NavigationLink {
                            // Destination view here
                        } label: {
                            Text("LET'S GET STARTED")
                                .underline()
                                .foregroundColor(.black)
                                .padding(.vertical, 8)
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .padding(32)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .padding(.horizontal)


                    Spacer()
                    
                    
                }
            }
        }
    }
}

#Preview {
    GetStartedView()
}
