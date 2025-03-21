//
//  MockMovieQuizViewController.swift
//  MovieQuiz
//
//  Created by natalia.limonova on 21.03.2025.
//

import Foundation
@testable import MovieQuiz

final class MockMovieQuizViewController: MovieQuizViewControllerProtocol {
    func show(quiz step: QuizStepViewModel) { }
    func show(quiz result: QuizResultsViewModel) { }
    func highlightImageBorder(isCorrectAnswer: Bool) { }
    func showLoadingIndicator() { }
    func hideLoadingIndicator() { }
    func showNetworkError(message: String) { }

    func highlightAnswer(isCorrect: Bool) { }
    func resetAnswerHighlight() { }
    func showQuizResult(_ result: QuizResultsViewModel) { }
}
