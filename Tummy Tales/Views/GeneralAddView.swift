//
//  GeneralAddView.swift
//  Tummy Tales
//
//  Created by Rehan Shaik on 19/05/25.
//

import SwiftUI

struct GeneralAddView: View {
    // MARK: - Persisted user data
    @AppStorage("Country") private var storedCountry = ""
    @AppStorage("State") private var storedState = ""
    @AppStorage("City") private var storedCity = ""
    @AppStorage("Zipcode") private var storedZipcode = ""

    // MARK: - Form fields
    @State private var country = ""
    @State private var state = ""
    @State private var city = ""
    @State private var zipcode = ""

    @State private var showError = false
    @State private var errorMessage = ""
    @State private var goToNext = false

    var body: some View {
        NavigationStack {
            Divider()
            Spacer()
            VStack(spacing: 16) {
                HStack {
                    Text("Address")
                    Spacer()
                }
                .padding(30)
                Group {
                    
                    customField(title: "Country", text: $country)
                    customField(title: "State", text: $state)
                    customField(title: "City", text: $city)
                    customField(title: "Zipcode", text: $zipcode)
                        .keyboardType(.numberPad)
                }

                if showError {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.footnote)
                        .padding(.top, 4)
                }
            }
            .padding()
            .background(Color("Lytpink"))
            .cornerRadius(20)
            .shadow(radius: 5, x: 10, y: 5)
            .padding()

            Spacer()

            HStack {
                Spacer()
                Button(action: {
                    if isValidForm() {
                        saveToAppStorage()
                        goToNext = true
                    } else {
                        showError = true
                    }
                }) {
                    Image(systemName: "chevron.right")
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(radius: 2)
                }
                .padding(.trailing)
            }
           // .padding(.top, -100)
            .navigationDestination(isPresented: $goToNext) {
                PregnancyStatusView()
            }
            .navigationTitle("General Details*")
        }
        .background(Color.white.ignoresSafeArea())
    }

    // MARK: - Custom Field
    func customField(title: String, text: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            TextField(title, text: text)
                .padding(.vertical, 8)
            Divider()
        }
    }

    // MARK: - Validation
    func isValidForm() -> Bool {
        if country.isEmpty || state.isEmpty || city.isEmpty || zipcode.isEmpty {
            errorMessage = "Please fill in all fields."
            return false
        }

        if zipcode.count < 5 || !CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: zipcode)) {
            errorMessage = "Enter a valid zipcode."
            return false
        }

        return true
    }

    // MARK: - Save to AppStorage
    func saveToAppStorage() {
        storedCountry = country
        storedState = state
        storedCity = city
        storedZipcode = zipcode
    }
}

#Preview {
    GeneralAddView()
}
