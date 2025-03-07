//
//  StatisticServiceImplementation.swift
//  MovieQuiz
//
//  Created by natalia.limonova on 06.03.2025.
//

import Foundation
import Foundation

final class StatisticServiceImplementation: StatisticServiceProtocol {
    private let userDefaults = UserDefaults.standard
    
    private enum Keys {
        static let gamesCount = "gamesCount"
        static let correctAnswers = "correctAnswers"
        static let totalQuestions = "totalQuestions"
        static let bestGame = "bestGame"
    }
    
    var gamesCount: Int {
        get { userDefaults.integer(forKey: Keys.gamesCount) }
        set { userDefaults.set(newValue, forKey: Keys.gamesCount) }
    }
    
    var correctAnswers: Int {
        get { userDefaults.integer(forKey: Keys.correctAnswers) }
        set { userDefaults.set(newValue, forKey: Keys.correctAnswers) }
    }
    
    var totalQuestions: Int {
        get { userDefaults.integer(forKey: Keys.totalQuestions) }
        set { userDefaults.set(newValue, forKey: Keys.totalQuestions) }
    }
    
    var totalAccuracy: Double {
        guard totalQuestions > 0 else { return 0 }
        return (Double(correctAnswers) / Double(totalQuestions)) * 100
    }
    
    var bestGame: GameResult? {
        get {
            guard let data = userDefaults.data(forKey: Keys.bestGame) else { return nil }
            return try? JSONDecoder().decode(GameResult.self, from: data)
        }
        set {
            guard let newValue = newValue,
                  let data = try? JSONEncoder().encode(newValue) else { return }
            userDefaults.set(data, forKey: Keys.bestGame)
        }
    }
    
    func store(correct count: Int, total amount: Int) {
        gamesCount += 1
        correctAnswers += count
        totalQuestions += amount

        let newResult = GameResult(correct: count, total: amount, date: Date())
        
        if let best = bestGame {
            if newResult.isBetterThan(best) {
                bestGame = newResult
            }
        } else {
            bestGame = newResult
        }
    }
}

