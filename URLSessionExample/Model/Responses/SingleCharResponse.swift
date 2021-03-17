//
//  SingleCharResponse.swift
//  URLSessionsExample
//
//  Created by APPLE on 11/02/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//

import Foundation

struct SingleCharResponse: Codable {
    let code: Int?
    let status: String?
    let copyright: String?
    let data: DataList
}
