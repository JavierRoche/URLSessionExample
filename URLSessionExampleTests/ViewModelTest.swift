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
    var mockCharsDataManager: MockViewModel!
    
    override func setUp() {
        mockCharsDataManager = MockViewModel()
        viewModel = .init(charsDataManager: mockCharsDataManager)
    }
    
    func testWithNoDataRetrieveEmptyMarvelList() {
        let dataList = DataList(total: nil, results: [])
        let response = AllCharsResponse(code: nil, status: nil, copyright: nil, data: dataList)
        mockCharsDataManager.result = .success(response)
        
        viewModel.viewWasLoaded()
        
        XCTAssertTrue(viewModel.charsViewModels.isEmpty)
    }
    
    func testWithErrorRetrieveError() {
        mockCharsDataManager.result = .failure(NSError(domain: String(), code: -1, userInfo: nil))
        
        viewModel.viewWasLoaded()
        
        XCTAssertNotNil(viewModel.error)
    }
}
