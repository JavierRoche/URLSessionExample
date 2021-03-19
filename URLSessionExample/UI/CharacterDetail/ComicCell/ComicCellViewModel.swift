//
//  ComicCellViewModel.swift
//  URLSessionsExample
//
//  Created by APPLE on 17/02/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//

import UIKit

protocol ComicCellViewModelDelegate: class {
    func comicImageFetched()
}

/// ViewModel que representa un comic
class ComicCellViewModel {
    /// Delegado para comunicar la tarea asincrona finalizada al controlador
    weak var delegate: ComicCellViewModelDelegate?
    let comic: Comic
    var comicImage: UIImage?
    
    init(comic: Comic) {
        self.comic = comic
        
        /// Obtenemos la imagen del comic
        let http = "\(self.comic.thumbnail.path!)/standard_large.\(self.comic.thumbnail.imageExtension!)"
        let imageURL = Constants.https + http.dropFirst(4)
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            if let url = URL(string: imageURL), let data = try? Data(contentsOf: url) {
                self?.comicImage = UIImage(data: data)
                DispatchQueue.main.async {
                    self?.delegate?.comicImageFetched()
                }
            }
        }
    }
}

