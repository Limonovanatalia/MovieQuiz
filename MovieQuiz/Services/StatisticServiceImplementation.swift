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
        static let bestGameCorrect = "bestGameCorrect"
        static let bestGameTotal = "bestGameTotal"
        static let bestGameDate = "bestGameDate"
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
            let correct = userDefaults.integer(forKey: Keys.bestGameCorrect)
            let total = userDefaults.integer(forKey: Keys.bestGameTotal)
            let date = userDefaults.object(forKey: Keys.bestGameDate) as? Date ?? Date()
            
            if correct == 0 && total == 0 { return nil } // Если рекорд не установлен
            
            return GameResult(correct: correct, total: total, date: date)
        }
        set {
            guard let newValue = newValue else { return }
            userDefaults.set(newValue.correct, forKey: Keys.bestGameCorrect)
            userDefaults.set(newValue.total, forKey: Keys.bestGameTotal)
            userDefaults.set(newValue.date, forKey: Keys.bestGameDate)
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

