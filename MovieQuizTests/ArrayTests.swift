//
//  ArrayTests.swift
//  MovieQuiz
//
//  Created by natalia.limonova on 17.03.2025.
//

import XCTest
@testable import MovieQuiz

class ArrayTests: XCTestCase {
    func testGetValueRange() throws {
        // Given
        let array = [1, 2, 3, 4, 5]
        // When
        let value = array[safe: 2]
        //Then
        XCTAssertNotNil(value)
        XCTAssertEqual(value, 3)
        
    }
    func testGetValueOutOfRange() throws {
        //Given
        let array = [1, 2, 3, 4, 5]
        //When
        let value = array[safe: 20]
        //Then
        XCTAssertNil(value)
        
    }
}
