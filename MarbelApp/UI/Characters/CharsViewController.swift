//
//  CharsViewController.swift
//  MarbelApp
//
//  Created by APPLE on 11/02/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//

import UIKit

class CharsViewController: UIViewController {
    /// Objeto para el ViewModel
    let viewModel: CharsViewModel
    
    /// Tabla que contiene la lista de personajes
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: UITableView.Style.grouped)
        table.register(CharCell.self, forCellReuseIdentifier: String(describing: CharCell.self))
        table.dataSource = self
        table.delegate = self
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    
    // MARK: Life Cycle
    
    init(viewModel: CharsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = UIView()
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.viewWasLoaded()
    }
}


// MARK: UICollectionView Delegate

extension CharsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        /// Al tappear una celda lo comunicamos al ViewModel
        self.viewModel.didSelectRow(at: indexPath)
    }
}


// MARK: UICollectionView DataSource

extension CharsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.viewModel.heightOfRow()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CharCell.self), for: indexPath) as? CharCell else {
            fatalError()
        }
        
        cell.viewModel = viewModel.charModel(at: indexPath)
        return cell
    }
}


// MARK: CharsViewModel Delegate

extension CharsViewController: CharsViewModelDelegate {
    func charsFetched() {
        self.tableView.reloadData()
    }
    
    func errorFetchingChars() {
        self.showAlert(message: Constants.fetchingError, title: Constants.error)
    }
}
