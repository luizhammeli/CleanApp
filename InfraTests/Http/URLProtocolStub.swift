//
//  URLProtocolStub.swift
//  InfraTests
//
//  Created by Luiz Diniz Hammerli on 05/09/21.
//

import Foundation

class URLProtocolStub: URLProtocol {
    static private var emiter: ((URLRequest) -> Void)?
    static private var error: Error?
    static private var data: Data?
    static private var response: URLResponse?
    
    static func observeRequest(completion: @escaping (URLRequest) -> Void) {
        URLProtocolStub.emiter = completion
    }
    
    static func simulate(data: Data?, response: URLResponse?, error: Error?) {
        URLProtocolStub.data = data
        URLProtocolStub.response = response
        URLProtocolStub.error = error
    }
    
    override open class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override open class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override open func startLoading() {
        URLProtocolStub.emiter?(request)
        
        if let data = URLProtocolStub.data {
            client?.urlProtocol(self, didLoad: data)
        }
        
        if let response = URLProtocolStub.response {
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        }
        
        if let error = URLProtocolStub.error {
            client?.urlProtocol(self, didFailWithError: error)
        }
        
        client?.urlProtocolDidFinishLoading(self)
    }

    override open func stopLoading() {}
}
