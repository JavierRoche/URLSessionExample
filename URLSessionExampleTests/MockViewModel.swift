//
//  MockCharsDataManager.swift
//  URLSessionExampleTests
//
//  Created by APPLE on 17/03/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//

@testable import URLSessionExample

final class MockViewModel: CharsDataManager {
    
    var result: Result<AllCharsResponse?, Error>!// = .success(response)
    
    func fetchAllChars(completion: @escaping (Result<AllCharsResponse?, Error>) -> ()) {
        
        completion(result)
    }
}
