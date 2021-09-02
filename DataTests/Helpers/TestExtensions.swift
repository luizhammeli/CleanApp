//
//  TestExtensions.swift
//  DataTests
//
//  Created by Luiz Diniz Hammerli on 26/08/21.
//

import XCTest

extension XCTestCase {
    func checkMemoryLeak(for instance: AnyObject, file: StaticString = #filePath, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, file: file, line:  line)
        }
    }
}
