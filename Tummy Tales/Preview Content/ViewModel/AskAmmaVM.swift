//
//  AskAmmaVM.swift
//  Tummy Tales
//
//  Created by Rehan Shaik on 26/05/25.
//

import Foundation
import Speech
import AVFoundation

class ChatViewModel: ObservableObject {
    @Published var userInput = ""
    @Published var messages: [String] = []

    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))
    private let audioEngine = AVAudioEngine()
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?

    // MARK: - Send Message to API
    func sendMessage() async {
        guard !userInput.isEmpty else { return }
        let messageToSend = userInput
        userInput = ""
        messages.append("You: \(messageToSend)")

        do {
            if let response = try await fetchAnswer(for: messageToSend) {
                messages.append("Amma: \(response)")
            } else {
                messages.append("Amma: Sorry, no response.")
            }
        } catch {
            messages.append("Error: \(error.localizedDescription)")
        }
    }

    // MARK: - API Call
    private func fetchAnswer(for message: String) async throws -> String? {
        guard let url = URL(string: "https://your-api-url.com/chat") else { return nil }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let requestBody = ChatRequest(message: message)
        request.httpBody = try JSONEncoder().encode(requestBody)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let (data, _) = try await URLSession.shared.data(for: request)
        let decoded = try JSONDecoder().decode(ChatResponse.self, from: data)
        return decoded.reply
    }

    // MARK: - Voice Recognition
    func startVoiceRecognition() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            guard authStatus == .authorized else {
                print("Speech recognition not authorized")
                return
            }

            DispatchQueue.main.async {
                self.startRecording()
            }
        }
    }

    private func startRecording() {
        recognitionTask?.cancel()
        recognitionTask = nil

        let audioSession = AVAudioSession.sharedInstance()
        try? audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
        try? audioSession.setActive(true, options: .notifyOthersOnDeactivation)

        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        guard let recognitionRequest = recognitionRequest else { return }

        let inputNode = audioEngine.inputNode
        recognitionRequest.shouldReportPartialResults = true

        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest) { result, error in
            if let result = result {
                DispatchQueue.main.async {
                    self.userInput = result.bestTranscription.formattedString
                }
            }

            if error != nil || (result?.isFinal ?? false) {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                self.recognitionRequest = nil
                self.recognitionTask = nil
            }
        }

        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
            self.recognitionRequest?.append(buffer)
        }

        audioEngine.prepare()
        try? audioEngine.start()
    }

    func stopVoiceRecognition() {
        audioEngine.stop()
        recognitionRequest?.endAudio()
        recognitionTask?.cancel()
    }
}
