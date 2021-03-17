//
//  ViewModelTest.swift
//  URLSessionExampleTest
//
//  Created by APPLE on 17/03/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//

import XCTest
@testable import URLSessionExample

class ViewModelTest: XCTestCase {

    var viewModel: CharsViewModel!
    var mockCharsDataManager: MockCharsDataManager!
    
    override func setUp() {
        mockCharsDataManager = MockCharsDataManager()
        viewModel = .init(charsDataManager: mockCharsDataManager)
    }
    
    func testWithNoDataRetrieveEmptyMarvelList() {
        viewModel.viewWasLoaded()
        
        XCTAssertTrue(viewModel.charsViewModels.isEmpty)
    }
}
