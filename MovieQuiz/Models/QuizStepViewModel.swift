//
//  QuizStepVieqModel.swift
//  MovieQuiz
//
//  Created by natalia.limonova on 28.12.2024.
//

import Foundation
import UIKit
//вью модель для состояния "Вопрос показан"
struct QuizStepViewModel {
    let image: UIImage
    let question: String
    let questionNumber: String
}
//метод конвертации, который принимает моковый вопрос и возврщает вью модель для главного экрана
private func convert(model: QuizQuestion) -> QuizStepViewModel {
    let questionStep = QuizStepViewModel(
        image: UIImage(named: model.image) ?? UIImage(),
        question: model.text,
        questionNumber: "\(currentQuestionIndex + 1)/\(questions.count)")
    return questionStep
}
