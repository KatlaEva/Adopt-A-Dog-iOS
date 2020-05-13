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
    
    var dogs: [Dog] = []
    
    let dogCellID = "dogCell"
    
    let tableView = UITableView()
    
    let dogCell = DogCell()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setView()
        setTableViewDelegates()
        configureTableView()
        getAllDogs()
    }
    
    func setView() {
        view.backgroundColor = Color.lightGreen()
        view.addSubview(tableView)
    }
    
    func getAllDogs() {
        let db = Firestore.firestore()

        db.collection("dogs").addSnapshotListener { (snapshot, error) in
            self.dogs.removeAll()
            if error != nil {
                print(error!.localizedDescription)
            }else {
                for field in snapshot!.documents {
                    let dog = Dog()
                    let currentUserUid = Auth.auth().currentUser?.uid
                    
                    dog.dogName = field["dog_name"]as?String
                    dog.dogAge = field["dog_age"]as?String
                    dog.dogRace = field["dog_race"]as?String
                    dog.dogInfo = field["dog_info"]as?String
                    dog.dogId = field["user_ref"]as?String
                    dog.hasFavorited = field["has_favorited"]as?Bool
                    dog.dogId = currentUserUid
                    self.dogs.append(dog)
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        
        
    }
    func configureTableView() {
        self.tableView.backgroundColor = Color.lightGreen()
        self.tableView.register(DogCell.self, forCellReuseIdentifier: dogCellID)
        self.tableView.pin(to: view)
        self.tableView.separatorStyle = .none
    }
    
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("dogs count here: \(dogs.count)")
        return dogs.count
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: dogCellID)as! DogCell
        let dog = dogs[indexPath.row]
        cell.setDog(dog: dog)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let dog = dogs[indexPath.row]
        let detailVC = DetailsViewController(dog: dog)
        modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}

extension UIView {
    
    func pin(to superView: UIView){
        translatesAutoresizingMaskIntoConstraints                             = false
        topAnchor.constraint(equalTo: superView.topAnchor).isActive           = true
        leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive   = true
        trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive     = true
    }
}
