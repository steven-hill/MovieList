//
//  MovieListVC.swift
//  MovieList
//
//  Created by Steven Hill on 03/06/2022.
//

import UIKit

protocol MovieListVCDelegate {
    var movies: [MovieResult] { get set }

    var movieImages: [Int: UIImage] { get set }

    func viewDidAppear()

    func fetchImageForMovie(at position: Int) async throws -> UIImage

    func didSelectRow(at: Int)
}

class MovieListVC: UIViewController {

    var delegate: MovieListVCDelegate!

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
            if self.delegate.movies.count > 0 {
                self.dismissLoadingView()
            }
        }
    }
}
     

//MARK: - TableView Data Source Methods

extension MovieListVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegate.movies.count
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if delegate.movieImages[indexPath.row] == nil {
            Task {
                do {
                    let imageForMovie = try await delegate.fetchImageForMovie(at: indexPath.row)
                    delegate.movieImages[indexPath.row] = imageForMovie
                    tableView.reloadRows(at: [indexPath], with: .automatic)
                }
            }
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.reuseID, for: indexPath)

        var content = cell.defaultContentConfiguration()
        content.text = delegate.movies[indexPath.row].trackName
        content.image = delegate.movieImages[indexPath.row] ?? UIImage(systemName: "photo")
        cell.contentConfiguration = content
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}


//MARK: - TableView Delegate Methods

extension MovieListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate.didSelectRow(at: indexPath.row)
    }
}
