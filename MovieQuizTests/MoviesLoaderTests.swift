//
//  MoviesLoaderTests.swift
//  MovieQuiz
//
//  Created by natalia.limonova on 18.03.2025.
//
import XCTest
@testable import MovieQuiz

class MoviesLoaderTests: XCTestCase {
    func testSuccessLoading() throws {
        // Given
        let stubNetworkClient = StubNetworkClient(emulateError: false)
        let loader = MoviesLoader(networkClient: stubNetworkClient)
        
        // When
        let expectation = expectation(description: "Loading expectation")
        
        loader.loadMovies { result in
            // Then
            switch result {
            case .success(let movies):
                
                XCTAssertEqual(movies.items.count, 2)
                
                expectation.fulfill()
            case .failure(_):
                
                XCTFail("Unexpected failure")
            }
        }
        
        waitForExpectations(timeout: 1)
    }
}
