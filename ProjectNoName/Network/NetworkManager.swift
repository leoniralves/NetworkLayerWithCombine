//
//  NetworkManager.swift
//  ProjectNoName
//
//  Created by Leonir Alves Deolindo on 28/09/20.
//

import Foundation
import Combine

class NetworkManager {
    
    private let session: APIRequestProtocol
    
    init(session: APIRequestProtocol = URLSession.shared) {
        self.session = session
    }
    
    func request<T: Decodable>() -> AnyPublisher<T, APIRequestError> {
        let url = URL(string: "http://127.0.0.1:4000/user")!
        return session.request(for: url)
            .tryMap{
                if let response = $0.response as? HTTPURLResponse,
                   response.statusCode != 200 {
                    throw APIRequestError(response)
                } else {
                    return $0.data
                }
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError{ (error) -> APIRequestError in
                if let _error = error as? APIRequestError {
                    return _error
                }
                
                if let _error = error as? URLError {
                    return APIRequestError(_error)
                }
                
                if let _error = error as? DecodingError {
                    return APIRequestError(_error)
                }
                
                return APIRequestError.unknown
            }
            .eraseToAnyPublisher()
    }
}
