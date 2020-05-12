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
        favVC.tabBarItem.selectedImage = UIImage(named: "favorite_selected")
        
        let myAccountVC = MyAccountViewController()
        myAccountVC.tabBarItem.title = "My account"
        myAccountVC.tabBarItem.selectedImage = UIImage(named: "account_selected")
        
        let homeVC = HomeViewController()
        homeVC.tabBarItem.title = "Home"
        
        
        viewControllers = [homeVC, favVC, myAccountVC]
    }
}
