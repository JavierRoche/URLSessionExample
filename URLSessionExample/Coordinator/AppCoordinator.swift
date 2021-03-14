//
//  AppCoordinator.swift
//  MarbelApp
//
//  Created by APPLE on 10/02/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//

import UIKit

/// Coordinador principal de la App, que encapsula todas las interacciones con la Window
class AppCoordinator: Coordinator {
    /// Representa la variable de clase que contiene la sesion API
    let sessionAPI = APISession()
    let window: UIWindow
    
    lazy var remoteDataManager: RemoteDataManager = {
        let remoteData = RemoteData(session: sessionAPI)
        return remoteData
    }()
        
    lazy var dataManager: DataManager = {
        let dataManager = DataManager(remoteDataManager: self.remoteDataManager)
        return dataManager
    }()
    
    
    // MARK: Life Cycle
    
    init(window: UIWindow) {
        self.window = window
    }
    
    
    // MARK: Override Methods
    
    override func start() {
        /// Añadiremos coordinadores segun añadamos tabs a la App
        let charsNavigationController = UINavigationController()
        let charsCoordinator = CharsCoordinator(presenter: charsNavigationController, charsDataManager: self.dataManager, charDetailDataManager: self.dataManager)
        
        /// Añadimos el coordinator a la clase base Coordinator
        self.addCoordinator(coordinator: charsCoordinator)
        charsCoordinator.start()
        
        /// Configuramos minimamente la UI
        let tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = .black
        tabBarController.tabBar.isTranslucent = false
        tabBarController.viewControllers = [charsNavigationController]
        tabBarController.tabBar.items?.first?.image = UIImage(systemName: Constants.listDashIS)

        /// Enrutamos la window y la hacemos visible
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
    
    override func finish() {}
}
