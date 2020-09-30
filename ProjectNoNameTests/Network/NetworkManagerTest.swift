//
//  NetworkManagerTest.swift
//  NetworkManagerTest
//
//  Created by Leonir Alves Deolindo on 28/09/20.
//

import XCTest
import Combine
@testable import ProjectNoName

class NetworkManagerTest: XCTestCase {
    
    struct User: Decodable {
        let name: String
    }
    
    func test_request_withValidJsonAndRequestSuccess_shouldParseJsonSuccess() {
        let expectation = XCTestExpectation(description: "Request and parse json with success")
        
        let sessionMock = SessionMock(stub: (file: "network_valid_json",
                                             statusCode: 200),
                                      urlError: nil)
        let networkManager = NetworkManager(session: sessionMock)
        let publisher: AnyPublisher<User, APIRequestError> = networkManager.request()
        
        let cancellable = publisher.sink { (completion) in
            switch completion {
            case .failure(let error):
                XCTFail(error.localizedDescription)
            case .finished:
                expectation.fulfill()
            }
        } receiveValue: { (user) in
            XCTAssertEqual(user.name, "user")
        }
        
        wait(for: [expectation], timeout: 1.0)
        cancellable.cancel()
    }
    
    func test_request_withValidJsonAndRequestSuccessAndStatusCode400_shouldReturnResponseErrorBadRequest() {
        let expectation = XCTestExpectation(description: "Request erro with statusCode = 400")
        
        let sessionMock = SessionMock(stub: (file: "network_valid_json",
                                             statusCode: 400),
                                      urlError: nil)
        let networkManager = NetworkManager(session: sessionMock)
        let publisher: AnyPublisher<User, APIRequestError> = networkManager.request()
        
        let cancellable = publisher.sink { (completion) in
            switch completion {
            case .failure(let error):
                XCTAssertEqual(error, .service(.badRequest))
                expectation.fulfill()
            case .finished:
                XCTFail("The publisher finished normaly. It didn't failure.")
            }
        } receiveValue: {_ in }
        
        wait(for: [expectation], timeout: 1.0)
        cancellable.cancel()
    }
    
    func test_request_withValidJsonAndRequestSuccessAndStatusCode401_shouldReturnResponseErrorUnauthorized() {
        let expectation = XCTestExpectation(description: "Request erro with statusCode = 401")
        
        let sessionMock = SessionMock(stub: (file: "network_valid_json",
                                             statusCode: 401),
                                      urlError: nil)
        let networkManager = NetworkManager(session: sessionMock)
        let publisher: AnyPublisher<User, APIRequestError> = networkManager.request()
        
        let cancellable = publisher.sink { (completion) in
            switch completion {
            case .failure(let error):
                XCTAssertEqual(error, .service(.unauthorized))
                expectation.fulfill()
            case .finished:
                XCTFail("The publisher finished normaly. It didn't failure.")
            }
        } receiveValue: {_ in }
        
        wait(for: [expectation], timeout: 1.0)
        cancellable.cancel()
    }
    
    func test_request_withValidJsonAndRequestSuccessAndStatusCode403_shouldReturnResponseErrorForbiden() {
        let expectation = XCTestExpectation(description: "Request erro with statusCode = 403")
        
        let sessionMock = SessionMock(stub: (file: "network_valid_json",
                                             statusCode: 403),
                                      urlError: nil)
        let networkManager = NetworkManager(session: sessionMock)
        let publisher: AnyPublisher<User, APIRequestError> = networkManager.request()
        
        let cancellable = publisher.sink { (completion) in
            switch completion {
            case .failure(let error):
                XCTAssertEqual(error, .service(.forbidden))
                expectation.fulfill()
            case .finished:
                XCTFail("The publisher finished normaly. It didn't failure.")
            }
        } receiveValue: {_ in }
        
        wait(for: [expectation], timeout: 1.0)
        cancellable.cancel()
    }
    
