//
//  QuestionFactoryProtocol.swift
//  MovieQuiz
//
//  Created by natalia.limonova on 29.12.2024.
//

import Foundation

protocol QuestionFactoryProtocol {
    var delegate: QuestionFactoryDelegate? { get set }
    func requestNextQuestion()
    func loadData()
}
