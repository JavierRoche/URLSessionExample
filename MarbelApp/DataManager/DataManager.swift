//
//  DataManager.swift
//  MarbelApp
//
//  Created by APPLE on 10/02/2021.
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
        remoteDataManager.fetchAllChars(completion: completion)
    }
}

extension DataManager: CharDetailDataManager {
    func fetchChar(id: Int, completion: @escaping (Result<SingleCharResponse?, Error>) -> ()) {
        remoteDataManager.fetchChar(id: id, completion: completion)
    }
}
