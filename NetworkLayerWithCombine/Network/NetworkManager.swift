//
//  NetworkManager.swift
//  ProjectNoName
//
//  Created by Leonir Alves Deolindo on 28/09/20.
//

import Foundation
import Combine

typealias JSON = [String: Any]
typealias DataTypeResult = (data: Data, response: URLResponse)

class NetworkManager {
    
    private let session: APISession
    
    init(session: APISession = URLSession.shared) {
        self.session = session
    }
    
    func request<T: Decodable>(for target: APIServiceTarget) -> AnyPublisher<T, APIError> {
        let request = URLRequest(baseUrl: API.baseURL, target: target)
        
        return session.request(for: request)
            .getData(T.self)
            .mapApiError()
            .eraseToAnyPublisher()
    }
}

extension Publisher where Output == DataTypeResult {
    func getData<T: Decodable>(_ type: T.Type) -> AnyPublisher<T, Error> {
        return self
            .tryMap {
                if let response = $0.response as? HTTPURLResponse,
                   !(200...300).contains(response.statusCode) {
                    throw APIError(response)
                }
                
                return $0.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

extension Publisher where Failure == Error {
    func mapApiError() -> AnyPublisher<Output, APIError> {
        return self
            .mapError { error -> APIError in
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
