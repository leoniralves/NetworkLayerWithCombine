//
//  APIRequestProtocol.swift
//  ProjectNoName
//
//  Created by Leonir Alves Deolindo on 30/09/20.
//

import Foundation
import Combine

protocol APIRequestProtocol {
    func request(for url: URL) -> AnyPublisher<URLSession.DataTaskPublisher.Output, URLSession.DataTaskPublisher.Failure>
//    func request(for request: URLRequest) -> AnyPublisher<URLSession.DataTaskPublisher.Output, URLSession.DataTaskPublisher.Failure>
}

extension URLSession: APIRequestProtocol {
    func request(for url: URL) -> AnyPublisher<DataTaskPublisher.Output, DataTaskPublisher.Failure> {
        dataTaskPublisher(for: url)
            .eraseToAnyPublisher()
    }
    
//    func request(for request: URLRequest) -> AnyPublisher<DataTaskPublisher.Output, DataTaskPublisher.Failure> {
//        dataTaskPublisher(for: request)
//            .eraseToAnyPublisher()
//    }
}
