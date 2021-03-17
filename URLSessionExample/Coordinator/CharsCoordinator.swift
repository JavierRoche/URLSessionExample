//
//  CharsCoordinator.swift
//  URLSessionsExample
//
//  Created by APPLE on 11/02/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//

import UIKit

/// Coordinator que representa la pila de navegacion de la lista de personajes
class CharsCoordinator: Coordinator {
    let presenter: UINavigationController
    let charsDataManager: CharsDataManager
    let charDetailDataManager: CharDetailDataManager
    var charsViewModel: CharsViewModel?
    
    
    // MARK: Life Cycle
    
    init(presenter: UINavigationController,
         charsDataManager: CharsDataManager,
         charDetailDataManager: CharDetailDataManager) {
        self.presenter = presenter
        self.charsDataManager = charsDataManager
        self.charDetailDataManager = charDetailDataManager
    }
    
    
    // MARK: Override Methods
    
    override func start() {
        /// Inicializacion del ViewModel con el manager de datos
        let charsViewModel = CharsViewModel(charsDataManager: self.charsDataManager)
        /// Inicializacion del Controlador con el ViewModel
        let charsViewController = CharsViewController(viewModel: charsViewModel)
        
        charsViewController.title = Constants.appTitle
        self.presenter.navigationBar.backgroundColor = .white
        
        /// Indicamos al ViewModel que el delegado de eventos de navegacion sera el mismo Coordinator
        charsViewModel.coordinatorDelegate = self
        /// Indicamos al Viewmodel que el delegado del trabajo con la UI sera el Controlador
        charsViewModel.delegate = charsViewController
        
        /// Asignamos el ViewModel y presentamos el controlador
        self.charsViewModel = charsViewModel
        self.presenter.pushViewController(charsViewController, animated: false)
    }
    
    override func finish() {}
}


// MARK: CharsViewModelCoordinator Delegate

extension CharsCoordinator: CharsViewModelCoordinatorDelegate {
    func didSelect(char: Character) {
        /// Inicializacion del ViewModel con el manager de datos y el id del personaje
        guard let charId = char.id else { return }
        let charDetailViewModel = CharDetailViewModel(charId: charId, charDetailDataManager: self.charDetailDataManager)
        /// Inicializacion del Controlador con el ViewModel
        let charDetailViewController = CharDetailViewController(viewModel: charDetailViewModel)
        
        /// Indicamos al Viewmodel que el delegado del trabajo con la UI sera el Controlador
        charDetailViewModel.delegate = charDetailViewController
        self.presenter.pushViewController(charDetailViewController, animated: true)
    }
}
