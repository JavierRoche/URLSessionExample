//
//  SingleCharRequest.swift
//  URLSessionsExample
//
//  Created by APPLE on 11/02/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//

import Foundation

/// Implementación de la request que obtiene un personaje
struct SingleCharRequest: APIRequest {
    typealias Response = SingleCharResponse
    
    let id: Int
    
    init(id: Int) {
        self.id = id
    }
    
    var method: Method {
        return .GET
    }
    
    var path: String {
        return "\(Constants.path)/\(self.id)"
    }
    
    var parameters: [String : String] {
        var params: [String : String] = [:]
        params[Constants.ts] = Constants.tsValue
        params[Constants.apikey] = Constants.apikeyValue
        params[Constants.hash] = Constants.hashValue
        return params
    }
}
