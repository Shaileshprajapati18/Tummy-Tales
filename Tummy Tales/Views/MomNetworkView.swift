//
//  MomNetworkView.swift
//  Tummy Tales
//
//  Created by Rehan Shaik on 06/06/25.
//

import SwiftUI
import PhotosUI

struct MomNetworkView: View {
    @State private var threadText: String = ""
    @State private var isSubmitted: Bool = false
    @State private var selectedImage: PhotosPickerItem? = nil
    @State private var isDrawerOpen = false

    var body: some View {
        NavigationStack {
            ZStack {
                // Main Content
                VStack(alignment: .leading) {
                    // Drawer Button
                    HStack {
                        Button(action: {
                            withAnimation {
                                isDrawerOpen.toggle()
                            }
                        }) {
                            Image(systemName: "line.horizontal.3")
                                .font(.title)
                                .padding(.top)
                        }
                        Spacer()
                    }

                    // Thread Input
                    Text("Thread Name")
                        .font(.headline)
                        .padding(.top)

                    TextEditor(text: $threadText)
                        .frame(height: 80)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.3)))

                    // File Upload + Submit
                    HStack {
                        PhotosPicker(selection: $selectedImage, matching: .images) {
                            Image(systemName: "paperclip")
                                .foregroundColor(.black)
                                .font(.title2)
                                .padding()
                        }

                        Spacer()

                        Button(action: {
                            isSubmitted.toggle()
                        }) {
                            if isSubmitted {
                                Label("Submitted", systemImage: "checkmark")
                                    .foregroundColor(.black)
                                    .padding()
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(10)
                            } else {
                                Text("Submit")
                                    .foregroundColor(.black)
                                    .padding()
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(10)
                            }
                        }
                    }

                    // Response Boxes
                    ForEach(0..<3, id: \.self) { _ in
                        TextEditor(text: .constant("Response...."))
                            .frame(height: 80)
                            .padding(.vertical, 4)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.3)))
                    }

                    Spacer()
                }
                .padding()
                .navigationTitle("Mom Network")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Image(systemName: "plus.circle")
                            .font(.title2)
                    }
                }
                .disabled(isDrawerOpen) // Disable main view when drawer is open

                // Drawer Overlay
                if isDrawerOpen {
                    Color.black.opacity(0.3)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation {
                                isDrawerOpen = false
                            }
                        }

                    // Drawer View
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Profile")
                            Divider()
                            Text("Settings")
                            Divider()
                            Text("Logout")
                            Spacer()
                        }
                        .frame(width: 250)
                        .padding()
                        .background(Color.white)
                        .transition(.move(edge: .leading))

                        Spacer()
                    }
                }
            }
        }
    }
}

#Preview {
    MomNetworkView()
}
