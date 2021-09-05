//
//  InfraTests.swift
//  InfraTests
//
//  Created by Luiz Diniz Hammerli on 29/08/21.
//

import XCTest
import Alamofire
import Data
import Infra

class AlamofireAdapterTests: XCTestCase {
    func test_should_make_request_with_valid_data_url_and_method() {
        let url = makeFakeURL()
        testRequest(url: url, data: makeValidData()) { request in
            XCTAssertEqual(request.url, url)
            XCTAssertEqual(request.method, .post)
            XCTAssertNotNil(request.httpBodyStream)
        }
    }
    
    func test_should_make_request_with_no_data() {
        testRequest(url: makeFakeURL()) { request in
            XCTAssertNil(request.httpBodyStream)
        }
    }
    
    func test_should_complete_with_error_when_request_completes_with_error() {
        expect(.failure(.noConnectivity), when: (data: nil, response: nil, error: makeFakeError()))
    }
    
    func test_should_complete_with_error_in_all_invalid_cases() {
        expect(.failure(.noConnectivity), when: (data: nil, response: nil, error: nil))
        expect(.failure(.noConnectivity), when: (data: makeValidData(), response: makeFakeURLResponse(), error: makeFakeError()))
        expect(.failure(.noConnectivity), when: (data: makeValidData(), response: nil, error: makeFakeError()))
        expect(.failure(.noConnectivity), when: (data: nil, response: makeFakeURLResponse(), error: nil))
        expect(.failure(.noConnectivity), when: (data: nil, response: makeFakeURLResponse(), error: makeFakeError()))
        expect(.failure(.noConnectivity), when: (data: makeValidData(), response: nil, error: nil))
    }
    
    func test_should_complete_with_data_when_request_completes_with_200() {
        let data = makeValidData()
        expect(.success(data), when: (data: data, response: makeFakeURLResponse(), error: nil))
    }
    
    func test_should_complete_with_emptyData_when_request_completes_with_204() {
        expect(.success(nil), when: (data: nil, response: makeFakeURLResponse(statusCode: 204), error: nil))
        expect(.success(nil), when: (data: makeValidData(), response: makeFakeURLResponse(statusCode: 204), error: nil))
        expect(.success(nil), when: (data: makeEmptyData(), response: makeFakeURLResponse(statusCode: 204), error: nil))
    }
    
    func test_should_complete_with_error_when_request_completes_with_non_200() {
        let data = makeValidData()
        expect(.failure(.badRequest), when: (data: data, response: makeFakeURLResponse(statusCode: 400), error: nil))
        expect(.failure(.badRequest), when: (data: data, response: makeFakeURLResponse(statusCode: 499), error: nil))
        expect(.failure(.unauthorized), when: (data: data, response: makeFakeURLResponse(statusCode: 401), error: nil))
        expect(.failure(.forbidden), when: (data: data, response: makeFakeURLResponse(statusCode: 403), error: nil))
        expect(.failure(.serverError), when: (data: data, response: makeFakeURLResponse(statusCode: 500), error: nil))
        expect(.failure(.serverError), when: (data: data, response: makeFakeURLResponse(statusCode: 599), error: nil))
        expect(.failure(.noConnectivity), when: (data: data, response: makeFakeURLResponse(statusCode: 600), error: nil))
    }
}

extension AlamofireAdapterTests {
    func makeSut(file: StaticString = #filePath, line: UInt = #line) -> AlamofireAdapter {
        let config = URLSessionConfiguration.default
        config.protocolClasses = [URLProtocolStub.self]
        let session = Alamofire.Session(configuration: config)
        let sut = AlamofireAdapter(session: session)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
    
    func testRequest(url: URL = makeFakeURL(), data: Data? = nil, completion: @escaping (URLRequest) -> Void) {
        let sut = makeSut()
        let expectation = expectation(description: "waiting")
        var request: URLRequest!

        sut.post(to: url, with: data) { _ in
            completion(request)
            expectation.fulfill()
        }
        
        URLProtocolStub.observeRequest { request = $0 }
        wait(for: [expectation], timeout: 1)
    }
    
    func expect(_ expectedResult: Result<Data?, HttpError>, when stub: (data: Data?, response: URLResponse?, error: Error?), file: StaticString = #filePath, line: UInt = #line) {
        let sut = makeSut()
        URLProtocolStub.simulate(data: stub.data, response: stub.response, error: stub.error)
        
        let expectation = expectation(description: "waiting")
        sut.post(to: makeFakeURL(), with: makeValidData()) { receivedResult in
            switch (expectedResult, receivedResult) {
            case (.success(let expectedData), .success(let receivedData)):
                XCTAssertEqual(expectedData, receivedData, "Expected \(String(describing: expectedData)) got \(String(describing: receivedData)) instead", file: file, line: line)
            case (.failure(let expectedError), .failure(let receivedError)):
                XCTAssertEqual(expectedError, receivedError, "Expected \(expectedError) got \(receivedError) instead", file: file, line: line)
            default:
                XCTFail("Expected \(expectedResult) got \(receivedResult) instead", file: file, line: line)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
}
