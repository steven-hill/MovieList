//
//  SearchVC.swift
//  MovieList
//
//  Created by Steven Hill on 03/06/2022.
//

import UIKit

class SearchVC: UIViewController {
   
    let searchTextField = TextField()
    
    var isTextEntered: Bool {
        return !searchTextField.text!.isEmpty
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Configure TextField()
        view.addSubview(searchTextField)
        searchTextField.delegate = self
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: view.centerYAnchor),
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            searchTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // Configure keyboard gesture
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }

    func pushMovieListVC() {
        
        guard isTextEntered else {
            DispatchQueue.main.async {
                let alertController = UIAlertController(title: "A movie name hasn't been entered", message: "Please enter a movie name.", preferredStyle: .alert)
                let actionTitle = NSLocalizedString("Ok", comment: "")
                alertController.addAction(.init(title: actionTitle, style: .default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }
            return
        }
        
        // Prepare user query.
        let userQueryText = searchTextField.text!
        var userQueryPreparedString = userQueryText
        if userQueryText.contains(" ") {
            userQueryPreparedString = userQueryText.replacingOccurrences(of: " ", with: "+")
        }

        // Push MovieListVC.
        let movieListCoordinator = MovieListCoordinator(userQueryString: userQueryPreparedString)
        let movieListVC = MovieListVC(delegate: movieListCoordinator)
        movieListCoordinator.movieController = movieListVC

        movieListVC.title = "Results"
        navigationController?.pushViewController(movieListVC, animated: true)
    }
}

extension SearchVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushMovieListVC()
        searchTextField.text = ""
        return true
    }
}

