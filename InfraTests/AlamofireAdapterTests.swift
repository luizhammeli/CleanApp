//
//  InfraTests.swift
//  InfraTests
//
//  Created by Luiz Diniz Hammerli on 29/08/21.
//

import XCTest
import Alamofire
import Data
//@testable import Infra

class AlamofireAdapter: HttpPostClient {
    private let session: Alamofire.Session
    
    init(session: Alamofire.Session = .default) {
        self.session = session
    }
    
    func post(to url: URL, with data: Data?, completion: @escaping (Result<Data, HttpError>) -> Void) {
        var json: [String: Any]?
        json = data?.toDictionary()
        session.request(url, method: .post, parameters: json).response(completionHandler: { _ in
            completion(.failure(.noConnectivity))
        }).resume()
    }
}

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
}

class URLProtocolStub: URLProtocol {
    static private var emiter: ((URLRequest) -> Void)?
    static func observeRequest(completion: @escaping (URLRequest) -> Void) {
        URLProtocolStub.emiter = completion
    }
    
    override open class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override open class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override open func startLoading() {
        URLProtocolStub.emiter?(request)
        client?.urlProtocolDidFinishLoading(self)
    }

    override open func stopLoading() {}
}
