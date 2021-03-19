//
//  ComicCell.swift
//  URLSessionsExample
//
//  Created by APPLE on 17/02/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//

import UIKit

/// Celda que representa un comic de la lista
class ComicCell: UICollectionViewCell {
    lazy var imageView: UIImageView = {
        let image: UIImageView = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var viewModel: ComicCellViewModel? {
        didSet {
            guard let viewModel = self.viewModel else { return }
            /// Para recibir el fin del hilo asincrono de descarga de la imagen
            viewModel.delegate = self
            
            imageView.layer.cornerRadius = 8.0
            imageView.clipsToBounds = true
            imageView.image = viewModel.comicImage
            
            self.setConstraints()
        }
    }
        
        
    // MARK: Private Functions
        
    fileprivate func setConstraints() {
        contentView.addSubview(imageView)
            
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}


// MARK: CharCellViewModel Delegate

extension ComicCell: ComicCellViewModelDelegate {
    func comicImageFetched() {
        guard let viewModel = self.viewModel else { return }
        imageView.image = viewModel.comicImage
        setNeedsLayout()
    }
}

