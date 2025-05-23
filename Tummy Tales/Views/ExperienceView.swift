//
//  ExperienceView.swift
//  Tummy Tales
//
//  Created by Rehan Shaik on 19/05/25.
//

import SwiftUI

struct ExperienceView: View {
    @ObservedObject  var viewModel = PregnancyStatusViewModel()
    @State  var goToNext = false
    
    var body: some View {
        NavigationStack {
            Divider()
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    
                    FormTextField(title: "What do you expect most from this platform?", text: $viewModel.currentlyPregnant, isPicker: true)
                    
                    FormTextField(title: "Are there any specific challenges or concerns you  would like supporr with ?", text: $viewModel.lastPeriodDate)
                    
                    FormTextField(title: "Would you like to receive personalised resorces, tips or reminders based onn your profile?", text: $viewModel.dueDate)
                    
                    FormTextField(title: "Add Additional feedback or comments for us?", text: $viewModel.pregnancyLoss, isPicker: true)
                    
                 
                    Spacer()
                    
                    HStack {
                        Spacer()
                        NextButton(isActive: $goToNext)
                            .padding(.trailing)
                    }
                }
                .padding()
            }
            .navigationDestination(isPresented: $goToNext) {
                //PregnancyStatusView()
            }
            .navigationTitle("Experience & Expectations")
            .navigationBarBackButtonHidden(true)
        }
    }
}
#Preview {
    ExperienceView()
}
