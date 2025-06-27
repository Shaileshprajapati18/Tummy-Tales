//
//  PregnancyTrackerView.swift
//  Tummy Tales
//
//  Created by Rehan Shaik on 20/05/25.
//

import SwiftUI

struct PregnancyTrackerView: View {
    @AppStorage("loginDate") private var loginDate: String = ""
    @State private var currentWeek: Int = 1
    @State private var babySizeDescription: String = "an apple"
    @State private var babyImageName: String = "apple"
    
    // Baby size data by week (simplified example)
    private let babySizes: [Int: (image: String, description: String)] = [
        1: ("apple", "an apple"),
        2: ("blueberry", "a blueberry"),
        3: ("raspberry", "a raspberry"),
        // Add more weeks as needed
    ]

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // Header
                HStack {
                    Text("Hi Mom!")
                        .font(.largeTitle)
                        .bold()
                    Spacer()
                    HStack(spacing: 16) {
                        NavigationLink {
                            ResourcesView()
                        } label: {
                            Image("book")
                                .resizable()
                                .frame(width: 50, height: 50)
                        }

                        NavigationLink {
                            CalendarView()
                        } label: {
                            Image("calender")
                                .resizable()
                                .frame(width: 50, height: 50)
                        }
                    }
                }
                .padding([.top, .horizontal])
                
                Divider()
                
                // Week Display
                Text("You are in week \(currentWeek) of your pregnancy")
                    .font(.title3)
                    .bold()
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                // Baby Image
                Image("apple")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .padding(.top, 20)
                
                // Baby Size Text
                Text("Your baby is the size of \(babySizeDescription)!")
                    .font(.headline)
                    .padding(.top, 10)
                
                Spacer()
                
                // Buttons
                VStack(spacing: 16) {
                    NavigationLink {
                        WeekDetailView()
                            .navigationBarBackButtonHidden(true)
                            .toolbar {
                                ToolbarItem(placement: .navigationBarLeading) {
                                    BackButton()
                                }
                            }
                    } label: {
                        ImageBut()
                    }
                    
                    NavigationLink {
                        DailyTalesView()
                            .navigationBarBackButtonHidden(true)
                            
                            
                    } label: {
                        ImageButt()
                    }
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .onAppear {
                saveLoginDateIfNeeded()
                updateWeekAndBabySize()
            }
            .padding(.bottom, 10)
            .background(Color.white)
            .tint(.black) // Set global tint color
        }
    }

    // MARK: - Helper Functions
    
    private func saveLoginDateIfNeeded() {
        if loginDate.isEmpty {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            loginDate = formatter.string(from: Date())
        }
    }
    
    private func updateWeekAndBabySize() {
        currentWeek = calculateCurrentWeek()
        let babySize = babySizes[currentWeek] ?? (image: "apple", description: "an apple")
        babyImageName = babySize.image
        babySizeDescription = babySize.description
    }
    
    private func calculateCurrentWeek() -> Int {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        guard let startDate = formatter.date(from: loginDate) else { return 1 }
        let daysPassed = Calendar.current.dateComponents([.day], from: startDate, to: Date()).day ?? 0
        return min(40, max(1, (daysPassed / 7) + 1)) // Cap at 40 weeks
    }
}

// MARK: - Custom Back Button Component
struct BackButton: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Button(action: {
            dismiss()
        }) {
            HStack {
                Image(systemName: "chevron.left")
                    .foregroundColor(.black)
//                Text("Back")
//                    .foregroundColor(.black)
            }
        }
    }
}



// MARK: - Main Tab View
struct MainTabView: View {
    var body: some View {
        TabView {
            PregnancyTrackerView()
                .tabItem {
                    Label("Track", systemImage: "map")
                }

            AskAmmaView()
                .tabItem {
                    Label("Ask Amma", systemImage: "message")
                }

            MomNetworkView()
                .tabItem {
                    Label("Mom Network", systemImage: "person.3")
                }

            Text("Profile Screen")
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle")
                }
        }
        .tint(.black) // Set tab bar tint color
    }
}

// MARK: - Preview
#Preview {
    MainTabView()
}