    func test_request_withValidJsonAndRequestSuccessAndStatusCode404_shouldReturnResponseErrorNotFound() {
        let expectation = XCTestExpectation(description: "Request erro with statusCode = 404")
        
        let sessionMock = SessionMock(stub: (file: "network_valid_json",
                                             statusCode: 404),
                                      urlError: nil)
        let networkManager = NetworkManager(session: sessionMock)
        let publisher: AnyPublisher<User, APIRequestError> = networkManager.request()
        
        let cancellable = publisher.sink { (completion) in
            switch completion {
            case .failure(let error):
                XCTAssertEqual(error, .service(.notFound))
                expectation.fulfill()
            case .finished:
                expectation.fulfill()
            }
        } receiveValue: {_ in }
        
        wait(for: [expectation], timeout: 1.0)
        cancellable.cancel()
    }
    
    func test_request_withValidJsonAndRequestSuccessAndStatusCode408_shouldReturnResponseErrorRequestTimeout() {
        let expectation = XCTestExpectation(description: "Request erro with statusCode = 408")
        
        let sessionMock = SessionMock(stub: (file: "network_valid_json",
                                             statusCode: 408),
                                      urlError: nil)
        let networkManager = NetworkManager(session: sessionMock)
        let publisher: AnyPublisher<User, APIRequestError> = networkManager.request()
        
        let cancellable = publisher.sink { (completion) in
            switch completion {
            case .failure(let error):
                XCTAssertEqual(error, .service(.requestTimeout))
                expectation.fulfill()
            case .finished:
                XCTFail("The publisher finished normaly. It didn't failure.")
            }
        } receiveValue: {_ in }
        
        wait(for: [expectation], timeout: 1.0)
        cancellable.cancel()
    }
    
    func test_request_withValidJsonAndRequestSuccessAndStatusCode407_shouldReturnResponseErrorClientError() {
        let expectation = XCTestExpectation(description: "Request erro with statusCode = 407")
        
        let sessionMock = SessionMock(stub: (file: "network_valid_json",
                                             statusCode: 407),
                                      urlError: nil)
        let networkManager = NetworkManager(session: sessionMock)
        let publisher: AnyPublisher<User, APIRequestError> = networkManager.request()
        
        let cancellable = publisher.sink { (completion) in
            switch completion {
            case .failure(let error):
                XCTAssertEqual(error, .service(.clientError))
                expectation.fulfill()
            case .finished:
                XCTFail("The publisher finished normaly. It didn't failure.")
            }
        } receiveValue: {_ in }
        
        wait(for: [expectation], timeout: 1.0)
        cancellable.cancel()
    }
    
    func test_request_withValidJsonAndRequestSuccessAndStatusCode500_shouldReturnResponseErrorInternalServerError() {
        let expectation = XCTestExpectation(description: "Request erro with statusCode = 500")
        
        let sessionMock = SessionMock(stub: (file: "network_valid_json",
                                             statusCode: 500),
                                      urlError: nil)
        let networkManager = NetworkManager(session: sessionMock)
        let publisher: AnyPublisher<User, APIRequestError> = networkManager.request()
        
        let cancellable = publisher.sink { (completion) in
            switch completion {
            case .failure(let error):
                XCTAssertEqual(error, .service(.internalServerError))
                expectation.fulfill()
            case .finished:
                XCTFail("The publisher finished normaly. It didn't failure.")
            }
        } receiveValue: {_ in }
        
        wait(for: [expectation], timeout: 1.0)
        cancellable.cancel()
    }
    
    func test_request_withValidJsonAndRequestSuccessAndStatusCode600_shouldReturnResponseErrorUnknown() {
        let expectation = XCTestExpectation(description: "Request erro with statusCode = 600")
        
        let sessionMock = SessionMock(stub: (file: "network_valid_json",
                                             statusCode: 600),
                                      urlError: nil)
        let networkManager = NetworkManager(session: sessionMock)
        let publisher: AnyPublisher<User, APIRequestError> = networkManager.request()
        
        let cancellable = publisher.sink { (completion) in
            switch completion {
            case .failure(let error):
                guard case let APIRequestError.service(.unknown(description)) = error else {
                    XCTFail("Error: description not found")
                    return
                }
                
                XCTAssertEqual(error, .service(.unknown(description)))
                expectation.fulfill()
            case .finished:
                XCTFail("The publisher finished normaly. It didn't failure.")
            }
        } receiveValue: {_ in }
        
        wait(for: [expectation], timeout: 1.0)
        cancellable.cancel()
    }
    
