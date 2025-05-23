//
//  FactsandFlash.swift
//  Tummy Tales
//
//  Created by Rehan Shaik on 22/05/25.
//
import SwiftUI

struct FactsFlashView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var messageIndex = 0

    let messages = [
        "Start your day’s streak now!\n\nYour baby’s lungs are starting to develop this week!! Learn more >>>>",
        "True or False: At 15 weeks your baby might be hiccuping and \n practicing breathing, but you wont feel a thing",
        "True! These early hiccups and breathing motions are too tiny for you to notice!"
    ]

    var body: some View {
        VStack(spacing: 16) {
            // Top Header
            HStack {
                Text("What to Expect")
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
            .padding(.horizontal, 20)

            // Main Card Section
            VStack(alignment: .leading, spacing: 12) {
                // Title Row
                HStack {
                    Text("Facts & Flash")
                        .bold()
                    Spacer()
                    Image(systemName: "chevron.up")
                }

                // Category Tag
                Text("Facts - Your Baby & Body")
                    .font(.subheadline)
                    .padding(.horizontal)
                    .padding(.vertical, 6)
                    .background(Color.purple.opacity(0.3))
                    .cornerRadius(20)
                Spacer()
                // Week Info Row
                VStack {
                    HStack {
                        Image(systemName: "arrow.left.circle")
                            .font(.largeTitle)
                        Spacer()
                        VStack(spacing: 20) {
                            Text("Week 15: May 12")
                                .font(.title2)
                                .bold()
                            Text("111 DAY STREAK!!")
                                .font(.title3)
                        }
                        Spacer()
                        Image(systemName: "arrow.right.circle")
                            .font(.largeTitle)
                    }
                    
                    
                   
                      
                    
                    // Message Box (Tap to Change)
                    Button(action: {
                        messageIndex = (messageIndex + 1) % messages.count
                    }) {
                        Text(messages[messageIndex])
                            .bold()
                            .multilineTextAlignment(.leading)
                            .padding()
                            .frame(maxWidth: 330, minHeight: 290, alignment: .leading)
                            .background(Color.purple.opacity(0.4))
                            .cornerRadius(30)
                            .shadow(radius: 4)
                            .foregroundColor(.black)
                    }
                    
                }
                Spacer()
                    .frame(height: 130)
            }
          
            
            .frame(width: 340, height: 600)
            .padding()
            .background(Color.white)
            .cornerRadius(20)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray .opacity(0.3), lineWidth: 1)
                    .padding()
            )
            
           // Spacer()
               
        }
        Spacer()
        
        .background(Color(UIColor.systemGroupedBackground))
    }
}
#Preview {
    FactsFlashView()
}

