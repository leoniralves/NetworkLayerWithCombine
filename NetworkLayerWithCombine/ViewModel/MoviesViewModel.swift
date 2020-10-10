//
//  UserService.swift
//  NetworkLayerWithCombine
//
//  Created by Fábio Salata on 08/10/20.
//

import Foundation
import Combine

struct Movies: Codable {
    let results: [Movie]?
    let page, totalResults: Int?
    let totalPages: Int?
    
    enum CodingKeys: String, CodingKey {
        case results, page
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
}

struct Movie: Codable {
    let id: Int?
    let title: String
    let posterPath: String?
    let genreIDS: [Int]?
    let backdropPath: String?
    let overview, releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
        case genreIDS = "genre_ids"
        case backdropPath = "backdrop_path"
        case overview
        case releaseDate = "release_date"
    }
}

class MoviesViewModel: ObservableObject {
    @Published var movies: [Movie]?
    @Published var error: APIError?
    
    private var moviesSubscriber: AnyCancellable?
    
    private var service: MoviesService
    
    init(service: MoviesService = MoviesService()) {
        self.service = service
        
       fetchUpcomingMovies()
    }
    
    private func fetchUpcomingMovies() {
        moviesSubscriber = self.service.fetchMovies()
            .receive(on: RunLoop.main)
            .sink { completion in
                if case Subscribers.Completion.failure(let error) = completion {
                    self.error = error
                }
            } receiveValue: { movies in
                self.movies = movies
            }
        
    }
}
