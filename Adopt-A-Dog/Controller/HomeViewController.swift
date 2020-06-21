//
//  HomeViewController.swift
//  Adopt-A-Dog
//
//  Created by Þórkatla Eva Víkingsdóttir on 07/05/2020.
//  Copyright © 2020 Þórkatla Eva Víkingsdóttir. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {
    
    let dogsModel = DogsModel()
    let tableView = UITableView()
    let dogCell = DogCell()
    var dog = Dog()
    
    //Search Bar elements
    let searchController = UISearchController(searchResultsController: nil)
    var filteredDogs: [Dog] = []
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configureSearchController()
        setNavigationbar()
        setTableViewDelegates()
        configureTableView()
        getAllDogs()
    }
    
    func setupView() {
        view.backgroundColor = Color.lightGreen()
        view.addSubview(tableView)
    }
    
    func setNavigationbar() {
        let navBar =  navigationController?.navigationBar
        self.navigationItem.title = Title.appName
        navBar?.tintColor = Color.lightGreen()
        navBar?.titleTextAttributes = [NSAttributedString.Key.font: UIFont.Font.strawberry(size: 22)]
    }
    
    func getAllDogs() {
        dogsModel.dogsListener = {
            self.tableView.reloadData()
        }
        dogsModel.getAllDogs()
    }
    
    func filterContentForSearchText(_ searchText: String,
                                    category: Dog? = nil) {
        filteredDogs = dogsModel.dogs.filter { (dog: Dog) -> Bool in
            return (dog.dogBreed?.lowercased().contains(searchText.lowercased()))! || (dog.dogAge?.contains(searchText))! || (dog.dogName?.contains(searchText))!
        }
        tableView.reloadData()
    }
    
    func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = Title.searchPlaceholder
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func configureTableView() {
        self.tableView.pin(to: view)
        self.tableView.backgroundColor = Color.lightGreen()
        self.tableView.register(DogCell.self, forCellReuseIdentifier: Cells.dogCell)
        self.tableView.separatorStyle = .none
    }
    
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredDogs.count
        }
        return dogsModel.dogs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.dogCell)as! DogCell
        if isFiltering {
            let dog = filteredDogs[indexPath.row]
            cell.setDog(dog: dog)
        } else {
            let dog = dogsModel.dogs[indexPath.row]
            cell.setDog(dog: dog)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let dog = dogsModel.dogs[indexPath.row]
        let detailVC = DetailsViewController(dog: dog)
        modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView( _ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) ->   UISwipeActionsConfiguration? {
        let dog = dogsModel.dogs[indexPath.row]
        let favoriteDog = dog.isFavorite
        
        let favoriteAction = UIContextualAction(style: .normal, title: "") { (action, view, completion) in
            
            self.dogsModel.dogs[indexPath.row].isFavorite = !self.dogsModel.dogs[indexPath.row].isFavorite
            
            completion(true)
        }
        
        favoriteAction.image = favoriteDog ? #imageLiteral(resourceName: "favoritesPink") : #imageLiteral(resourceName: "favorites32")
        favoriteAction.backgroundColor = Color.lightGreen()
        
        return UISwipeActionsConfiguration(actions: [favoriteAction])
    }
}

extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
}
