//  AlertPresenter.swift
//  MovieQuiz
//
//  Created by natalia.limonova on 29.12.2024.
//

import Foundation

struct AlertModel {
    let title: String
    let message: String
    let buttonText: String
    let completion: (() -> Void)?
}
