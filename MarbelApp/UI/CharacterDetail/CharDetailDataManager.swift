//
//  CharDetailDataManager.swift
//  MarbelApp
//
//  Created by APPLE on 11/02/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//

import Foundation

/// Data Manager con las funcionalidades necesarias de este modulo
protocol CharDetailDataManager {
    func fetchChar(id: Int, completion: @escaping (Result<SingleCharResponse?, Error>) -> ())
}