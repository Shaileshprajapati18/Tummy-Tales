//
//  LoginView.swift
//  Tummy Tales
//
//  Created by Rehan Shaik on 14/05/25.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var showError = false
    @State private var errorMessage = ""
    
    @State private var isPasswordVisible = false
    @State private var isConfirmPasswordVisible = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 9) {
                    
                    HStack {
                        Spacer()
                        Image(systemName: "sparkles")
                            .font(.title)
                            .padding(.horizontal)
                            .padding(.top)
                    }
                    
                    Text("Sign up")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                    
                    // Email
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Email")
                            .fontWeight(.medium)
                        TextField("example@gmail.com", text: $email)
                            .autocapitalization(.none)
                            .keyboardType(.emailAddress)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray.opacity(0.4)))
                    }
                    .padding(.horizontal)
                    
                    // Password
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Create a password")
                            .fontWeight(.medium)
                        HStack {
                            if isPasswordVisible {
                                TextField("must be 8 characters", text: $password)
                            } else {
                                SecureField("must be 8 characters", text: $password)
                            }
                            Button(action: {
                                isPasswordVisible.toggle()
                            }) {
                                Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray.opacity(0.4)))
                    }
                    .padding(.horizontal)
                    
                    // Confirm Password
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Confirm password")
                            .fontWeight(.medium)
                        HStack {
                            if isConfirmPasswordVisible {
                                TextField("repeat password", text: $confirmPassword)
                            } else {
                                SecureField("repeat password", text: $confirmPassword)
                            }
                            Button(action: {
                                isConfirmPasswordVisible.toggle()
                            }) {
                                Image(systemName: isConfirmPasswordVisible ? "eye.slash" : "eye")
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray.opacity(0.4)))
                    }
                    .padding(.horizontal)
                    
                    // Error Message
                    if showError {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.footnote)
                            .padding(.horizontal)
                    }
                    
                    // Submit Button
                    Button(action: {
                        if isValidForm() {
                            showError = false
                            // Navigate to next screen if needed
                        } else {
                            showError = true
                        }
                    }) {
                        NavigationLink {
                            WelcomeView()
                        } label: {
                            BButton(button: "Login")
                                .frame(maxWidth: .infinity, minHeight: 50)
                                .padding(.horizontal)
                                .padding(.top, 20)

                        }
                        

                    }

                    // OR line
                    HStack {
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.gray.opacity(0.3))
                        Text("Or Register with")
                            .foregroundColor(.gray)
                            .font(.subheadline)
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.gray.opacity(0.3))
                    }
                    .padding(.horizontal)
                    .padding(.top, 20)

                    // Social buttons
                    HStack(spacing: 50) {
                        ForEach(["facebook", "google", "apple"], id: \.self) { icon in
                            Button(action: {}) {
                                Image(icon)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 62, height: 24)
                                    .padding()
                                    .background(RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray.opacity(0.3)))
                            }
                        }
                    }
                    .padding()
                    .padding(.top, 18)
                    
                    Spacer(minLength: 30)
                    
                    // Bottom text
                    HStack {
                        Spacer()
                        Text("Already have an account?")
                            .foregroundColor(.gray)
                        Button("Log in") {}
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        Spacer()
                    }
                 
                    .padding(.bottom, 20)
                }
                .padding(.top, 20)
            }
            .scrollDismissesKeyboard(.interactively) // iOS 16+
            .navigationBarBackButtonHidden(true)
            .hideKeyboardOnTap()
        }
    }
    
    // MARK: - Validation
    func isValidForm() -> Bool {
        if email.isEmpty || !email.contains("@") || !email.contains(".") {
            errorMessage = "Please enter a valid email."
            return false
        }
        
        if password.count < 8 {
            errorMessage = "Password must be at least 8 characters."
            return false
        }
        
        if password != confirmPassword {
            errorMessage = "Passwords do not match."
            return false
        }
        
        return true
    }
}

// MARK: - Hide Keyboard Extension
extension View {
    func hideKeyboardOnTap() -> some View {
        self.onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
}

#Preview {
    LoginView()
}
