//
//  MethodTest.swift
//  URLSessionExampleTest
//
//  Created by APPLE on 19/02/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//

import XCTest
@testable import URLSessionExample

class MethodTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCreation(){
        for each in Method.allCases {
            XCTAssertNotNil(each)
        }
    }
    
    func testEquality(){
        XCTAssertEqual(Method.GET, Method.GET)
        XCTAssertNotEqual(Method.GET, Method.POST)
    }
    
    func testHashes(){
        XCTAssertEqual(Method.GET.hashValue, Method.GET.hashValue)
        XCTAssertNotEqual(Method.GET.hashValue, Method.POST.hashValue)
    }
}


