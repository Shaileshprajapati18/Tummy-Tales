//
//  LifeStyleView.swift
//  Tummy Tales
//
//  Created by Rehan Shaik on 16/05/25.
//

import SwiftUI

struct LifeStyleView: View {
    @ObservedObject  var viewModel = PregnancyStatusViewModel()
    @State  var goToNext = false
    
    var body: some View {
        NavigationStack {
            Divider()
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    
                    FormTextField(title: "What is preferred language for medicaladivice and resources?", text: $viewModel.currentlyPregnant, isPicker: true)
                    
                    FormTextField(title: "Do you follow any specific dietary prefernces or rejections?", text: $viewModel.lastPeriodDate)
                    
                    FormTextField(title: "Do you currently exrciseor engage in physical activity during pregnancy?", text: $viewModel.dueDate)
                    
                    FormTextField(title: "What is your primary sourceof information during pregnancy?", text: $viewModel.pregnancyLoss, isPicker: true)
                    
                 
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
            .navigationTitle("Lifestyle & Preferences")
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    LifeStyleView()
}
