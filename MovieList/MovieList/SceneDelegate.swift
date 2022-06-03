//
//  SceneDelegate.swift
//  MovieList
//
//  Created by Steven Hill on 25/05/2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds) // make it fill the whole screen
        window?.windowScene = windowScene // every window has a windowScene. Assign the window to the above windowScene
        window?.rootViewController = TabBarController() // TabBarController is the initial VC
        window?.makeKeyAndVisible() // shows the window
    }
}

