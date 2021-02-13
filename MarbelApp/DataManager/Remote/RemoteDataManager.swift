//
//  RemoteDataManager.swift
//  MarbelApp
//
//  Created by APPLE on 10/02/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//

import Foundation

/// Protocolo que contiene todas las llamadas remotas de la app
protocol RemoteDataManager {
    func fetchAllChars(completion: @escaping (Result<AllCharsResponse?, Error>) -> ())
    func fetchChar(id: Int, completion: @escaping (Result<SingleCharResponse?, Error>) -> ())
}
