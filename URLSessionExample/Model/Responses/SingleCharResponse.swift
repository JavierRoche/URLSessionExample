//
//  SingleCharResponse.swift
//  URLSessionsExample
//
//  Created by APPLE on 18/02/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//

import Foundation

struct SingleCharResponse: Codable {
    let code: Int?
    let status: String?
    let copyright: String?
    let data: DataList
}
