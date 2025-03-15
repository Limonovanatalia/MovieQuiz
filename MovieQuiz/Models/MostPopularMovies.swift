//
//  MostPopularMovies.swift
//  MovieQuiz
//
//  Created by natalia.limonova on 14.03.2025.
//

import Foundation

struct MostPopularMovie: Codable {
    let title: String
    let rating: String
    let imageURL: String
    
    var resizedImageURL: URL {
        let urlString = imageURL.components(separatedBy: "._").first ?? "" + "._V0_UX600_.jpg"
        return URL(string: urlString) ?? URL(string: "https://example.com/placeholder.jpg")!
    }
    
    private enum CodingKeys: String, CodingKey {
        case title = "fullTitle"
        case rating = "imDbRating"
        case imageURL = "image"
    }
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        rating = try container.decode(String.self, forKey: .rating)
        imageURL = try container.decode(String.self, forKey: .imageURL)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(rating, forKey: .rating)
        try container.encode(imageURL, forKey: .imageURL)
    }
}

