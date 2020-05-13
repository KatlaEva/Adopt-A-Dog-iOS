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
        favVC.tabBarItem.title = "Favorite"
        favVC.tabBarItem.image = UIImage(named: "favorite")?.withRenderingMode(.alwaysOriginal)
        favVC.tabBarItem.selectedImage = UIImage(named: "favorite_selected")?.withRenderingMode(.alwaysOriginal)
        
        let myAccountVC = MyAccountViewController()
        myAccountVC.tabBarItem.title = "My account"
        myAccountVC.tabBarItem.image = UIImage(named: "account")?.withRenderingMode(.alwaysOriginal)
        myAccountVC.tabBarItem.selectedImage = UIImage(named: "account_selected")?.withRenderingMode(.alwaysOriginal)
        
        let homeVC = HomeViewController()
        homeVC.tabBarItem.title = "Home"
        homeVC.tabBarItem.image = UIImage(named: "home")?.withRenderingMode(.alwaysOriginal)
        homeVC.tabBarItem.selectedImage = UIImage(named: "home_selected")?.withRenderingMode(.alwaysOriginal)
        
        let controllers = [homeVC, favVC, myAccountVC]
        viewControllers = controllers.map {
            UINavigationController(rootViewController: $0)
        }
        
    }
}
