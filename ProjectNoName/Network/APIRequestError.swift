//
//  APIRequestError.swift
//  ProjectNoName
//
//  Created by Leonir Alves Deolindo on 30/09/20.
//

import Foundation

enum APIRequestError: Error, Equatable {
    case service(Service)
    case network(Network)
    case parse(Parse)
    
    enum Service: Error, Equatable {
        case badRequest
        case unauthorized
        case forbidden
        case notFound
        case requestTimeout
        case clientError
        case internalServerError
        case unknown(String)
    }
    
    enum Network: Error, Equatable {
        case cancelled
        case networkConnectionLost
        case badURL
        case timedOut
        case unknown(String)
    }
    
    enum Parse: Error, Equatable {
        case typeMismatch(debugDescription: String)
        case valueNotFound(debugDescription: String)
        case keyNotFound(debugDescription: String)
        case dataCorrupted(debugDescription: String)
        case unknown
    }
    
    case unknown
}

extension APIRequestError {
    init(_ error: HTTPURLResponse) {
        self = .service(Service(error))
    }
    
    init(_ error: URLError) {
        self = .network(Network(error))
    }
    
    init(_ error: DecodingError) {
        self = .parse(Parse(error))
    }
}

extension APIRequestError.Service {
    init(_ httpURLResponse: HTTPURLResponse) {
        switch httpURLResponse.statusCode {
        case 400: self = .badRequest
        case 401: self = .unauthorized
        case 403: self = .forbidden
        case 404: self = .notFound
        case 405, 406, 407, 409..<500: self = .clientError
        case 408: self = .requestTimeout
        case 500..<600: self = .internalServerError
        default: self = .unknown(httpURLResponse.debugDescription)
        }
    }
}

extension APIRequestError.Network {
    init(_ urlError: URLError) {
        switch urlError.code {
        case .cancelled: self = .cancelled
        case .networkConnectionLost: self = .networkConnectionLost
        case .badURL: self = .badURL
        case .timedOut: self = .timedOut
        default: self = .unknown(urlError.localizedDescription)
        }
    }
}

extension APIRequestError.Parse {
    init(_ decodingError: DecodingError) {
        switch decodingError {
        case let .typeMismatch( _, context): self = .typeMismatch(debugDescription: context.debugDescription)
        case let .valueNotFound( _, context): self = .valueNotFound(debugDescription: context.debugDescription)
        case let .keyNotFound( _, context): self = .keyNotFound(debugDescription: context.debugDescription)
        case let .dataCorrupted(context): self = .dataCorrupted(debugDescription: context.debugDescription)
        default: self = .unknown
        }
    }
}
