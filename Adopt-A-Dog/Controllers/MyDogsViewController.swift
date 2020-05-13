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
    
    let dog = Dog()
    
    var usersDogs: [Dog] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.lightGreen()
        configureNavBar()
        showCurrentUsersDogs()
        print("users dogs \(usersDogs.count)")
        print(dog.dogName)
        
    }

    
    func showCurrentUsersDogs() {
        let db = Firestore.firestore()
        let dog = Dog()
        let userUID = Auth.auth().currentUser?.uid
        
        db.collection("dogs").whereField("user_ref", isEqualTo: dog.dogId).getDocuments { (snapshot, error) in
            if error != nil {
                print(error!.localizedDescription)
            }else {
                for doc in snapshot!.documents {
                    if userUID == dog.dogId {
                    self.usersDogs.append(dog)
                        print("users dogs added: \(self.usersDogs.count)")
                    }
                    DispatchQueue.main.async {
                        self.reloadInputViews()
                    }
                }
            }
        }
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
}
