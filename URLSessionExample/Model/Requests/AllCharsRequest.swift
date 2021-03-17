//
//  AllCharsRequest.swift
//  URLSessionsExample
//
//  Created by APPLE on 11/02/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//

import Foundation

/// Implementación de la request que obtiene todos los personajes
struct AllCharsRequest: APIRequest {
    typealias Response = AllCharsResponse
    
    var method: Method {
        return .GET
    }
    
    var path: String {
        return Constants.path
    }
    
    var parameters: [String : String] {
        var params: [String : String] = [:]
        params[Constants.ts] = Constants.tsValue
        params[Constants.apikey] = Constants.apikeyValue
        params[Constants.hash] = Constants.hashValue
        return params
    }
}
