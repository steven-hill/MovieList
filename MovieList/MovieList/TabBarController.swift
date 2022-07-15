//
//  TabBarController.swift
//  MovieList
//
//  Created by Steven Hill on 03/06/2022.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemPurple
        viewControllers = [createSearchVC(), createFavouritesListVC()]
    }
    
    func createSearchVC() -> UINavigationController {
        let searchVC = SearchVC()
        searchVC.title = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        return UINavigationController(rootViewController: searchVC)
    }
    
    func createFavouritesListVC() -> UINavigationController {
        let favouritesCoordinator = FavouritesCoordinator()
        let favouritesListVC = FavouritesListVC(delegate: favouritesCoordinator)
        favouritesListVC.title = "Favourites"
        favouritesListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        return UINavigationController(rootViewController: favouritesListVC)
    }
}
