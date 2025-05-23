//
//  PregnancyStatusView.swift
//  Tummy Tales
//
//  Created by Rehan Shaik on 16/05/25.
//

import SwiftUI

struct PregnancyStatusView: View {
    @StateObject private var viewModel = PregnancyStatusViewModel()
    @State private var goToNext = false

    var body: some View {
        NavigationStack {
            Divider()
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    
                    FormTextField(title: "Are you currently pregnant or planning on becoming pregnant?", text: $viewModel.currentlyPregnant, isPicker: true)

                    FormTextField(title: "When was the first day of your last menstrual period?", text: $viewModel.lastPeriodDate)

                    FormTextField(title: "If established, what is your estimated due date?", text: $viewModel.dueDate)

                    FormTextField(title: "Have you ever experienced any pregnancy loss?", text: $viewModel.pregnancyLoss, isPicker: true)

                    FormTextField(title: "Would this be your first child?", text: $viewModel.firstChild, isPicker: true)
                    
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
                HealthCareView()
            }
            .navigationTitle("Pregnancy Status")
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    PregnancyStatusView()
}

