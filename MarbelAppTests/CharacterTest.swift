//
//  CharacterTest.swift
//  MarbelAppTests
//
//  Created by APPLE on 13/02/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//

import XCTest
@testable import MarbelApp

class CurrencyTests: XCTestCase {
    
    let char1 = Character(id: 111111, name: "char1", thumbnail: Thumbnail(path: String(), imageExtension: String()))
    let char2 = Character(id: 222222, name: "char2", thumbnail: Thumbnail(path: String(), imageExtension: String()))

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCreation() {
        XCTAssertNotNil(char1)
        XCTAssertNotNil(char2)
    }

    func testEquality(){
        XCTAssertNotEqual(char1, char2)
        XCTAssertEqual(char1, Character(id: 111111, name: "char1", thumbnail: Thumbnail(path: String(), imageExtension: String())))
    }

    func testHashes(){
        XCTAssertEqual(char1.hashValue,
                       Character(id: 111111, name: "char1",
                                 thumbnail: Thumbnail(path: String(), imageExtension: String()))
                        .hashValue)
        XCTAssertEqual(char2.hashValue,
                       Character(id: 222222, name: "char2",
                                 thumbnail: Thumbnail(path: String(), imageExtension: String()))
                        .hashValue)
        
        XCTAssertNotEqual(char1.hashValue, char2.hashValue)

    }

    func testRepresentation(){
        XCTAssertEqual(char1.debugDescription, "<Character: 111111/char1>")
    }
}