    func test_request_withValidJsonAndNetworkCancelled_shouldReturnAPIRequestErrorCancelled() {
        let expectation = XCTestExpectation(description: "Network connection cancelled")
        
        let sessionMock = SessionMock(stub: nil, urlError: URLError(.cancelled))
        let networkManager = NetworkManager(session: sessionMock)
        let publisher: AnyPublisher<User, APIRequestError> = networkManager.request()
        
        let cancellable = publisher.sink { (completion) in
            switch completion {
            case .failure(let error):
                XCTAssertEqual(error, .network(.cancelled))
                expectation.fulfill()
            case .finished:
                XCTFail("The publisher finished normaly. It didn't failure.")
            }
        } receiveValue: { _ in }

        wait(for: [expectation], timeout: 1.0)
        cancellable.cancel()
    }
    
    func test_request_withValidJsonAndNetworkCancelled_shouldReturnAPIRequestErrorConnectionLost() {
        let expectation = XCTestExpectation(description: "Network connection cancelled")
        
        let sessionMock = SessionMock(stub: nil, urlError: URLError(.networkConnectionLost))
        let networkManager = NetworkManager(session: sessionMock)
        let publisher: AnyPublisher<User, APIRequestError> = networkManager.request()
        
        let cancellable = publisher.sink { (completion) in
            switch completion {
            case .failure(let error):
                XCTAssertEqual(error, .network(.networkConnectionLost))
                expectation.fulfill()
            case .finished:
                XCTFail("The publisher finished normaly. It didn't failure.")
            }
        } receiveValue: { _ in }

        wait(for: [expectation], timeout: 1.0)
        cancellable.cancel()
    }
    
    func test_request_withValidJsonAndNetworkCancelled_shouldReturnAPIRequestErrorBadURL() {
        let expectation = XCTestExpectation(description: "Network connection cancelled")
        
        let sessionMock = SessionMock(stub: nil, urlError: URLError(.badURL))
        let networkManager = NetworkManager(session: sessionMock)
        let publisher: AnyPublisher<User, APIRequestError> = networkManager.request()
        
        let cancellable = publisher.sink { (completion) in
            switch completion {
            case .failure(let error):
                XCTAssertEqual(error, .network(.badURL))
                expectation.fulfill()
            case .finished:
                XCTFail("The publisher finished normaly. It didn't failure.")
            }
        } receiveValue: { _ in }

        wait(for: [expectation], timeout: 1.0)
        cancellable.cancel()
    }
    
    func test_request_withValidJsonAndNetworkCancelled_shouldReturnAPIRequestErrorTimeout() {
        let expectation = XCTestExpectation(description: "Network connection cancelled")
        
        let sessionMock = SessionMock(stub: nil, urlError: URLError(.timedOut))
        let networkManager = NetworkManager(session: sessionMock)
        let publisher: AnyPublisher<User, APIRequestError> = networkManager.request()
        
        let cancellable = publisher.sink { (completion) in
            switch completion {
            case .failure(let error):
                XCTAssertEqual(error, .network(.timedOut))
                expectation.fulfill()
            case .finished:
                XCTFail("The publisher finished normaly. It didn't failure.")
            }
        } receiveValue: { _ in }

        wait(for: [expectation], timeout: 1.0)
        cancellable.cancel()
    }
    
    func test_request_withValidJsonAndNetworkCancelled_shouldReturnAPIRequestErrorUnknown() {
        let expectation = XCTestExpectation(description: "Network connection cancelled")
        
        let sessionMock = SessionMock(stub: nil, urlError: URLError(.unknown))
        let networkManager = NetworkManager(session: sessionMock)
        let publisher: AnyPublisher<User, APIRequestError> = networkManager.request()
        
        let cancellable = publisher.sink { (completion) in
            switch completion {
            case .failure(let error):
                XCTAssertEqual(error, .network(.unknown("The operation couldn’t be completed. (NSURLErrorDomain error -1.)")))
                expectation.fulfill()
            case .finished:
                XCTFail("The publisher finished normaly. It didn't failure.")
            }
        } receiveValue: { _ in }

        wait(for: [expectation], timeout: 1.0)
        cancellable.cancel()
    }
    
