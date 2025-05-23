//
//  WhatExpectView.swift
//  Tummy Tales
//
//  Created by Rehan Shaik on 21/05/25.
//

import SwiftUI

struct WeekDetailView: View {
    @State private var expandedSection: String? = nil
    let sections = ["Facts & Flash", "Tips of the Week", "Essential Testing", "Set Up for the Baby", "Meals and Diet"]
   

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // MARK: - Header
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
                                .frame(width: 40, height:40)
                        }

                    }
                }
                .padding()
                Divider()

                // MARK: - Week Info
                Text(getCurrentWeekRange())
                    .font(.headline)
                    .padding(.vertical)

                // MARK: - Accordion Sections
                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(sections, id: \.self) { section in
                            AccordionItem(
                                title: section,
                                isExpanded: expandedSection == section
                            ) {
                                NavigationLink(destination: DetailScreen(title: section)) {
                                    Text("Tap to explore \(section)")
                                        .font(.subheadline)
                                        .padding()
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .background(Color(.systemGray6))
                                        .cornerRadius(8)
                                }
                            }
                            .onTapGesture {
                                withAnimation {
                                    expandedSection = (expandedSection == section) ? nil : section
                                }
                            }
                        }
                    }
                    .padding()
                }

                Spacer()
            }
            .navigationBarHidden(true)
        }
    }

    // MARK: - Real-Time Week Text
    func getCurrentWeekRange() -> String {
        let calendar = Calendar.current
        let today = Date()
        let weekday = calendar.component(.weekday, from: today)
        let startOfWeek = calendar.date(byAdding: .day, value: -(weekday - 1), to: today)!
        let endOfWeek = calendar.date(byAdding: .day, value: 7 - weekday, to: today)!

        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"

        let range = "\(formatter.string(from: startOfWeek)) – \(formatter.string(from: endOfWeek))"
        let weekNumber = calendar.component(.weekOfYear, from: today)
        return "Week \(weekNumber): \(range)"
    }
}

// MARK: - Accordion Item
struct AccordionItem<Content: View>: View {
    let title: String
    let isExpanded: Bool
    let content: () -> Content

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(title)
                    .fontWeight(.semibold)
                Spacer()
                Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
            }
            .padding()
            .background(Color(.systemGray5))
            .cornerRadius(10)

            if isExpanded {
                content()
                    .transition(.opacity)
                    .padding(.horizontal)
            }
        }
        .animation(.easeInOut, value: isExpanded)
    }
}


// MARK: - Dummy Detail View
struct DetailScreen: View {
    let title: String

    var body: some View {
        Text("\(title) Details")
            .navigationTitle(title)
    }
}

// MARK: - Entry Point
struct ContentView: View {
    var body: some View {
        WeekDetailView()
    }
}

#Preview {
    ContentView()
}
