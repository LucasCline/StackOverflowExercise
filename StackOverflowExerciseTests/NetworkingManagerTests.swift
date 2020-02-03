//
//  NetworkingManagerTests.swift
//  StackOverflowExerciseTests
//
//  Created by Amanda Bloomer  on 2/2/20.
//  Copyright © 2020 Lucas Cline. All rights reserved.
//

import XCTest
@testable import StackOverflowExercise

class NetworkingManagerTests: XCTestCase {
    var sut: NetworkingManager!

    override func setUp() {
        super.setUp()
        sut = NetworkingManager()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testBuildOneQueryParameter() {
        let input: [QueryParameter] = [QueryParameter(key: "key", value: "value")]
        let result = sut.build(queryParameters: input)
        
        XCTAssert(result == "?key=value")
    }
    
    func testBuildMultipleQueryParameters() {
        let input: [QueryParameter] = [QueryParameter(key: "key", value: "value"),
                                       QueryParameter(key: "key2", value: "value2"),
                                       QueryParameter(key: "key3", value: "value3")]
        let result = sut.build(queryParameters: input)
        
        XCTAssert(result == "?key=value&key2=value2&key3=value3")
    }
    
    func testBuildZeroQueryParameters() {
        let input: [QueryParameter] = []
        let result = sut.build(queryParameters: input)
        
        XCTAssert(result == "")
    }
}
