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
    
    let dogCell = DogCell()
    let dogCellID = "dogCell"
    
    let tableView = UITableView()
    
    let dog = Dog()
    
    var usersDogs: [Dog] = []
    
    
    let noDogsLabel: UILabel = {
        let this = UILabel()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.text = "You have no dogs listed, click on the + in the top right corner to put your dog up for adoption"
        this.font = UIFont.Font.caviarDreamsBoldItalic(size: 28)
        this.numberOfLines = 0
        return this
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        configureNavBar()
        showCurrentUsersDogs()
        setTableViewDelegates()
        configureTableView()
        setLayout()
    }
    
    
    func showCurrentUsersDogs() {
        let db = Firestore.firestore()
        
        db.collection("dogs").addSnapshotListener { (snapshot, error) in
            self.usersDogs.removeAll()
            if error != nil {
                print(error!.localizedDescription)
            }else {
                for field in snapshot!.documents {
                    var dog = Dog()
                    let currentUserUID = Auth.auth().currentUser?.uid
                    
                    
                    dog.dogName = field["dog_name"]as?String
                    dog.dogAge = field["dog_age"]as?String
                    dog.dogRace = field["dog_race"]as?String
                    dog.dogInfo = field["dog_info"]as?String
                    dog.dogUserUid = field["user_ref"]as?String
                    dog.dogId = field["dog_id"]as?String
                    dog.imageUrl = field["meta_image_url"]as?String
                    
                    if let url = URL(string: dog.imageUrl ?? "no image url") {
                        
                        do{
                            let data = try Data(contentsOf: url)
                            dog.dogImage = UIImage(data: data)
                        }catch let error {
                            print(error.localizedDescription)
                        }
                    }
                    if dog.dogUserUid == currentUserUID {
                        self.usersDogs.append(dog)
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                }
            }
        }
    }
    
    func setView() {
        view.backgroundColor = Color.lightGreen()
        view.addSubview(tableView)
    }
    
    func setLayout() {
        NSLayoutConstraint.activate([
            
            noDogsLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            noDogsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noDogsLabel.heightAnchor.constraint(equalToConstant: 300),
            noDogsLabel.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    func configureNavBar() {
        
        let addDogBarButtonItem = UIBarButtonItem(image: UIImage(named: "plus")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(addDogTapped))
        navigationItem.rightBarButtonItem = addDogBarButtonItem
    }
    
    @objc
    func addDogTapped() {
        let addDogVC = AddDogViewController()
        modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(addDogVC, animated: true)
    }
    
    func configureTableView() {
        self.tableView.backgroundColor = Color.lightGreen()
        self.tableView.register(DogCell.self, forCellReuseIdentifier: dogCellID)
        self.tableView.pin(to: view)
        self.tableView.separatorStyle = .none
        isTableViewEmpty()
    }
    
    func isTableViewEmpty() {
        if self.usersDogs.count < 1 {
            tableView.backgroundView = noDogsLabel
        }else {
            self.noDogsLabel.textColor = Color.lightGreen()
        }
    }
    
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension MyDogsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersDogs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: dogCellID)as! DogCell
        let dog = usersDogs[indexPath.row]
        cell.setDog(dog: dog)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let dog = usersDogs[indexPath.row]
        let detailVC = DetailsViewController(dog: dog)
        modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let dog = usersDogs[indexPath.row]
        if editingStyle == .delete {
            let db = Firestore.firestore()
            guard let dogRefId = dog.dogId else {
                print("error getting id for dog")
                return
            }
            db.collection("dogs").document(dogRefId).delete() { error in
                if let error = error {
                    print("Error deleting dog: \(error)")
                }else {
                    print("Dog deleted with id: \(dog.dogId)")
                }
                tableView.reloadData()
            }
        }
    }
}

