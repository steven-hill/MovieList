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
        
        guard isTextEntered == true else { // text validation - did the user enter a username?
            let alertController = UIAlertController(title: "A movie name hasn't been entered", message: "Please enter a movie name.", preferredStyle: .alert)
            let actionTitle = NSLocalizedString("Ok", comment: "")
            alertController.addAction(.init(title: actionTitle, style: .default, handler: nil))
            alertController.present(alertController, animated: true, completion: nil)
            return
        }
        // Yes, a username was entered, so continue
        let movieListVC = MovieListVC() // create the object
        
        let movieNameEntered = searchTextField.text!
        var finalMovieName = movieNameEntered
        
        if movieNameEntered.contains(" ") {
            finalMovieName = movieNameEntered.replacingOccurrences(of: " ", with: "+")
        }
        
        movieListVC.title = "Results"
        movieListVC.movieName = finalMovieName
        navigationController?.pushViewController(movieListVC, animated: true)
    }
}

extension SearchVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushMovieListVC()
        return true
    }
}

