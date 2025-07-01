//
//  AskAmmaModel.swift
//  Tummy Tales
//
//  Created by Rehan Shaik on 26/05/25.
//

import Foundation

struct ChatRequest: Codable {
    let message: String
}

struct ChatResponse: Codable {
    let reply: String
}
