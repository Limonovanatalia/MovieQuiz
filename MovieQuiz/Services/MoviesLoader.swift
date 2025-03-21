//
//  MoviesLoader.swift
//  MovieQuiz
//
//  Created by natalia.limonova on 14.03.2025.
//

import Foundation
import UIKit

protocol MoviesLoading {
    func loadMovies(handler: @escaping (Result<MostPopularMovies, Error>) -> Void)
}

class MoviesLoader: MoviesLoading {
    
    // MARK: - NetworkClient
    private let networkClient: NetworkRouting
    
    init(networkClient: NetworkRouting = NetworkClient()) {
        self.networkClient = networkClient
    }
    // MARK: - URL
    private var mostPopularMoviesUrl: URL? {
        return URL(string: "https://tv-api.com/en/API/Top250Movies/k_zcuw1ytf")
    }
    
    func loadMovies(handler: @escaping (Result<MostPopularMovies, Error>) -> Void) {
        guard let url = mostPopularMoviesUrl else {
            handler(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Некорректный URL"])))
            return
        }
        
        networkClient.fetch(url: url) { result in
            switch result {
            case .success(let data):
                do {
                    let mostPopularMovies = try JSONDecoder().decode(MostPopularMovies.self, from: data)
                    handler(.success(mostPopularMovies))
                } catch {
                    handler(.failure(error))
                }
            case .failure(let error):
                
                handler(.failure(error))
            }
        }
    }
}

enum NetworkError: Error {
    case invalidURL
}

