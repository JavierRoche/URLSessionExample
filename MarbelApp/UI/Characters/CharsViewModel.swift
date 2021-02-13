//
//  CharsViewModel.swift
//  MarbelApp
//
//  Created by APPLE on 11/02/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//

import UIKit

/// Protocolo delegado de comunicacion para las acciones de usuario y su navegacion
protocol CharsViewModelCoordinatorDelegate: class {
    func didSelect(char: Character)
}

/// Protocolo delegado de comunicacion con el controlador de la UI
protocol CharsViewModelDelegate: class {
    func charsFetched()
    func errorFetchingChars()
}

/// ViewModel que representa el listado de personajes
class CharsViewModel {
    /// Delegados de comunicacion
    weak var coordinatorDelegate: CharsViewModelCoordinatorDelegate?
    weak var delegate: CharsViewModelDelegate?
    
    /// Objeto para el acceso al protocolo de manejo de datos
    let charsDataManager: CharsDataManager
    /// Lista de modelos de personaje
    var charsViewModels: [CharCellViewModel] = []
    
    
    // MARK: Life Cycle
    
    init(charsDataManager: CharsDataManager) {
        /// El ViewModel guarda la referencia del manager para pedirle datos
        self.charsDataManager = charsDataManager
    }
    
    
    // MARK: Public Functions
    
    func viewWasLoaded() {
        self.charsDataManager.fetchAllChars { [weak self] (result) in
            switch result {
            case .success(let response):
                guard let response = response else { return }
                /// Mapeamos el JSON de datos al modelo de datos
                self?.charsViewModels = response.data.results.map({
                    CharCellViewModel(char: $0)
                })
                /// Informamos al controlador que hemos leido todos los datos
                self?.delegate?.charsFetched()
                
            case .failure:
                self?.delegate?.errorFetchingChars()
            }
        }
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows(in section: Int) -> Int {
        return charsViewModels.count
    }
    
    func heightOfRow() -> CGFloat {
        return 80.0
    }
    
    func charModel(at indexpath: IndexPath) -> CharCellViewModel? {
        guard indexpath.row < charsViewModels.count else { return nil }
        return charsViewModels[indexpath.row]
    }
    
    func didSelectRow(at indexpath: IndexPath) {
        /// El ViewModel se lo comunica al Coordinator para que decida la navegacion
        guard indexpath.row < charsViewModels.count else { return }
        coordinatorDelegate?.didSelect(char: self.charsViewModels[indexpath.row].char)
    }
}
