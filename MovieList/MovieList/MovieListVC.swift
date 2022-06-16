//
//  MovieListVC.swift
//  MovieList
//
//  Created by Steven Hill on 03/06/2022.
//

import UIKit

protocol MovieListVCDelegate {
    var movieNames: [String] { get }

    var movieImages: [UIImage] { get }

    func viewDidAppear()

    func fetchImageForMovie(at position: Int,
                            completionHandler: @escaping (Swift.Result<UIImage, Error>) -> Void)
}

class MovieListVC: UIViewController {

    let delegate: MovieListVCDelegate!

    init(delegate: MovieListVCDelegate) {
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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

        showLoadingView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        delegate.viewDidAppear()
    }

    func updateUI() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            if self.delegate.movieNames.count > 0 {
                self.dismissLoadingView()
            }
        }
    }
}
     

//MARK: - TableView Data Source Methods

extension MovieListVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegate.movieNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.reuseID, for: indexPath)

        let movieNames = delegate.movieNames

        var content = cell.defaultContentConfiguration()
        content.text = movieNames[indexPath.row]

        delegate.fetchImageForMovie(at: indexPath.row) { imageFetchResult in
            DispatchQueue.main.async {
                guard case .success(let imageFromFetch) = imageFetchResult else {
                    content.image = UIImage(systemName: "photo")
                    return
                }
                content.image = imageFromFetch
            }
        }
        
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

