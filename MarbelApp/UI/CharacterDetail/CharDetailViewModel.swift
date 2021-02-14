//
//  CharDetailViewModel.swift
//  MarbelApp
//
//  Created by APPLE on 12/02/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//

import Foundation

protocol CharsDetailViewModelDelegate: class {
    func charFetched()
    func errorFetchingChar(message: String)
}

class CharDetailViewModel {
    /// Delegados de comunicacion
    weak var delegate: CharsDetailViewModelDelegate?
    
    /// Objeto para el acceso al protocolo de manejo de datos
    let charDetailDataManager: CharDetailDataManager
    /// Id del personaje seleccionado
    let charId: Int
    var char: CharCellViewModel?
    
    
    // MARK: Life Cycle
    
    init(charId: Int, charDetailDataManager: CharDetailDataManager) {
        /// El ViewModel guarda la referencia del manager para pedirle datos y el Id del personaje
        self.charDetailDataManager = charDetailDataManager
        self.charId = charId
        self.char = nil
    }
    
    
    // MARK: Public Functions
    
    func viewWasLoaded() {
        self.charDetailDataManager.fetchChar(id: self.charId) { [weak self] (result) in
            switch result {
            case .success(let response):
                guard let response = response else { return }
                /// Mapeamos el JSON de datos al modelo de datos
                self?.char = CharCellViewModel(char: response.data.results[0])
                self?.char?.delegate = self
                
            case .failure(let error):
                if let errorType = error as? ApiError {
                    let message = ("Code\(errorType.code ?? String())\n\(errorType.message ?? String())")
                    self?.delegate?.errorFetchingChar(message: message)
                    
                } else {
                    self?.delegate?.errorFetchingChar(message: error.localizedDescription)
                }
            }
        }
    }
}


// MARK: CharCellViewModel Delegate

extension CharDetailViewModel: CharCellViewModelDelegate {
    func charImageFetched() {
        /// Informamos al controlador que hemos leido todos los datos
        self.delegate?.charFetched()
    }
}
