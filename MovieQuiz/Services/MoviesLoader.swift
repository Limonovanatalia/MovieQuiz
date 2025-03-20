//
//  MoviesLoader.swift
//  MovieQuiz
//
//  Created by natalia.limonova on 14.03.2025.
//

import Foundation

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
            handler(.failure(NetworkError.invalidURL))
            return
        }
        
        networkClient.fetch(url: url) { result in
            switch result {
            case .success(let data):
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Данные от API:", jsonString)
                }
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

