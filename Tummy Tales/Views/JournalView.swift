//
//  JournalView.swift
//  Tummy Tales
//
//  Created by Rehan Shaik on 03/06/25.
//

import SwiftUI


struct JournalView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                
                // Write Thoughts
                JournalOptionView(title: "Write Your Thoughts:", icon: "square.and.pencil")

                // Video Your Day
                JournalOptionView(title: "Video Your Day:", icon: "video")

                // Record Your Thoughts
                JournalOptionView(title: "Record Your Thoughts:", icon: "mic")

                // Pictures Log
                JournalOptionView(title: "Pictures Log:", icon: "camera")

                Spacer()

                // Bottom Navigation
                HStack {
                    Button(action: {
                        // Back action
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                            .padding()
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }

                    Spacer()

                    Text("Access Your  Full 9-month  Diary")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.black)

                    Spacer()
                }
                .padding(.horizontal)
            }
            .padding()
            .navigationTitle("Journal")
        }
    }
}

struct JournalOptionView: View {
    let title: String
    let icon: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
                .foregroundColor(.gray)

            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .foregroundColor(.black)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.gray.opacity(0.15))
        .cornerRadius(12)
    }
}


#Preview {
    JournalView()
}
