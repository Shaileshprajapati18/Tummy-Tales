//
//  ProfileView.swift
//  Tummy Tales
//
//  Created by Rehan Shaik on 09/06/25.
//

import SwiftUI
import PhotosUI

struct ProfileView: View {
    @AppStorage("userEmail") private var storedEmail = ""
    @State private var pregnancyWeek: String = ""
    @State private var isCameraPresented = false
    @State private var selectedImage: UIImage?
    @State private var showSettings = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {

                // Camera and Pregnancy Week Card
                HStack(spacing: 0) {
                    Button(action: {
                        isCameraPresented = true
                    }) {
                        VStack {
                            if let selectedImage = selectedImage {
                                Image(uiImage: selectedImage)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            } else {
                                Image(systemName: "camera")
                                    .resizable()
                                    .foregroundColor(.black)
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 40, height: 40)
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: 120)
                        .background(Color.gray.opacity(0.2))
                    }

                    Divider().frame(width: 3)

                    VStack {
                        TextField("week of\npregnancy?", text: $pregnancyWeek)
                            .multilineTextAlignment(.center)
                            .frame(height: 100)
                    }
                    .frame(maxWidth: .infinity, maxHeight: 120)
                    .background(Color.gray.opacity(0.2))
                }
                .cornerRadius(10)
                .padding(.horizontal)

                HStack(spacing: 20) {
                    VStack(spacing: 6) {
                        Text("Priya B")
                            .fontWeight(.medium)
                        Text("@\(storedEmail.components(separatedBy: "@").first ?? "username")")
                            .foregroundColor(.gray)
                        Text("Joined on --/--/--")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(radius: 2)

                    VStack {
                        Text("Supporter (if added)")
                            .multilineTextAlignment(.center)
                            .padding()
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(radius: 2)
                }
                .padding(.horizontal)

                // Followers and Following
                HStack {
                    VStack {
                        Circle().frame(width: 5, height: 5)
                        Text("Followers")
                            .font(.caption)
                    }
                    .frame(maxWidth: .infinity)

                    VStack {
                        Circle().frame(width: 5, height: 5)
                        Text("Following")
                            .font(.caption)
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding(.top, 10)

                // Streak and Badges
                HStack(spacing: 20) {
                    Button("Streak") {}
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.black)
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(radius: 2)

                    Button("Badges") {}
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.black)
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(radius: 2)
                }
                .padding(.horizontal)

                Spacer()
            }
            .navigationTitle("Hi Mom!")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showSettings = true
                    }) {
                        Image(systemName: "gearshape")
                            .font(.title2)
                    }
                }
            }
            .sheet(isPresented: $isCameraPresented) {
                ImagePicker(sourceType: .camera, selectedImage: $selectedImage)
            }
            .navigationDestination(isPresented: $showSettings) {
                  SettingssView()
                    .foregroundColor(.black)
            }
            
            .padding(.top)
        }
    }
}

// MARK: - Image Picker
struct ImagePicker: UIViewControllerRepresentable {
    var sourceType: UIImagePickerController.SourceType = .camera
    @Binding var selectedImage: UIImage?

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            picker.dismiss(animated: true)
        }
    }

    func makeUIViewController(context: Context) -> some UIViewController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = sourceType
        return picker
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}

// MARK: - Settings View

// MARK: - Preview
#Preview {
    ProfileView()
}
