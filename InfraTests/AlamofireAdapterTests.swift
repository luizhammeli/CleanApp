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
    
    func post(to url: URL) {
        session.request(url, method: .post).resume()
    }
}

class AlamofireAdapterTests: XCTestCase {
    func test_() {
        let config = URLSessionConfiguration.default
        config.protocolClasses = [URLProtocolStub.self]
        let session = Alamofire.Session(configuration: config)
        let adapter = AlamofireAdapter(session: session)
        let url = makeFakeURL()
        
        let expectation = expectation(description: "waiting")
        URLProtocolStub.observeRequest { request in
            XCTAssertEqual(request.url, url)
            XCTAssertEqual(request.method, .post)
            expectation.fulfill()
        }
        
        adapter.post(to: url)
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
