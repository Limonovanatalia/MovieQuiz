//
//  QuestionFactoryDelegate.swift
//  MovieQuiz
//
//  Created by natalia.limonova on 29.12.2024.
//

import Foundation
protocol QuestionFactoryDelegate: AnyObject {
    func didReceiveNextQuestion(question: QuizQuestion?)
}
