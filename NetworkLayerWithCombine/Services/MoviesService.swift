//
//  MoviesService.swift
//  NetworkLayerWithCombine
//
//  Created by Fábio Salata on 09/10/20.
//

import Foundation
import Combine

final class MoviesService {
    func fetchMovies() -> AnyPublisher<[Movie], APIError> {
        let userTarget = MovieTarget.movie
        
        let networkManager = NetworkManager()
        let request: AnyPublisher<Movies, APIError> = networkManager.request(for: userTarget)
        
        return request
            .compactMap { $0.results }
            .eraseToAnyPublisher()
    }
}

extension MoviesService {
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
