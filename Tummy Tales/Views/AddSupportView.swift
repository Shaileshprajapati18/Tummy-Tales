//
//  AddSupportView.swift
//  Tummy Tales
//
//  Created by Rehan Shaik on 19/05/25.
//

import SwiftUI

struct AddSupportView: View {
    @AppStorage("supporterName") private var storedSupporterName = ""
    @AppStorage("supporterRelation") private var storedSupporterRelation = ""
    @AppStorage("shareProgress") private var storedShareProgress = false
    @AppStorage("selectedPages") private var storedSelectedPages = ""

    @State private var supporterName = ""
    @State private var supporterRelation = ""
    @State private var shareProgress: Bool? = nil
    @State private var selectedPages: Set<String> = []

    @State private var showError = false
    @State private var errorMessage = ""
    @State private var goToNext = false

    let pages = ["Pregnancy Map", "Calendar", "Meal Map", "Exercise", "Medications", "Kick Count"]

    var body: some View {
        NavigationStack {
            Divider()
          
                VStack(alignment: .leading, spacing: 16) {
                    Button("Add Primary Supporter") {}
                        .padding()
                        .foregroundColor(.black)
                        .font(.title2)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .background(Color(UIColor.systemGray5))
                        .cornerRadius(10)
                    

                    Text("Please provide your supporter’s details:")
                        .font(.system(size: 17, weight: .bold))

                    TextField("", text: $supporterName)
                        .textFieldStyle(.roundedBorder)
                        

                    TextField("", text: $supporterRelation)
                        .textFieldStyle(.roundedBorder)

                    Text("Would you like to share your pregnancy progress with your supporter?")
                        .font(.subheadline)

                    HStack {
                        Button(action: { shareProgress = true }) {
                            Text("Yes")
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(shareProgress == true ? Color.gray.opacity(0.3) : Color.clear)
                                .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.black))
                        }

                        Button(action: { shareProgress = false }) {
                            Text("No")
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(shareProgress == false ? Color.gray.opacity(0.3) : Color.clear)
                                .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.black))
                        }
                    }

                    Text("Which pages would you like to grant permission for your supporter to track?")
                        .font(.subheadline)

                    Text("Select the pages you’d like them to access.")
                        .font(.caption)

                    ForEach(pages, id: \.self) { page in
                        HStack {
                            Button(action: {
                                if selectedPages.contains(page) {
                                    selectedPages.remove(page)
                                } else {
                                    selectedPages.insert(page)
                                }
                            }) {
                                Image(systemName: selectedPages.contains(page) ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(.black)
                            }

                            Text(page)
                        }
                    }

                    if showError {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.footnote)
                    }

                    HStack {
                        Spacer()
                        Button(action: {
                            if isValidForm() {
                                saveData()
                                goToNext = true
                            } else {
                                showError = true
                            }
                        }) {
                            Image(systemName: "chevron.right")
                                .foregroundColor(.black)
                                .padding()
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .shadow(radius: 2)
                        }
                        
                    }
                
               
            }
                .padding()
            .navigationTitle("Add Supporters")
            .navigationBarBackButtonHidden(true)
            .navigationDestination(isPresented: $goToNext) {
                GetStartedView()
            }
           
        }
        //.padding()
    }

    func isValidForm() -> Bool {
        if supporterName.isEmpty || supporterRelation.isEmpty {
            errorMessage = "Please enter supporter name and relation."
            return false
        }

        if shareProgress == nil {
            errorMessage = "Please select Yes or No for sharing progress."
            return false
        }

        if selectedPages.isEmpty {
            errorMessage = "Please select at least one page to share."
            return false
        }

        return true
    }

    func saveData() {
        storedSupporterName = supporterName
        storedSupporterRelation = supporterRelation
        storedShareProgress = shareProgress ?? false
        storedSelectedPages = selectedPages.joined(separator: ",")
    }
}

struct SupporterDetailsView: View {
    var body: some View {
        Text("Next screen after adding supporter.")
            .font(.title)
    }
}



#Preview {
    AddSupportView()
}
