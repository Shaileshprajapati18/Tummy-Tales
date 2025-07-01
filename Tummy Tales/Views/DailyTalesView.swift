//
//  DailyTalesView.swift
//  Tummy Tales
//
//  Created by Rehan Shaik on 21/05/25.
//

import SwiftUI

struct DailyTalesView: View {
    @State private var selectedTab = "Trackers"

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                
                // MARK: - Header
                HStack {
                    Text("Daily Tales")
                        .font(.largeTitle)
                        .bold()
                    Spacer()
                    HStack(spacing: 16) {
                        NavigationLink(destination: ResourcesView()) {
                            Image("book")
                                .resizable()
                                .frame(width: 50, height: 50)
                        }
                        NavigationLink(destination: CalendarView()) {
                            Image("calender")
                                .resizable()
                                .frame(width: 50, height: 50)
                        }
                    }
                }
                .padding([.top, .horizontal])
                
                Divider()

                // MARK: - Week Info
                Text("May 12 – 15 weeks and 6 days")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.top)

                // MARK: - Tabs
                HStack(spacing: 0) {
                    tabButton(title: "Trackers")
                    tabButton(title: "Checklist")
                }
                .background(Color(.systemGray5))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal)

                // MARK: - Content Switch
                if selectedTab == "Trackers" {
                    TrackerListView()
                } else {
                    ChecklistView()
                }

                Spacer()

                // MARK: - Custom Back Button
                HStack {
                    Button(action: {
                        // Back action
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                            .padding()
                            .background(Color(.systemGray5))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    Spacer()
                }
                .padding()

            }
            .navigationBarHidden(true)
        }
    }

    // MARK: - Tab Button
    func tabButton(title: String) -> some View {
        Button(action: {
            selectedTab = title
        }) {
            Text(title)
                .fontWeight(.medium)
                .foregroundColor(selectedTab == title ? .black : .gray)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)
                .background(
                    selectedTab == title ? Color.white : Color.clear
                )
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}

// MARK: - Tracker View
struct TrackerListView: View {
    let items = ["Exercise", "Meal Map", "Journal", "Medications", "Kick Count", "Mental Health Questionnaire"]

    var body: some View {
        VStack(spacing: 12) {
            ForEach(items, id: \.self) { item in
                NavigationLink(destination: destinationView(for: item)) {
                    HStack(spacing: 12) {
                        Circle()
                            .fill(Color.black)
                            .frame(width: 32, height: 32)
                            .overlay(
                                Image(systemName: "star.fill")
                                    .foregroundColor(.white)
                                    .font(.system(size: 16))
                            )
                        Text(item)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                    )
                }
            }
        }
        .padding(.horizontal)
    }

    @ViewBuilder
    func destinationView(for item: String) -> some View {
        switch item {
        case "Exercise":
            JournalView()
        case "Meal Map":
            JournalView()
        case "Journal":
            JournalView()
        case "Medications":
            MedicationsView()
        case "Kick Count":
            KickCountStartView()
        case "Mental Health Questionnaire":
            JournalView()
        default:
            Text("Coming Soon")
        }
    }
}


// MARK: - Dummy Detail View
struct DetaillScreen: View {
    let title: String
    var body: some View {
        Text("\(title) Details")
            .navigationTitle(title)
    }
}

// MARK: - Dummy Placeholder Views
//struct ResourcesView: View {
//    var body: some View {
//        Text("Resources")
//    }
//}
//
//struct CalendarView: View {
//    var body: some View {
//        Text("Calendar")
//    }
//}

// MARK: - Your ChecklistView
struct ChecklistView: View {
    @State private var checklistItems: [(time: String, title: String)] = [
        ("9:00 AM", "Check Your Weight"),
        ("9:00 AM", "Write in Your Journal"),
        ("9:00 AM", "Register Medications"),
        ("9:00 AM", "Log Your Meals"),
        ("9:00 AM", "Take Mental Health Test"),
        ("3:00 PM", "Prenatal Doctor Appointment")
    ]
    @State private var showAddItem = false
    @State private var newTime = ""
    @State private var newTitle = ""

    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                ForEach(checklistItems.indices, id: \.self) { index in
                    HStack {
                        Text(checklistItems[index].time)
                            .foregroundColor(.blue)
                            .font(.system(size: 16, weight: .semibold))
                            .frame(width: 80, alignment: .leading)
                            .padding(8)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                        
                        Text(checklistItems[index].title)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                checklistItems[index].title == "Register Medications"
                                ? Color.brown.opacity(0.05)
                                : Color.white
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                            )
                    }
                    .padding(.horizontal)
                }

                // + Title Button
                HStack {
                    Button(action: {
                        showAddItem.toggle()
                    }) {
                        Image(systemName: "plus")
                            .foregroundColor(.blue)
                            .padding(8)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(6)
                    }
                    Text("Title")
                        .font(.title3)
                }
                .padding(.horizontal)
            }
            .padding(.top)
        }
        .sheet(isPresented: $showAddItem) {
            VStack(spacing: 20) {
                Text("Add New Item").font(.title2).bold()
                TextField("Time (e.g. 5:00 PM)", text: $newTime)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Title", text: $newTitle)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button("Add") {
                    if !newTime.isEmpty && !newTitle.isEmpty {
                        checklistItems.append((newTime, newTitle))
                        newTime = ""
                        newTitle = ""
                        showAddItem = false
                    }
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    DailyTalesView()
}
