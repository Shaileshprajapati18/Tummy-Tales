//
//  MealsView.swift
//  Tummy Tales
//
//  Created by Rehan Shaik on 11/06/25.
//

import SwiftUI

struct MealInfoView: View {
    @Binding var isPresented: Bool
    @Environment(\.presentationMode) var presentationMode
    @State private var messageIndex = 0
    @State private var showSheet = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // Header
                HStack {
                    Text("What To Expect!")
                        .font(.title)
                        .bold()
                    Spacer()
                    HStack(spacing: 16) {
                        NavigationLink {
                            ResourcesView()
                        } label: {
                            Image("book")
                                .resizable()
                                .frame(width: 40, height: 40)
                        }
                        NavigationLink {
                            CalendarView()
                        } label: {
                            Image("calender")
                                .resizable()
                                .frame(width: 40, height: 40)
                        }
                    }
                }
                .padding()

                // Week Title
                Text("Week 15: May 6 – May 12")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.bottom, 10)

                // Meals and Diet Card
                VStack(alignment: .leading, spacing: 12) {
                    Text("Meals and Diet")
                        .font(.headline)

                    Text("Your focus this week/trimester will be rapid baby growth and increased bone density.")
                        .font(.subheadline)
                        .foregroundColor(.gray)

                    ZStack {
                        Image("meal")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 300)
                            .clipShape(Circle())

                        // Nutrient tags
                        Text("Iron")
                            .font(.caption)
                            .padding(6)
                            .background(Color.white.opacity(0.8))
                            .cornerRadius(8)
                            .offset(x: 70, y: -30)

                        Text("Calcium")
                            .font(.caption)
                            .padding(6)
                            .background(Color.white.opacity(0.8))
                            .cornerRadius(8)
                            .offset(x: 60, y: 30)

                        Text("Omega-3")
                            .font(.caption)
                            .padding(6)
                            .background(Color.white.opacity(0.8))
                            .cornerRadius(8)
                            .offset(x: -50, y: 60)
                    }

                    // Buttons
                    HStack {
                        Spacer()
                        VStack(spacing: 12) {
                            Button("Focus of the week") { }
                                .frame(maxWidth: 200)
                                .foregroundColor(.black)
                                .padding()
                                .background(Color.black.opacity(0.01))
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray.opacity(0.9), lineWidth: 1)
                                )

                            Button("Foods to Avoid") { }
                                .frame(maxWidth: 200)
                                .foregroundColor(.black)
                                .padding()
                                .background(Color.black.opacity(0.01))
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray.opacity(0.9), lineWidth: 1)
                                )
                        }
                        Spacer()
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .shadow(radius: 5)
                .padding()

                Spacer()

                Button("Close") {
                    isPresented = false
                }
                .padding(.bottom)
            }
        }
    }
}
#Preview {
    MealInfoView(isPresented: .constant(true))
}
