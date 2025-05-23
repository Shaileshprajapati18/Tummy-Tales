//
//  HealthCareView.swift
//  Tummy Tales
//
//  Created by Rehan Shaik on 16/05/25.
//

import SwiftUI

struct HealthCareView: View {
    @ObservedObject  var viewModel = PregnancyStatusViewModel()
    @State  var goToNext = false
    
    var body: some View {
        NavigationStack {
            Divider()
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    
                    FormTextField(title: "Do you have primary care physician?", text: $viewModel.currentlyPregnant, isPicker: true)
                    
                    FormTextField(title: "Do you have an OB/GN?", text: $viewModel.lastPeriodDate)
                    
                    FormTextField(title: "Do you have any insurance Provider?", text: $viewModel.dueDate)
                    
                    FormTextField(title: "Are you currently on any medicaions?", text: $viewModel.pregnancyLoss, isPicker: true)
                    
                    FormTextField(title: "Do you compose alocohol or smoke?", text: $viewModel.firstChild, isPicker: true)
                    
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
                AddSupportView()
            }
            .navigationTitle("Health & Healthcare")
            .navigationBarBackButtonHidden(true)
        }
    }
}


#Preview {
    HealthCareView()
}
