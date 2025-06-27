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
    @Binding var isPresented: Bool
    @State private var showSheet = false
    
    let messages = [
        "Start your day’s streak now!\n\nYour baby’s lungs are starting to develop this week!! Learn more >>>>",
        "True or False: At 15 weeks your baby might be hiccuping and \n practicing breathing, but you wont feel a thing",
        "True! These early hiccups and breathing motions are too tiny for you to notice!"
    ]
    
    var body: some View {
        NavigationStack{
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
                    HStack(alignment: .center) {
                        Text("Facts & Flash")
                            .bold()
                        Spacer()
                        Image(systemName: "chevron.up")
                    }
                    
                    
                    Button(action: {
                        showSheet = true
                    }) {
                        Text("Facts - Your Baby & Body")
                            .foregroundColor(.black)
                            .font(.subheadline)
                            .padding(.horizontal)
                            .padding(.vertical, 6)
                            .background(Color.purple.opacity(0.3))
                            .cornerRadius(20)
                    }
                    .sheet(isPresented: $showSheet) {
                        SheetContentView()
                    }
                    
                    
                    
                    
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
                        
                        Spacer().frame(height: 30)
                        
                        HStack {
                            Button(action: {
                                isPresented = false // Dismiss the sheet
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
                
                
                
            }
        }
        Spacer()
        
        
        
            .background(Color(UIColor.systemGroupedBackground))
    }
}
//#Preview {
//    FactsFlashView()
//}







struct SheetContentView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    
                    SectionView(
                        title: "Your Body",
                        content: """
Around week 15 of pregnancy, your belly will start stretching to accommodate your growing baby, gradually rising above your pelvis. Every pregnancy is unique, so some moms may already have a visible bump, while others might still be barely showing, both of which are perfectly normal.

If you started pregnancy at a healthy weight, aim for about one pound of weight gain per week, which means roughly 300 extra calories per day. Focus on nutrient-rich foods whenever possible. However, if you experience sudden or rapid weight gain, be sure to notify your doctor, as this can be a sign of a serious condition called preeclampsia.
"""
                    )
                    
                    SectionView(
                        title: "Your Baby",
                        content: """
At week 15, your baby’s organs are rapidly developing and settling into their final positions. The ears are moving into place and starting to pick up sounds, while the intestines are shifting into their proper location. The lungs are also beginning to form, though they will continue to practice “breathing” amniotic fluid until birth.
"""
                    )
                    
                    SectionView(
                        title: "Pregnancy Symptoms",
                        content: "Increased sex drive is a common symptom."
                    )
                    
                }
                .padding()
            }
            .navigationTitle("Week 15 Overview")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct SectionView: View {
    var title: String
    var content: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.title2)
                .bold()
            Text(content)
                .font(.body)
                .foregroundColor(.gray)
        }
    }
}

