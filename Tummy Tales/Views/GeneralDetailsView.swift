//
//  GeneralDetailsView.swift
//  Tummy Tales
//
//  Created by Rehan Shaik on 15/05/25.
//

import SwiftUI

// MARK: - String Extension for Indexing
extension String {
    subscript(i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
}

struct GeneralDetailsView: View {
    // Persisted user data
    @AppStorage("firstName") private var storedFirstName = ""
    @AppStorage("lastName") private var storedLastName = ""
    @AppStorage("dob") private var storedDOB = ""
    @AppStorage("gender") private var storedGender = ""
    @AppStorage("nationality") private var storedNationality = ""
    @AppStorage("mobile") private var storedMobile = ""
    @AppStorage("email") private var storedEmail = ""

    // Form fields
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var dob = ""
    @State private var gender = ""
    @State private var nationality = ""
    @State private var mobile = ""
    @State private var email = ""

    @State private var showError = false
    @State private var errorMessage = ""
    @State private var goToNext = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Group {
                    customField(title: "First Name", text: $firstName)
                    customField(title: "Last Name", text: $lastName)
                    customField(title: "(MM/DD/YYYY)", text: $dob)
                        .keyboardType(.numberPad)
                        .onChange(of: dob, perform: formatDOB)
                    customField(title: "Gender", text: $gender)
                    customField(title: "Nationality", text: $nationality)
                    customField(title: "Mobile Number", text: $mobile)
                        .keyboardType(.numberPad)
                    customField(title: "Email", text: $email)
                        .keyboardType(.emailAddress)
                }

                if showError {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.footnote)
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
            .padding(.top, -100)
            .navigationDestination(isPresented: $goToNext) {
                GeneralAddView()
            }
            .navigationTitle("General Details*")
            .navigationBarBackButtonHidden(true)
        }
        .background(Color.white.ignoresSafeArea())
    }

    func customField(title: String, text: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            TextField(title, text: text)
                .padding(.vertical, 8)
            Divider()
        }
    }

    func formatDOB(_ input: String) {
        var digits = input.replacingOccurrences(of: "/", with: "")
        if digits.count > 8 { digits = String(digits.prefix(8)) }

        var result = ""
        for (index, char) in digits.enumerated() {
            if index == 2 || index == 4 {
                result.append("/")
            }
            result.append(char)
        }
        dob = result
    }

    func isValidForm() -> Bool {
        if firstName.isEmpty || lastName.isEmpty || gender.isEmpty || nationality.isEmpty || mobile.isEmpty || email.isEmpty || dob.isEmpty {
            errorMessage = "Please fill in all fields."
            return false
        }

        if !email.contains("@") || !email.contains(".") {
            errorMessage = "Please enter a valid email."
            return false
        }

        if dob.count != 10 || dob[2] != "/" || dob[5] != "/" {
            errorMessage = "DOB format must be MM/DD/YYYY."
            return false
        }

        if mobile.count < 10 || !CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: mobile)) {
            errorMessage = "Enter a valid mobile number."
            return false
        }

        return true
    }

    func saveToAppStorage() {
        storedFirstName = firstName
        storedLastName = lastName
        storedDOB = dob
        storedGender = gender
        storedNationality = nationality
        storedMobile = mobile
        storedEmail = email
    }
}

#Preview {
    GeneralDetailsView()
}

