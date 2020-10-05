//
//  SessionMock.swift
//  ProjectNoNameTests
//
//  Created by Leonir Alves Deolindo on 30/09/20.
//

import XCTest
import Combine
@testable import ProjectNoName

class SessionMock: APISession {
    private let stub: (file: String, statusCode: Int)?
    private let urlError: URLError?
    
    init(stub: (file: String, statusCode: Int)?,
         urlError: URLError?) {
        self.stub = stub
        self.urlError = urlError
    }
    
    func request(for request: URLRequest) -> AnyPublisher<URLSession.DataTaskPublisher.Output, URLSession.DataTaskPublisher.Failure> {
        if let response = makeResponse() {
            return Result.success(response)
                .publisher
                .eraseToAnyPublisher()
        } else {
            return Result.failure(urlError!)
                .publisher
                .eraseToAnyPublisher()
        }
    }
    
    private func makeResponse() -> (data: Data, response: URLResponse)? {
        if let stub = self.stub,
           let url = Bundle(for: Self.self).url(forResource: stub.file,
                                                withExtension: "json"),
           let data = try? String(contentsOf: url).data(using: .utf8),
           let response: URLResponse = HTTPURLResponse(url: url,
                                                       statusCode: stub.statusCode,
                                                       httpVersion: nil,
                                                       headerFields: nil) {
            
            return (data, response)
        }
        return nil
    }
}
