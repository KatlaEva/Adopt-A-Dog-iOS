//
//  MainTabBarViewController.swift
//  Adopt-A-Dog
//
//  Created by Þórkatla Eva Víkingsdóttir on 07/05/2020.
//  Copyright © 2020 Þórkatla Eva Víkingsdóttir. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    func setupTabBar() {
        let favVC = FavoritesViewController()
        favVC.tabBarItem.title = Title.favorite
        favVC.tabBarItem.image = UIImage(named: Image.favorite)?.withRenderingMode(.alwaysOriginal)
        favVC.tabBarItem.selectedImage = UIImage(named: Image.favoriteSelected)?.withRenderingMode(.alwaysOriginal)
        
        let myAccountVC = MyAccountViewController()
        myAccountVC.tabBarItem.title = Title.myAccount
        myAccountVC.tabBarItem.image = UIImage(named: Image.account)?.withRenderingMode(.alwaysOriginal)
        myAccountVC.tabBarItem.selectedImage = UIImage(named: Image.accountSelected)?.withRenderingMode(.alwaysOriginal)
        
        let homeVC = HomeViewController()
        homeVC.tabBarItem.title = Title.home
        homeVC.tabBarItem.image = UIImage(named: Image.home)?.withRenderingMode(.alwaysOriginal)
        homeVC.tabBarItem.selectedImage = UIImage(named: Image.homeSelected)?.withRenderingMode(.alwaysOriginal)
        
        let controllers = [homeVC, favVC, myAccountVC]
        viewControllers = controllers.map {
            UINavigationController(rootViewController: $0)
        }
    }
}
