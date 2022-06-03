//
//  MovieListVC.swift
//  MovieList
//
//  Created by Steven Hill on 03/06/2022.
//

import UIKit

class MovieListVC: UIViewController {
    
    var movieName = ""
    var moviesArray: [String] = []
    var movieArtworkArray: [String] = []
    var movieImage = UIImage()
    var movieImages: [UIImage] = []
    var networkManager = NetworkManager()
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Results"
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(tableView)
        
        // Configure tableView
        tableView.rowHeight = 120
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: MovieCell.reuseID)
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        
        fetch(movieName: movieName)
    }
    
    func fetch(movieName: String) {
        
        networkManager.fetch(movieName: movieName) { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let movies):
                DispatchQueue.main.async {
                    var names: [String] = []
                    for result in movies.results {
                        names.append(result.trackName)
                    }
                    self.moviesArray = names
                    print("names is \(names)")
                    
                    var imagesURLs: [String] = []
                    for result in movies.results {
                        imagesURLs.append(result.artworkUrl100)
                    }
                    print(imagesURLs)
                    self.movieArtworkArray = imagesURLs
                    
                    self.tableView.reloadData()
                }
            case .failure(let error):
                let alertController = UIAlertController(title: "\(error)", message: "Please try again.", preferredStyle: .alert)
                let actionTitle = NSLocalizedString("Ok", comment: "")
                alertController.addAction(.init(title: actionTitle, style: .default, handler: nil))
                alertController.present(alertController, animated: true, completion: nil)
                return
            }
        }
    }
}


//MARK: - TableView Data Source Methods

extension MovieListVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.reuseID, for: indexPath)
        
        
        func fetchImage(imageURL: String, completion: @escaping (Swift.Result<UIImage, NetworkManager.FetchError>) -> Void) {
            
            
            guard let finalUrl = URL(string: movieArtworkArray[indexPath.row]) else {
                completion(.failure(NetworkManager.FetchError.invalidURL))
                return
            }
            
            let task = URLSession.shared.dataTask(with: finalUrl) { data, response, error in
                
                guard error == nil else {
                    completion(.failure(NetworkManager.FetchError.network(error!)))
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    completion(.failure(NetworkManager.FetchError.missingResponse))
                    return
                }
                
                guard (200...299).contains(response.statusCode) else {
                    completion(.failure(NetworkManager.FetchError.unexpectedResponse(response.statusCode)))
                    return
                }
                
                guard let receivedData = data else {
                    completion(.failure(NetworkManager.FetchError.invalidData))
                    return
                }
                
                do {
                    guard let image = UIImage(data: receivedData) else { return }
                    DispatchQueue.main.async {
                        self.movieImage = image
                        self.tableView.reloadData()
                    }
                    completion(.success(image))
                } catch {
                    completion(.failure(NetworkManager.FetchError.invalidData))
                }
            }
            task.resume()
        }
        
        func getImage(imageURL: String) {
            
            fetchImage(imageURL: imageURL) { [weak self] result in
                
                guard let self = self else { return } // the reference to self is a weak one which makes it an optional so this line unwraps the optional
                
                switch result {
                case .success(let image):
                    DispatchQueue.main.async {
                        self.movieImage = image
                        self.tableView.reloadData()
                    }
                case .failure(let error):
                    print(error)
                    return
                }
            }
        }
        
        var content = cell.defaultContentConfiguration()
        
        content.text = moviesArray[indexPath.row]
        content.image = movieImage
        
        cell.contentConfiguration = content
        return cell
    }
}


//MARK: - TableView Delegate Methods

extension MovieListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

