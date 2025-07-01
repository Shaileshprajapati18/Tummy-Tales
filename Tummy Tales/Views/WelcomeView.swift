//
//  WelcomeView.swift
//  Tummy Tales
//
//  Created by Rehan Shaik on 15/05/25.
//

import SwiftUI

struct WelcomeView: View {
    @State private var goToNext = false
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                ZStack {
                    Text("""
Let’s get you set up. Start by filling in some basic information about your pregnancy, healthcare preferences, and more. The more you share, the more personalized your experience will be. Don’t worry — you can always update your answers anytime in your profile settings.
""")
                    .font(.system(size: 21))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
                    .padding()
                }
                
                
                .frame(maxWidth: 300, maxHeight: .infinity)
                .padding()
                .background(Color("Lytpink"))
                .cornerRadius(20)
                .shadow(color: .black.opacity(0.4), radius: 4, x: 7, y: 4)
                .padding()
                
                Spacer()
                
                HStack {
                    Spacer()
                    NextButton(isActive: $goToNext)
                        .padding(.trailing)
                }
                .navigationDestination(isPresented: $goToNext) {
                    GeneralDetailsView()
                }
            }
            .navigationTitle("Welcome!")
            .background(Color.white.ignoresSafeArea())
            .navigationBarBackButtonHidden(true)
        }
    }
}


#Preview {
    WelcomeView()
}
