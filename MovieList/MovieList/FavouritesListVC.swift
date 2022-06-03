//
//  FavouritesListVC.swift
//  MovieList
//
//  Created by Steven Hill on 03/06/2022.
//

import UIKit

class FavouritesVC: UIViewController {
    
    let tableView = UITableView()
    
    // dummy data
    var array: [String] = ["Shawshank Redemption", "Star Wars: Return of the Jedi", "The Batman", "Gravity"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
    }

}

//MARK: - TableView Data Source Methods

extension FavouritesVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // get the configuration
        var content = cell.defaultContentConfiguration()
        
        // configure content
        content.text = array[indexPath.row]
        
        
        // assign content to the view as the current content configuration
        cell.contentConfiguration = content
        
        return cell
    }
    
}


//MARK: - TableView Delegate Methods

extension FavouritesVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
