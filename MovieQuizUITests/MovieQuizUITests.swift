//
//  MovieQuizUITests.swift
//  MovieQuizUITests
//
//  Created by natalia.limonova on 19.03.2025.
//

import XCTest

final class MovieQuizUITests: XCTestCase {
    // swiftlint:disable:next implicitly_unwrapped_optional
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        app = XCUIApplication()
        app.launchArguments = ["UI-TESTING"]
        app.launch()
        
        continueAfterFailure = false
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        
        app.terminate()
        app = nil
    }
    
    @MainActor
    func testYesButton() {
        let firstPoster = app.images["Poster"].firstMatch
        
        XCTAssertTrue(firstPoster.waitForExistence(timeout: 3), "Первый постер не появился")
        let firstPosterData = firstPoster.screenshot().pngRepresentation

        let yesButton = app.buttons["Yes"]
        XCTAssertTrue(yesButton.exists, "Кнопка 'Yes' не найдена")
        yesButton.tap()

        let secondPoster = app.images["Poster"].firstMatch
        XCTAssertTrue(secondPoster.waitForExistence(timeout: 5), "Второй постер не появился")

        sleep(3)
        let secondPosterData = secondPoster.screenshot().pngRepresentation

        XCTAssertFalse(firstPosterData == secondPosterData, "Постер не изменился после нажатия 'Yes'")
    }
    
    @MainActor
        func testNoButton() {
            let firstPoster = app.images["Poster"].firstMatch
            
            XCTAssertTrue(firstPoster.waitForExistence(timeout: 3), "Первый постер не появился")
            let firstPosterData = firstPoster.screenshot().pngRepresentation

            let noButton = app.buttons["No"]
            XCTAssertTrue(noButton.exists, "Кнопка 'No' не найдена")
            noButton.tap()

            let secondPoster = app.images["Poster"].firstMatch
            XCTAssertTrue(secondPoster.waitForExistence(timeout: 5), "Второй постер не появился")

            sleep(3)
            let secondPosterData = secondPoster.screenshot().pngRepresentation

            XCTAssertFalse(firstPosterData == secondPosterData, "Постер не изменился после нажатия 'No'")
        }
    @MainActor
        func testGameFinish() {
            sleep(2)
            for _ in 1...10 {
                app.buttons["No"].tap()
                sleep(2)
            }
            
            let alert = app.alerts["Game results"]
            
            XCTAssertTrue(alert.exists, "Алерт не появился")
            XCTAssertEqual(alert.label, "Этот раунд окончен!", "Неверный заголовок алерта")
            XCTAssertEqual(alert.buttons.firstMatch.label, "Сыграть ещё раз", "Неверный текст на кнопке алерта")
        }
        
    @MainActor
    func testAlertDismiss() {
        sleep(2)
        for _ in 1...10 {
            app.buttons["No"].tap()
            sleep(5)
        }

        let alert = app.alerts["Этот раунд окончен!"]
        
        // Ожидание появления алерта
        XCTAssertTrue(alert.waitForExistence(timeout: 5), "Алерт не появился")
        
        // Выводим название кнопки в консоль для отладки
        print("Название кнопки в алерте: \(alert.buttons.firstMatch.label)")

        // Проверяем, что кнопка существует
        XCTAssertTrue(alert.buttons.firstMatch.exists, "Кнопка в алерте не найдена")
        
        // Нажимаем на кнопку
        alert.buttons.firstMatch.tap()

        sleep(5)

        let indexLabel = app.staticTexts["Index"]

        XCTAssertFalse(alert.exists, "Алерт все еще присутствует")
        XCTAssertEqual(indexLabel.label, "1/10", "Индекс не сброшен после закрытия алерта")
    }

}

