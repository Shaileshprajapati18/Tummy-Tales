//
//  DailyTalesView.swift
//  Tummy Tales
//
//  Created by Rehan Shaik on 21/05/25.
//

import SwiftUI

struct DailyTalesView: View {
    @State private var selectedTab = "Trackers"
    let items = ["Exercise", "Meal Map", "Journal", "Medications", "Kick Count", "Mental Health Questionnaire"]

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

                // MARK: - Week Info
                Text("May 12 – 15 weeks and 6 days")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.top)
                Spacer().frame(width: 20)

                // MARK: - Tabs
                HStack(spacing: 0) {
                    tabButton(title: "Trackers")
                    tabButton(title: "Checklist")
                }
                .background(Color(.systemGray5))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal)

                // MARK: - List
                VStack(spacing: 12) {
                    ForEach(items, id: \.self) { item in
                        NavigationLink(destination: DetaillScreen(title: item)) {
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

                Spacer()

                // MARK: - Custom Back Button at Bottom
                HStack {
                    Button(action: {
                        // Dismiss current view
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                            .padding()
                            .background(Color(.systemGray5))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    Spacer().frame(width: 250)
                    .padding(.bottom)
                   
                }
                
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

// MARK: - Dummy Detail View
struct DetaillScreen: View {
    let title: String

    var body: some View {
        Text("\(title) Details")
            .navigationTitle(title)
    }
}

#Preview {
    DailyTalesView()
}
