//
//  GameResult.swift
//  MovieQuiz
//
//  Created by natalia.limonova on 06.03.2025.
//

import Foundation
struct GameResult: Codable {
    let correct: Int
    let total: Int
    let date: Date
    
    func isBetterThan(_ other: GameResult) -> Bool {
        return self.correct > other.correct
    }
}
