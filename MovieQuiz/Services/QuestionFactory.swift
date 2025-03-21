//
//  QuestionFactory.swift
//  MovieQuiz
//
//  Created by natalia.limonova on 28.12.2024.
//

import Foundation
import UIKit

struct MostPopularMovies: Codable {
    let items: [MostPopularMovie]
}

class QuestionFactory: QuestionFactoryProtocol {
    private let moviesLoader: MoviesLoading
    weak var delegate: QuestionFactoryDelegate?
    
    private var movies: [MostPopularMovie] = []
    
    init(moviesLoader: MoviesLoading, delegate: QuestionFactoryDelegate?) {
        self.moviesLoader = moviesLoader
        self.delegate = delegate
    }
    
    func loadData() {
        moviesLoader.loadMovies { [weak self] (result: Result<MostPopularMovies, Error>) in
            guard let self = self else { return }
            switch result {
            case .success(let mostPopularMovies):
                self.movies = mostPopularMovies.items
                self.delegate?.didLoadDataFromServer()
            case .failure(let error):
                self.delegate?.didFailToLoadData(with: error)
            }
        }
    }
    
    func requestNextQuestion() {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            let index = (0..<self.movies.count).randomElement() ?? 0
            
            guard let movie = self.movies[safe: index] else { return }
            
            let rating = Float(movie.rating) ?? 0
            let text = "Рейтинг этого фильма больше чем 7?"
            let correctAnswer = rating > 7
            
            let imageURL = movie.resizedImageURL
            print("Загружается изображение: \(imageURL)")
            
            let task = URLSession.shared.dataTask(with: imageURL) { data, response, error in
                if let error = error {
                    print("Ошибка загрузки изображения: \(error.localizedDescription)")
                    return
                }
                
                guard let data = data else {
                    print("Пустой ответ изображения")
                    return
                }
                
                let question = QuizQuestion(
                    image: data,
                    text: text,
                    correctAnswer: correctAnswer
                )
                
                DispatchQueue.main.async {
                    self.delegate?.didReceiveNextQuestion(question: question)
                }
            }
            
            task.resume()
        }
    }
}




