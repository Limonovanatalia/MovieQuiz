//
//  StatisticService.swift
//  MovieQuiz
//
//  Created by natalia.limonova on 06.03.2025.
//

import Foundation
protocol StatisticServiceProtocol {
    var gamesCount: Int { get }
    var correctAnswers: Int { get }
    var totalQuestions: Int { get }
    var bestGame: GameResult? { get }
    var totalAccuracy: Double { get }
    
    func store(correct count: Int, total amount: Int)
}
