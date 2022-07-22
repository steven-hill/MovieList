//
//  FavouritesListVC.swift
//  MovieList
//
//  Created by Steven Hill on 03/06/2022.
//

import UIKit

protocol FavouritesListVCDelegate {
    var favourites: [String] { get set }
    
    func loadFavourites()
    
    func deleteMovieFromFavourites(name: String)
}

class FavouritesListVC: UIViewController {
   
    var delegate: FavouritesListVCDelegate!
    
    let reuseID = "FavouriteListCell"

    init(delegate: FavouritesListVCDelegate) {
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favourites"
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(tableView)
        tableView.rowHeight = 60
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseID)
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        delegate.loadFavourites()
    }

    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.delegate.loadFavourites()
            self.tableView.reloadData()
        }
    }
}

//MARK: - TableView Data Source Methods

extension FavouritesListVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegate.favourites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = delegate.favourites[indexPath.row]
        cell.contentConfiguration = content
        
        return cell
    }
}


//MARK: - TableView Delegate Methods

extension FavouritesListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            delegate.deleteMovieFromFavourites(name: delegate.favourites[indexPath.row])
            delegate.favourites.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
