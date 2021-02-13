//
//  RemoteData.swift
//  MarbelApp
//
//  Created by APPLE on 11/02/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//

import Foundation

class RemoteData: RemoteDataManager {
    let session: APISession
    
    init(session: APISession) {
        self.session = session
    }
    
    
    // MARK: Functions
    
    func fetchAllChars(completion: @escaping (Result<AllCharsResponse?, Error>) -> ()) {
        let request = AllCharsRequest()
        self.session.sendRequest(request: request) { (result) in
            completion(result)
        }
    }
    
    func fetchChar(id: Int, completion: @escaping (Result<SingleCharResponse?, Error>) -> ()) {
        let request = SingleCharRequest(id: id)
        self.session.sendRequest(request: request) { (result) in
            completion(result)
        }
    }
}
