//
//  CharDetailViewController.swift
//  URLSessionsExample
//
//  Created by APPLE on 19/02/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//

import UIKit

/// ViewModel que representa el personaje seleccionado
class CharDetailViewController: UIViewController {
    lazy var backgroundView: UIView = {
        let view: UIView = UIView(frame: self.view.bounds)
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
    
    lazy var flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100.0, height: 100.0)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 4.0
        return layout
    }()

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(ComicCell.self, forCellWithReuseIdentifier: String(describing: ComicCell.self))
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    let viewModel: CharDetailViewModel
    
    
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
        view.addSubview(collectionView)
        
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
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 32.0),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32.0),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32.0),
            collectionView.heightAnchor.constraint(equalToConstant: 100.0),
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = .black
        viewModel.viewWasLoaded()
    }
}


// MARK: UICollectionView DataSource

extension CharDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfComics(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ComicCell.self), for: indexPath) as? ComicCell else {
            fatalError()
        }
        
        cell.viewModel = viewModel.comicModel(at: indexPath)
        return cell
    }
}


// MARK: CharsDetailViewModel Delegate

extension CharDetailViewController: CharsDetailViewModelDelegate {
    func charFetched() {
        imageView.image = viewModel.char?.charImage
        nameLabel.text = viewModel.char?.char.name
    }
    
    func charComicsFetched() {
        collectionView.reloadData()
    }
    
    func errorFetchingChar(message: String) {
        showAlert(message: message, title: Constants.error)
    }
    
    func errorFetchingCharComics(message: String) {
        showAlert(message: message, title: Constants.error)
    }
}
