//
//  Model.swift
//  MiniGames
//
//  Created by Nurse Ntombi Masango on 2022/10/27.
//

import Foundation

// MARK: - Riddle
struct Riddle: Codable {
    let title, question, answer: String?
}
typealias Riddles = [Riddle]

struct Joke: Codable {
    let joke: String?
}
typealias Jokes = [Joke]
