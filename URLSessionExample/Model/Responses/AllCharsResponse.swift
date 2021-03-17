//
//  AllCharsResponse.swift
//  URLSessionsExample
//
//  Created by APPLE on 11/02/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//

import Foundation

struct AllCharsResponse: Codable {
    let code: Int?
    let status: String?
    let copyright: String?
    var data: DataList
}

struct DataList: Codable {
    let total: Int?
    let results: [Character]
}

struct Character: Codable, Hashable {
    let id: Int?
    let name: String?
    let thumbnail: Thumbnail
}

struct Thumbnail: Codable, Hashable {
    var path: String?
    let imageExtension: String?
    
    enum CodingKeys: String, CodingKey {
        case path
        case imageExtension = "extension"
    }
}


// MARK: Character Extension

extension Character: Equatable {
    static func == (lhs: Character, rhs: Character) -> Bool{
        return lhs.id == rhs.id
    }
}

extension Character: CustomDebugStringConvertible{
    var debugDescription: String{
        return "<\(type(of: self)): \(self.id ?? Int())/\(self.name ?? String())>"
    }
}


// MARK: Thumbnail Extension

extension Thumbnail: Equatable {
    static func == (lhs: Thumbnail, rhs: Thumbnail) -> Bool {
        return lhs.path == rhs.path && lhs.imageExtension == rhs.imageExtension
    }
}

extension Thumbnail: CustomDebugStringConvertible {
    var debugDescription: String{
        return "<\(type(of: self)): \(self.path ?? String())\(self.imageExtension ?? String())>"
    }
}
