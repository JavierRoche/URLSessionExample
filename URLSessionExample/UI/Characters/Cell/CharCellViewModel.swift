//
//  CharCellViewModel.swift
//  URLSessionsExample
//
//  Created by APPLE on 18/02/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//

import UIKit

protocol CharCellViewModelDelegate: class {
    func charImageFetched()
}

/// ViewModel que representa un personaje
class CharCellViewModel {
    /// Delegado para comunicar la tarea asincrona finalizada al controlador
    weak var delegate: CharCellViewModelDelegate?
    let char: Character
    var charImage: UIImage?
    
    init(char: Character) {
        self.char = char
        
        /// Obtenemos la imagen del personaje
        let http = "\(self.char.thumbnail.path!)/standard_large.\(self.char.thumbnail.imageExtension!)"
        let imageURL = Constants.https + http.dropFirst(4)
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            if let url = URL(string: imageURL), let data = try? Data(contentsOf: url) {
                self?.charImage = UIImage(data: data)
                DispatchQueue.main.async {
                    self?.delegate?.charImageFetched()
                }
            }
        }
    }
}
