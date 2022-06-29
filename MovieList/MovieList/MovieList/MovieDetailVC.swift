//
//  MovieDetailVC.swift
//  MovieList
//
//  Created by Steven Hill on 24/06/2022.
//

import UIKit
import AVKit
import AVFoundation

class MovieDetailVC: UIViewController {
    
    let movie: MovieResult
    
    var playerContainerView: UIView!
    
    var playerView: UIView!

    init(movie: MovieResult) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUpPlayerContainerView()
        setUpPlayerView()
        setUpPlayButton()
    }

    private func setUpPlayerContainerView() {
        playerContainerView = UIView()
        view.addSubview(playerContainerView)
        playerContainerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playerContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            playerContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            playerContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
            playerContainerView.topAnchor.constraint(equalTo: view.topAnchor)
        ])
    }
    
    private func setUpPlayerView() {
        playerView = UIView()
        playerView.backgroundColor = .black
        playerContainerView.addSubview(playerView)
        playerView.addSubview(playButton)
        playerView.bringSubviewToFront(playButton)
        playerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playerView.leadingAnchor.constraint(equalTo: playerContainerView.leadingAnchor),
            playerView.trailingAnchor.constraint(equalTo: playerContainerView.trailingAnchor),
            playerView.heightAnchor.constraint(equalTo: playerContainerView.heightAnchor, multiplier: 16/9),
            playerView.centerYAnchor.constraint(equalTo: playerContainerView.centerYAnchor)
        ])
    }
 
    private let playButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func playButtonTapped() {
        playVideo()
    }
    
    func playVideo() {
        guard let url = URL(string: movie.previewUrl) else { return }
        let player = AVPlayer(url: url)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
        playerViewController.exitsFullScreenWhenPlaybackEnds = true
    }
    
    func setUpPlayButton() {
        playButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playButton.centerYAnchor.constraint(equalTo: playerView.centerYAnchor, constant: 50),
            playButton.centerXAnchor.constraint(equalTo: playerView.centerXAnchor),
            playButton.heightAnchor.constraint(equalToConstant: 100),
            playButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
}
