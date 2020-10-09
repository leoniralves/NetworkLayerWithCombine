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
    
    private var cancellable: AnyCancellable?
    
    init() {
        getMovies()
    }
}

extension MoviesViewModel {
    func getMovies() {
        let userTarget = MovieTarget.movie
        
        let networkManager = NetworkManager()
        let request: AnyPublisher<Movies, APIError> = networkManager.request(for: userTarget)
        
        cancellable = request
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (completion) in
                print("Completion \(completion)")
                switch completion {
                case .failure(let error):
                    print(error)
                case .finished:
                    print("Finished")
                }
            }, receiveValue: { (movies) in
                self.movies = movies.results
            })
    }
}

extension MoviesViewModel {
    enum MovieTarget: APIServiceTarget {
        case movie
        
        var path: String {
            "movie/upcoming"
        }
        
        var method: HTTPMethod {
            .GET
        }
        
        var header: [String : String]? {
            nil
        }
        
        #warning("Adicionar chave do MovieDB")
        var parameters: [String : String]? {
            ["api_key": ""]
        }
    }
}
