//
//  NetworkClient.swift
//  MovieQuiz
//
//  Created by natalia.limonova on 14.03.2025.
//

import Foundation
import UIKit

protocol NetworkRouting {
    func fetch(url: URL, handler: @escaping (Result<Data, Error>) -> Void)
}
struct NetworkClient: NetworkRouting {
    
    private enum NetworkError: Error {
        case codeError
    }
    
    func fetch(url: URL, handler: @escaping (Result<Data, Error>) -> Void) {
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    handler(.failure(error))
                }
                return
            }
            
            if let response = response as? HTTPURLResponse,
               response.statusCode < 200 || response.statusCode >= 300 {
                DispatchQueue.main.async {
                    handler(.failure(NetworkError.codeError))
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    handler(.failure(NetworkError.codeError))
                }
                return
            }
            
            DispatchQueue.main.async {
                handler(.success(data))
            }
        }
        
        task.resume()
    }
    
}
