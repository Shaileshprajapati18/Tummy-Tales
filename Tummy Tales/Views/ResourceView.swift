//
//  ResourcesView.swift
//  Tummy Tales
//
//  Created by Rehan Shaik on 20/05/25.
//

import SwiftUI

struct ResourcesView: View {
    @State private var openSection: String?

    var body: some View {
        VStack(spacing: 20) {
            // Header
            HStack {
                Text("Resources")
                    .font(.system(size: 38, weight: .bold))
                Spacer()
                Image("calender")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 36, height: 46)
                    .foregroundColor(.black)
            }
            .padding(.horizontal)
            .padding(.top)
            
            Divider()

            // Disclosure Sections
            VStack(spacing: 10) {
                ResourceDisclosure(title: "Chat with your Doctor", isOpen: openSection == "Doctor") {
                    openSection = openSection == "Doctor" ? nil : "Doctor"
                }

                ResourceDisclosure(title: "Connect with other Specialists", isOpen: openSection == "Specialists") {
                    openSection = openSection == "Specialists" ? nil : "Specialists"
                }

                ResourceDisclosure(title: "OB/GYN around the World", isOpen: openSection == "OBGYN") {
                    openSection = openSection == "OBGYN" ? nil : "OBGYN"
                }

                ResourceDisclosure(title: "Articles/Insight", isOpen: openSection == "Articles") {
                    openSection = openSection == "Articles" ? nil : "Articles"
                }
            }
            .padding(.horizontal)
            
            Spacer()
        }
    }
}

struct ResourceDisclosure: View {
    let title: String
    let isOpen: Bool
    let onTap: () -> Void

    var body: some View {
        DisclosureGroup(
            isExpanded: .constant(isOpen),
            content: {
                Text("Content goes here")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.vertical, 8)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
            },
            label: {
                Button(action: onTap) {
                    HStack {
                        Text(title)
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(.black)
                        Spacer()
                        Image(systemName: isOpen ? "chevron.up" : "chevron.down")
                            .foregroundColor(.black)
                    }
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(.gray), lineWidth: 1)
                    )
                }
            }
        )
        .accentColor(.black)
        .animation(.easeInOut, value: isOpen)
    }
}

#Preview {
    ResourcesView()
}

