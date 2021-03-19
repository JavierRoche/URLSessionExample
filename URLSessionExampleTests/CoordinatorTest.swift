//
//  CoordinatorTest.swift
//  URLSessionExampleTest
//
//  Created by APPLE on 19/02/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//

import XCTest
@testable import URLSessionExample

class CoordinatorTest: XCTestCase {

    let coordinator1 = Coordinator()
    let coordinator2 = Coordinator()

    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCreation(){
        XCTAssertNotNil(Coordinator())
    }
    
    func testEquality(){
        coordinator1.addCoordinator(coordinator: coordinator2)
        coordinator1.addCoordinator(coordinator: coordinator2)
        
        coordinator2.addCoordinator(coordinator: coordinator1)
        coordinator2.addCoordinator(coordinator: coordinator1)
        
        XCTAssertEqual(coordinator1, coordinator1)
        XCTAssertNotEqual(coordinator1, coordinator2)
    }
    
    func testAddition() {
        coordinator1.addCoordinator(coordinator: coordinator2)
        
        XCTAssertEqual(coordinator1.countCoordinators(), 1)
    }
}



