//
//  FavoritesViewController.swift
//  Adopt-A-Dog
//
//  Created by Þórkatla Eva Víkingsdóttir on 07/05/2020.
//  Copyright © 2020 Þórkatla Eva Víkingsdóttir. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    let homeVC = HomeViewController()
    
    var favoriteDogs: [Dog] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.purple
        for dog in favoriteDogs {
            print(dog)
        }
        print("favorites count: \(favoriteDogs.count)")
        
        

        // Do any additional setup after loading the view.
    }
 
    func handleFavorites(dog: Dog) {
        let detailsVC = DetailsViewController(dog: dog)
        

        if dog.hasFavorited == true {
            detailsVC.favoritesButton.setImage(#imageLiteral(resourceName: "favoritesPink"), for: .normal)
            favoriteDogs.append(dog)
        }else {
            detailsVC.favoritesButton.setImage(#imageLiteral(resourceName: "favorites32"), for: .normal)
        }
        
    }
}
