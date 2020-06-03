//
//  MyDogsViewController.swift
//  Adopt-A-Dog
//
//  Created by Þórkatla Eva Víkingsdóttir on 12/05/2020.
//  Copyright © 2020 Þórkatla Eva Víkingsdóttir. All rights reserved.
//

import UIKit
import Firebase

class MyDogsViewController: UIViewController {
    
    let dogsModel = DogsModel()
    let dogCell = DogCell()
    let myDogsView = MyDogsView()
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configureNavBar()
        showCurrentUsersDogs()
        setTableViewDelegates()
        configureTableView()
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        isTableViewEmpty()
    }
    
    @objc
    func addDogTapped() {
        let addDogVC = AddDogViewController()
        modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(addDogVC, animated: true)
    }
    
    func showCurrentUsersDogs() {
        dogsModel.dogsListener = {
            self.tableView.reloadData()
        }
        dogsModel.getAllDogs()
                    }

    func setupView() {
        view.addSubview(myDogsView)
        myDogsView.addSubview(tableView)
    }
    
    func setupLayout() {
        myDogsView.pin(to: view)
        tableView.pin(to: myDogsView)
    }
    
    func configureNavBar() {
        let addDogBarButtonItem = UIBarButtonItem(image: UIImage(named: Image.plus)?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(addDogTapped))
        navigationItem.rightBarButtonItem = addDogBarButtonItem
    }
    
    func configureTableView() {
        self.tableView.backgroundColor = Color.lightGreen()
        self.tableView.register(DogCell.self, forCellReuseIdentifier: Cells.dogCell)
        self.tableView.pin(to: view)
        self.tableView.separatorStyle = .none
    }
    
    func isTableViewEmpty() {
        if dogsModel.currentUsersDogs.count == 0 {
            tableView.backgroundView = myDogsView.noDogsLabel
        }else {
            tableView.backgroundView = myDogsView.emptyDogsLabel
        }
    }
    
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension MyDogsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dogsModel.currentUsersDogs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.dogCell)as! DogCell
        let dog = dogsModel.currentUsersDogs[indexPath.row]
        cell.setDog(dog: dog)
        return cell
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let dog = dogsModel.currentUsersDogs[indexPath.row]
        let detailVC = DetailsViewController(dog: dog)
        modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let dog = dogsModel.currentUsersDogs[indexPath.row]
        if editingStyle == .delete {
            let db = Firestore.firestore()
            guard let dogRefId = dog.dogId else {
                print("error getting id for dog")
                return
            }
            db.collection(ConstantForDatabase.dogCollection).document(dogRefId).delete() { error in
                if let error = error {
                    print("Error deleting dog: \(error)")
                }else {
                    print("Dog deleted")
                }
                tableView.reloadData()
            }
        }
    }
}



