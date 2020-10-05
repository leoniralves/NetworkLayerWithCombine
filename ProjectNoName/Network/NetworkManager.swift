//
//  NetworkManager.swift
//  ProjectNoName
//
//  Created by Leonir Alves Deolindo on 28/09/20.
//

import Foundation
import Combine

enum HTTPMethod: String {
    case POST
    case GET
}

protocol APIServiceTarget {
    var path: String { get }
    var method: HTTPMethod { get }
    var header: [String: String]? { get }
    var parameters: [String: String]? { get }
}

class NetworkManager {
    
    private let session: APISession
    
    init(session: APISession = URLSession.shared) {
        self.session = session
    }
    
    func request<T: Decodable>(for target: APIServiceTarget) -> AnyPublisher<T, APIError> {
        guard let url = URL(string: "http://127.0.0.1:4000")?.appendingPathComponent(target.path) else {
            return Result<T, APIError>
                .Publisher(.network(.badURL))
                .eraseToAnyPublisher()
        }
        
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            return Result<T, APIError>
                .Publisher(.network(.badURL))
                .eraseToAnyPublisher()
        }
        
        urlComponents.queryItems = target.parameters?.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        guard let urlFromComponents = urlComponents.url else {
            return Result<T, APIError>
                .Publisher(.network(.badURL))
                .eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: urlFromComponents)
        request.httpMethod = target.method.rawValue
        request.allHTTPHeaderFields = target.header
        
        return session.request(for: request)
            .tryMap{
                if let response = $0.response as? HTTPURLResponse,
                   response.statusCode != 200 {
                    throw APIError(response)
                } else {
                    return $0.data
                }
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError{ (error) -> APIError in
                if let _error = error as? APIError {
                    return _error
                }
                
                if let _error = error as? URLError {
                    return APIError(_error)
                }
                
                if let _error = error as? DecodingError {
                    return APIError(_error)
                }
                
                return APIError.unknown
            }
            .eraseToAnyPublisher()
    }
}
