//
//  MockCharsDataManager.swift
//  URLSessionExampleTests
//
//  Created by APPLE on 17/03/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//

@testable import URLSessionExample

final class MockCharsDataManager: CharsDataManager {
    func fetchAllChars(completion: @escaping (Result<AllCharsResponse?, Error>) -> ()) {
        let dataList = DataList(total: nil, results: [])
        let response: AllCharsResponse = AllCharsResponse(code: nil, status: nil, copyright: nil, data: dataList)
        
        completion(.success(response))
    }
}
