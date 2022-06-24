//
//  MovieCell.swift
//  MovieList
//
//  Created by Steven Hill on 03/06/2022.
//

import UIKit

class MovieCell: UITableViewCell {

    static let reuseID = "MovieCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let movieImage: UIImageView = {
        let movieImage = UIImageView()
        movieImage.image = UIImage(systemName: "photo")
        movieImage.contentMode = .scaleAspectFit
        movieImage.layer.cornerRadius = 10
        movieImage.clipsToBounds = true
        return movieImage
    }()
    
    private let movieName: UILabel = {
        let movieName = UILabel()
        movieName.font = UIFont.boldSystemFont(ofSize: 16)
        movieName.textAlignment = .left
        movieName.text = ""
        movieName.numberOfLines = 1
        movieName.adjustsFontSizeToFitWidth = true
        return movieName
    }()
    
    private func configure() {
        addSubview(movieImage)
        addSubview(movieName)
        
        movieImage.translatesAutoresizingMaskIntoConstraints = false
        movieName.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            movieImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            movieName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            movieImage.heightAnchor.constraint(equalToConstant: 100),
            movieImage.widthAnchor.constraint(equalToConstant: 67),
            
            movieName.centerYAnchor.constraint(equalTo: centerYAnchor),
            movieName.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: 20),
            movieName.heightAnchor.constraint(equalToConstant: 80),
            movieName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding)
        ])
    }
}
