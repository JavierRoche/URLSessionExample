//
//  DataManager.swift
//  URLSessionsExample
//
//  Created by APPLE on 16/02/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//

import Foundation

/// El DataManager solo utiliza llamadas remotas, pero podría extenderse para serializar las respuestas, y poder implementar un offline first en el futuro
class DataManager {
    let remoteDataManager: RemoteDataManager

    init(remoteDataManager: RemoteDataManager) {
        self.remoteDataManager = remoteDataManager
    }
}

extension DataManager: CharsDataManager {
    func fetchAllChars(completion: @escaping (Result<AllCharsResponse?, Error>) -> ()) {
        remoteDataManager.fetchAllCharsRemote(completion: completion)
    }
}

extension DataManager: CharDetailDataManager {
    func fetchChar(id: Int, completion: @escaping (Result<SingleCharResponse?, Error>) -> ()) {
        remoteDataManager.fetchCharRemote(id: id, completion: completion)
    }
    
    func fetchCharComics(id: Int, completion: @escaping (Result<CharComicsResponse?, Error>) -> ()) {
        remoteDataManager.fetchCharComicsRemote(id: id, completion: completion)
    }
}
