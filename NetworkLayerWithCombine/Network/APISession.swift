//
//  APISession.swift
//  ProjectNoName
//
//  Created by Leonir Alves Deolindo on 30/09/20.
//

import Foundation
import Combine

protocol APISession {
    func request(for request: URLRequest) -> AnyPublisher<URLSession.DataTaskPublisher.Output, URLSession.DataTaskPublisher.Failure>
}

extension URLSession: APISession {
    func request(for request: URLRequest) -> AnyPublisher<DataTaskPublisher.Output, DataTaskPublisher.Failure> {
        dataTaskPublisher(for: request)
            .eraseToAnyPublisher()
    }
}
