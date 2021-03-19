//
//  RemoteDataManager.swift
//  URLSessionsExample
//
//  Created by APPLE on 16/02/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//

import Foundation

/// Protocolo que contiene todas las llamadas remotas de la app
protocol RemoteDataManager {
    func fetchAllCharsRemote(completion: @escaping (Result<AllCharsResponse?, Error>) -> ())
    func fetchCharRemote(id: Int, completion: @escaping (Result<SingleCharResponse?, Error>) -> ())
    func fetchCharComicsRemote(id: Int, completion: @escaping (Result<CharComicsResponse?, Error>) -> ())
}
