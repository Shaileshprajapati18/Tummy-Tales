//
//  PregnancyStatusViewModel.swift
//  Tummy Tales
//
//  Created by Rehan Shaik on 16/05/25.
//

import Foundation

class PregnancyStatusViewModel: ObservableObject {
    @Published var currentlyPregnant: String = ""
    @Published var lastPeriodDate: String = ""
    @Published var dueDate: String = ""
    @Published var pregnancyLoss: String = ""
    @Published var firstChild: String = ""
}
