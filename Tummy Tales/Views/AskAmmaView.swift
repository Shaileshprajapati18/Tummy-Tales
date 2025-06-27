//
//  AskAmmaView.swift
//  Tummy Tales
//
//  Created by Rehan Shaik on 26/05/25.
//

import SwiftUI

struct AskAmmaView: View {
    @StateObject private var viewModel = ChatViewModel()

    var body: some View {
        VStack {
            // Top title
            Text("Ask Amma")
                .font(.system(size: 28, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.top)

            Divider()
                .background(Color.blue)
                .padding(.bottom)

            // Chat messages
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    ForEach(viewModel.messages, id: \.self) { msg in
                        Text(msg)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                    }
                }
            }

            Spacer()

            // Input area
            HStack(spacing: 12) {
                Button(action: {
                    viewModel.startVoiceRecognition()
                }) {
                    Image(systemName: "mic.fill")
                        .foregroundColor(.primary)
                }

                TextField("Ask me any question!", text: $viewModel.userInput)
                    .padding(12)
                    .background(Color(.systemGray6))
                    .cornerRadius(20)

                Button(action: {
                    Task {
                        await viewModel.sendMessage()
                    }
                }) {
                    Image(systemName: "paperplane")
                        .foregroundColor(.primary)
                }
            }
            .padding()
            .background(Color(.systemGray5))
            .cornerRadius(30)
            .padding(.horizontal)
        }
    }
}


#Preview {
    AskAmmaView()
}



