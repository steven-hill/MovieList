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
        //view.addSubview(searchTextField)
        navigationController?.navigationBar.prefersLargeTitles = true
        configureTextField()
        //searchTextField.delegate = self
        createDismissKeyboardTapGesture()
    }

    
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    
    func configureTextField() {
        
        view.addSubview(searchTextField)
        
        // we have to set the delegate in configureTextField(); see extension below
        searchTextField.delegate = self // self = searchVC
        
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: view.centerYAnchor),
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            searchTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // this is called when the user taps "Search" on the keyboard
    // replace spaces with '+' for the API
    // it passes data (the text in the textfield)
    // use a guard statement for text validation - if username is valid, then continue and push the view controller
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
        
        // replace spaces with '+' if there are any for the API
        let movieNameEntered = searchTextField.text!
        var finalMovieName: String = movieNameEntered
        
        if movieNameEntered.contains(" ") {
            finalMovieName = movieNameEntered.replacingOccurrences(of: " ", with: "+")
        }
        print(finalMovieName)
        movieListVC.title = "Results"
        movieListVC.movieName = finalMovieName // the text the user entered with the spaces replaced by '+' is the data to be passed
        //movieListVC.title = usernameTextField.text // the title of the view controller; this will appear in the top nav bar
        navigationController?.pushViewController(movieListVC, animated: true) // navigation controller pushes followerListVC onto the stack
    }
    
}

extension SearchVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushMovieListVC()
        return true
    }
}

