//
//  Medications.swift
//  Tummy Tales
//
//  Created by Rehan Shaik on 03/06/25.
//

import SwiftUI

struct Medication: Identifiable {
    let id = UUID()
    var name: String
    var detail: String
    var time: String
    var isChecked: Bool = true
}

struct MedicationsView: View {
    @State private var medications: [Medication] = [
        Medication(name: "Prenatal Vitamin", detail: "Tablet: 1", time: "9:41 AM"),
        Medication(name: "Aspirin", detail: "Tablet: 1, 81 mg", time: "9:41 AM"),
        Medication(name: "Folic Acid", detail: "Tablet: 1", time: "9:41 AM"),
        Medication(name: "Vitamin D", detail: "Tablet: 1, 1000 IU", time: "9:41 AM")
    ]
    
    @State private var showAddSheet = false

    var body: some View {
        NavigationStack{
            Divider()
            VStack(alignment: .leading, spacing: 29) {
                ForEach($medications) { $med in
                    HStack {
                        Button(action: {
                            med.isChecked.toggle()
                        }) {
                            Image(systemName: med.isChecked ? "checkmark.square.fill" : "square")
                                .foregroundColor(.black)
                        }

                        VStack(alignment: .leading, spacing: 2) {
                            Text(med.name)
                                .font(.body)
                                .foregroundColor(.black)
                            Text(med.detail)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }

                        Spacer()
                        
                        Text(med.time)
                            .font(.subheadline)
                            .foregroundColor(.blue)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                    }
                }

                Button(action: {
                    showAddSheet = true
                }) {
                    HStack {
                        Image(systemName: "plus")
                        Text("Add Medication")
                    }
                    .foregroundColor(.black)
                    .padding(.top, 12)
                }

                Spacer()
                
                HStack {
                    Button(action: {
                        // Add back action if needed
                    }) {
                        Image(systemName: "chevron.left")
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).stroke(Color.black))
                    }
                }
                .padding(.top, 20)
            }
            .padding(.horizontal,30)
            .navigationBarTitle("Medications")
            .sheet(isPresented: $showAddSheet) {
                AddMedicationView { newMed in
                    medications.append(newMed)
                }
            }
        }
    }
}


#Preview {
    MedicationsView()
}




struct AddMedicationView: View {
    @Environment(\.dismiss) var dismiss
    @State private var name: String = ""
    @State private var detail: String = ""
    @State private var time: String = ""

    var onAdd: (Medication) -> Void

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Medication Details")) {
                    TextField("Title", text: $name)
                    TextField("Detail", text: $detail)
                    TextField("Time (e.g. 9:41 AM)", text: $time)
                }
                
                Button("Add") {
                    let newMed = Medication(name: name, detail: detail, time: time)
                    onAdd(newMed)
                    dismiss()
                }
                .disabled(name.isEmpty || time.isEmpty)
            }
            .navigationTitle("Add Medication")
            .navigationBarItems(trailing: Button("Cancel") {
                dismiss()
            })
        }
    }
}
