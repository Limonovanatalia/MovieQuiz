//
//  MovieQuizPresenterTests.swift
//
//  Created by natalia.limonova on 21.03.2025.
//

import XCTest
@testable import MovieQuiz

final class MovieQuizPresenterTests: XCTestCase {
    func testConvert() {
        let mockViewController = MockMovieQuizViewController()
        let questionFactory = MockQuestionFactory()
        let statisticService = MockStatisticService() 

        let presenter = MovieQuizPresenter(
            questionFactory: questionFactory,
            statisticService: statisticService
        )
        presenter.viewController = mockViewController

        let question = QuizQuestion(imageURL: "https://via.placeholder.com/150", text: "Test Question", correctAnswer: true)

        let expectation = expectation(description: "Convert completion called")

        presenter.convert(model: question) { viewModel in
            XCTAssertNotNil(viewModel)
            XCTAssertEqual(viewModel?.question, "Test Question")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2.0)
    }