    func test_request_withRequestSuccessAndNetworkOkAndJsonError_shouldReturnAPIRequestErrorTypeMismatch() {
        let expectation = XCTestExpectation(description: "Request success and Network Ok, but invalid json. Send Int but String expected. Should return error .typeMismatch")
        
        let sessionMock = SessionMock(stub: (file: "network_invalid_json_type_mismatch",
                                             statusCode: 200),
                                      urlError: nil)
        let networkManager = NetworkManager(session: sessionMock)
        let publisher: AnyPublisher<User, APIRequestError> = networkManager.request()
        
        let cancellable = publisher.sink { (completion) in
            switch completion {
            case .failure(let error):
                XCTAssertEqual(error,
                               .parse(.typeMismatch(debugDescription: "Expected to decode String but found a number instead.")))
                expectation.fulfill()
            case .finished:
                XCTFail("The publisher finished normaly. It didn't failure.")
            }
        } receiveValue: {_ in }
        
        wait(for: [expectation], timeout: 1.0)
        cancellable.cancel()
    }
    
    func test_request_withRequestSuccessAndNetworkOkAndJsonError_shouldReturnAPIRequestErrorValueNotFound() {
        let expectation = XCTestExpectation(description: "Request success and Network Ok, but invalid json. Should return error .valueNotFound")
        
        let sessionMock = SessionMock(stub: (file: "network_invalid_json_value_not_found",
                                             statusCode: 200),
                                      urlError: nil)
        let networkManager = NetworkManager(session: sessionMock)
        let publisher: AnyPublisher<User, APIRequestError> = networkManager.request()
        
        let cancellable = publisher.sink { (completion) in
            switch completion {
            case .failure(let error):
                XCTAssertEqual(error,
                               .parse(.valueNotFound(debugDescription: "Expected String value but found null instead.")))
                expectation.fulfill()
            case .finished:
                XCTFail("The publisher finished normaly. It didn't failure.")
            }
        } receiveValue: {_ in }
        
        wait(for: [expectation], timeout: 1.0)
        cancellable.cancel()
    }
    
    func test_request_withRequestSuccessAndNetworkOkAndJsonError_shouldReturnAPIRequestErrorKeyNotFound() {
        let expectation = XCTestExpectation(description: "Request success and Network Ok, but invalid json. Should return error .keyNotFound")
        
        let sessionMock = SessionMock(stub: (file: "network_invalid_json_key_not_found",
                                             statusCode: 200),
                                      urlError: nil)
        let networkManager = NetworkManager(session: sessionMock)
        let publisher: AnyPublisher<User, APIRequestError> = networkManager.request()
        
        let cancellable = publisher.sink { (completion) in
            switch completion {
            case .failure(let error):
                XCTAssertEqual(error,
                               .parse(.keyNotFound(debugDescription: "No value associated with key CodingKeys(stringValue: \"name\", intValue: nil) (\"name\").")))
                expectation.fulfill()
            case .finished:
                XCTFail("The publisher finished normaly. It didn't failure.")
            }
        } receiveValue: {_ in }
        
        wait(for: [expectation], timeout: 1.0)
        cancellable.cancel()
    }
    
    func test_request_withRequestSuccessAndNetworkOkAndJsonError_shouldReturnAPIRequestErrorDataCorrupted() {
        let expectation = XCTestExpectation(description: "Request success and Network Ok, but invalid json. Should return error .dataCorrupted")
        
        let sessionMock = SessionMock(stub: (file: "network_invalid_json_data_corrupted",
                                             statusCode: 200),
                                      urlError: nil)
        let networkManager = NetworkManager(session: sessionMock)
        let publisher: AnyPublisher<User, APIRequestError> = networkManager.request()
        
        let cancellable = publisher.sink { (completion) in
            switch completion {
            case .failure(let error):
                XCTAssertEqual(error,
                               .parse(.dataCorrupted(debugDescription: "The given data was not valid JSON.")))
                expectation.fulfill()
            case .finished:
                XCTFail("The publisher finished normaly. It didn't failure.")
            }
        } receiveValue: {_ in }
        
        wait(for: [expectation], timeout: 1.0)
        cancellable.cancel()
    }
}
