//
//  MovieDetailVC.swift
//  MovieList
//
//  Created by Steven Hill on 24/06/2022.
//

import UIKit

class MovieDetailVC: UIViewController {
    
    let movie: MovieResult

    init(movie: MovieResult) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
