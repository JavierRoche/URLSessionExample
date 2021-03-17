//
//  CharCell.swift
//  URLSessionsExample
//
//  Created by APPLE on 11/02/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//

import UIKit

/// Celda que representa un character de la lista
class CharCell: UITableViewCell {
    var viewModel: CharCellViewModel? {
        didSet {
            guard let viewModel = self.viewModel else { return }
            /// Para recibir el fin del hilo asincrono de descarga de la imagen
            viewModel.delegate = self
            
            self.imageView?.layer.cornerRadius = 8.0
            self.imageView?.clipsToBounds = true
            self.textLabel?.font = UIFont.fontStyle22SemiBold
            self.textLabel?.text = viewModel.char.name
            self.imageView?.image = viewModel.charImage
        }
    }
}


// MARK: CharCellViewModel Delegate

extension CharCell: CharCellViewModelDelegate {
    func charImageFetched() {
        guard let viewModel = self.viewModel else { return }
        self.imageView?.image = viewModel.charImage
        setNeedsLayout()
    }
}
