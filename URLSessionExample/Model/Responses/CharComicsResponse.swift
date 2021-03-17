//
//  CharComicsResponse.swift
//  URLSessionsExample
//
//  Created by APPLE on 14/02/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//

import Foundation

struct CharComicsResponse: Codable {
    let code: Int?
    let status: String?
    let copyright: String?
    let data: CoverList
}

struct CoverList: Codable {
    let results: [Comic]
}

struct Comic: Codable, Hashable {
    let id: Int?
    let name: String?
    let thumbnail: Thumbnail
}


// MARK: Comic Extension

extension Comic: Equatable {
    static func == (lhs: Comic, rhs: Comic) -> Bool{
        return lhs.id == rhs.id
    }
}

extension Comic: CustomDebugStringConvertible{
    var debugDescription: String{
        return "<\(type(of: self)): \(self.id ?? Int())/\(self.name ?? String())>"
    }
}
