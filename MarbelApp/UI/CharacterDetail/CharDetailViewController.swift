//
//  CharDetailViewController.swift
//  MarbelApp
//
//  Created by APPLE on 12/02/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//

import UIKit

/// ViewModel que representa el personaje seleccionado
class CharDetailViewController: UIViewController {
    /// Objeto para el ViewModel
    let viewModel: CharDetailViewModel
    
    lazy var backgroundView: UIView = {
        let view: UIView = UIView(frame: self.view.bounds)
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    /// Tabla que contiene la lista de personajes
    lazy var imageView: UIImageView = {
        let image: UIImageView = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var nameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.fontStyle28Bold
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    // MARK: Life Cycle
    
    init(viewModel: CharDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constants.NSCoderError)
    }
    
    override func loadView() {
        view = UIView()
        
        view.addSubview(backgroundView)
        view.addSubview(imageView)
        view.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32.0),
            imageView.widthAnchor.constraint(equalToConstant: 350.0),
            imageView.heightAnchor.constraint(equalToConstant: 350.0),
            imageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 32.0),
            nameLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = .black
        viewModel.viewWasLoaded()
    }
}


// MARK: CharsDetailViewModel Delegate

extension CharDetailViewController: CharsDetailViewModelDelegate {
    func charFetched() {
        imageView.image = viewModel.char?.charImage
        nameLabel.text = viewModel.char?.char.name
    }
    
    func errorFetchingChar(message: String) {
        showAlert(message: message, title: Constants.error)
    }
}
