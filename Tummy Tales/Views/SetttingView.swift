//
//  SetttingView.swift
//  Tummy Tales
//
//  Created by Rehan Shaik on 09/06/25.
//
import SwiftUI

struct SettingssView: View {
    @AppStorage("isLoggedIn") private var isLoggedIn = true // Use this to toggle login state

    var body: some View {
        VStack(spacing: 24) {
            // Title
            Text("Settings")
                .font(.system(size: 28, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)

            // Settings options
            VStack(spacing: 0) {
                ForEach(SettingsOption.allCases, id: \.self) { option in
                    NavigationLink(destination: Text(option.title + " Screen")) {
                        HStack {
                            Text(option.title)
                                .foregroundColor(.black)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }
                        .padding(.vertical, 16)
                        .padding(.horizontal)
                        Divider()
                    }
                }
            }
            .background(Color.white)
            .cornerRadius(10)
            .padding(.horizontal)

            // Uploaded Reports button
            Button(action: {
                // Add navigation or action here
            }) {
                Text("Your Uploaded Reports, All in One Place")
                    .font(.body)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                    )
            }
            .padding(.horizontal)

            Spacer()

            // Logout button
            Button(action: {
                isLoggedIn = false // Simulate logout
            }) {
                HStack {
                    Image(systemName: "arrowshape.turn.up.left")
                    Text("Logout")
                }
                .foregroundColor(.black)
                .frame(width: 160, height: 44)
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color.gray.opacity(0.6), lineWidth: 1)
                )
            }
            .padding(.bottom, 32)
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
    }
}

enum SettingsOption: String, CaseIterable {
    case general = "General Details"
    case pregnancy = "Pregnancy Status"
    case healthcare = "Health & Healthcare"
    case lifestyle = "Lifestyle & Preferences"
    case experience = "Experience and Expectations"

    var title: String { self.rawValue }
}

#Preview {
    NavigationStack {
        SettingssView()
    }
}
