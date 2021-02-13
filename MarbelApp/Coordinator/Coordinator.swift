//
//  Coordinator.swift
//  MarbelApp
//
//  Created by APPLE on 10/02/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//

import Foundation

/// Clase base de todo coordinator. Los hijos deben implementar obligatoriamente start() y finish()
class Coordinator {
    /// Array con todos los Coordinators de la App
    fileprivate var coordinatorChild: [Coordinator] = []
    
    func start() {
        preconditionFailure(Constants.preconditionFailure)
    }

    func finish() {
        preconditionFailure(Constants.preconditionFailure)
    }
    
    func addCoordinator(coordinator: Coordinator) {
        coordinatorChild.append(coordinator)
    }

    func removeCoordinator(coordinator: Coordinator) {
        if let index = coordinatorChild.firstIndex(of: coordinator) {
            coordinatorChild.remove(at: index)
            
        } else {
            print("Couldn't remove coordinator: \(coordinator). It's not a child coordinator.")
        }
    }

    func removeAllChildCoordinators() {
        coordinatorChild.removeAll()
    }
}

extension Coordinator: Equatable {
    static func == (lhs: Coordinator, rhs: Coordinator) -> Bool {
        return lhs === rhs
    }
}
