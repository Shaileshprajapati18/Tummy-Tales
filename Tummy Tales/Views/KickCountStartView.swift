//
//  KickCountStartView.swift
//  Tummy Tales
//
//  Created by Rehan Shaik on 04/06/25.
//

import SwiftUI


struct KickCountStartView: View {
    var body: some View {
        NavigationStack {
            VStack {
                
                Divider()
                Spacer()
                
                // Navigation on Circle Tap
                NavigationLink(destination: KickCountRecordView()) {
                    Text("Start\nCounting!")
                        .font(.system(size: 24, weight: .bold))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                        .frame(width: 250, height: 280)
                        .background(Color(white: 0.85))
                        .clipShape(Circle())
                }
                
                Spacer()
                
                // Bottom Buttons
                HStack(spacing: 20) {
                    Spacer()
                    CapsuleButton(title: "View History") {
                        // View History Action
                    }
                    
                    CapsuleButton(title: "How it Works") {
                        // How it Works Action
                    }
                    Spacer()
                }
                .padding(.bottom, 60)
            }
            .overlay(
                // Bottom-left back button (does nothing here, optional)
                VStack {
                    Spacer()
                    HStack {
                        Button(action: {
                            // Optionally implement a custom action here
                        }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.black)
                                .padding(10)
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                                )
                        }
                        .padding([.leading, .bottom], 12)
                        Spacer()
                    }
                }
            )
            .navigationTitle("Kick Count")
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct KickCountRecordView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var sliderValue: Double = 0.2
    @State private var selectedOption: String = ""

    let options = [
        "Very Strong Kick",
        "Strong Kick",
        "Gentle Bump",
        "Light Flutter",
        "Barely Felt"
    ]

    var body: some View {
        VStack {
            Spacer()
            Button(action: {
                // Logic to record the kick
            }) {
                Text("Record\nthis Kick")
                    .font(.system(size: 24, weight: .bold))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
                    .frame(width: 280, height: 280)
                    .background(Color(white: 0.85))
                    .clipShape(Circle())
            }

            // Slider
            Slider(value: $sliderValue, in: 0...1)
                .accentColor(.blue)
                .padding()

            // Kick Strength Options
            VStack(alignment: .leading, spacing: 12) {
                ForEach(options, id: \.self) { option in
                    HStack {
                        Circle()
                            .strokeBorder(Color.black, lineWidth: 2)
                            .background(Circle().fill(selectedOption == option ? Color.black : Color.clear))
                            .frame(width: 20, height: 20)
                            .onTapGesture {
                                selectedOption = option
                            }
                        Text(option)
                            .font(.system(size: 16, weight: .medium))
                    }
                }
            }
            .padding(.leading)

            Spacer()

            // Bottom Buttons
            HStack(spacing: 20) {
                Spacer()
                CapsuleButton(title: "View History") {
                    // View History
                }

                CapsuleButton(title: "How it Works") {
                    // How it Works
                }
                Spacer()
            }
            .navigationTitle("Kick Count")
            .padding(.bottom, 50)
        }
        .overlay(
            // Bottom-left custom back button
            VStack {
                Spacer()
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                            .padding(10)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                            )
                    }
                    .padding([.leading, .bottom], 12)
                    Spacer()
                }
            }
        )
        .navigationBarBackButtonHidden(true)
    }
}

// Reusable Capsule Button
struct CapsuleButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .foregroundColor(.white)
                .padding()
                .frame(width: 150)
                .background(Color.gray)
                .clipShape(Capsule())
        }
    }
}


#Preview {
    KickCountStartView()
}
