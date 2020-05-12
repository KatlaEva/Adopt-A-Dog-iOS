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
        favVC.tabBarItem.selectedImage?.withTintColor(Color.creamWhite(), renderingMode: .alwaysOriginal)
        favVC.tabBarItem.title = "Favorite"
        favVC.tabBarItem.image = UIImage(named: "favorite")
        favVC.tabBarItem.selectedImage = UIImage(named: "favorite_selected")
       
        
        let myAccountVC = MyAccountViewController()
        myAccountVC.tabBarItem.title = "My account"
        myAccountVC.tabBarItem.image = UIImage(named: "account")
        myAccountVC.tabBarItem.selectedImage = UIImage(named: "account_selected")
        
        let homeVC = HomeViewController()
        homeVC.tabBarItem.title = "Home"
        homeVC.tabBarItem.image = UIImage(named: "home")
        homeVC.tabBarItem.selectedImage = UIImage(named: "home_selected")
        
        let controllers = [homeVC, favVC, myAccountVC]
        viewControllers = controllers.map {
            UINavigationController(rootViewController: $0)
        }
        
    }
}
