//
//  InfraTests.swift
//  InfraTests
//
//  Created by Luiz Diniz Hammerli on 29/08/21.
//

import XCTest
import Alamofire
//@testable import Infra

class AlamofireAdapter {
    private let session: Alamofire.Session
    
    init(session: Alamofire.Session = .default) {
        self.session = session
    }
    
    func post(to url: URL, with data: Data?) {
        var json: [String: Any]?
        if let data = data {
            json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
        }
        session.request(url, method: .post, parameters: json).resume()
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
        URLProtocolStub.observeRequest { request in
            completion(request)
            expectation.fulfill()
        }
        sut.post(to: url, with: data)
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
    }

    override open func stopLoading() {}
}
