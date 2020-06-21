//
//  DogsModel.swift
//  Adopt-A-Dog
//
//  Created by Þórkatla Eva Víkingsdóttir on 20/05/2020.
//  Copyright © 2020 Þórkatla Eva Víkingsdóttir. All rights reserved.
//

import Foundation
import Firebase

class DogsModel {
    
    var dogsListener: (() -> Void)?
    var dogs: [Dog] = []
    var currentUsersDogs: [Dog] = []
    var defaults = UserDefaults.standard
    
    init() {
    }
    
    func getAllDogs() {
        let db = Firestore.firestore()
        let currentUserUid = Auth.auth().currentUser?.uid
        
        db.collection(ConstantForDatabase.dogCollection).addSnapshotListener { (snapshot, error) in
            
            if error != nil {
                print(error!.localizedDescription)
            }else {
                var dogs: [Dog] = []
                var currentUsersDogs: [Dog] = []
                for field in snapshot!.documents {
                    var dog = Dog()
                    
                    dog.dogId = field["dog_id"]as?String
                    dog.dogName = field["dog_name"]as?String
                    dog.dogAge = field["dog_age"]as?String
                    dog.dogBreed = field["dog_breed"]as?String
                    dog.dogInfo = field["dog_info"]as?String
                    dog.dogUserUid = field["user_ref"]as?String
                    dog.hasFavorited = field["has_favorited"]as?Bool
                    dog.imageUrl = field["meta_image_url"]as?String
                    
                    if let url = URL(string: dog.imageUrl ?? "no image url") {
                        
                        do{
                            let data = try Data(contentsOf: url)
                            dog.dogImage = UIImage(data: data)
                            
                        }catch let error {
                            print(error.localizedDescription)
                        }
                    }
                    if dog.dogUserUid == currentUserUid {
                        dogs.append(dog)
                        currentUsersDogs.append(dog)
                    } else {
                        dogs.append(dog)
                    }
                }
                DispatchQueue.main.async {
                    self.dogs = dogs
                    self.currentUsersDogs = currentUsersDogs
                    self.dogsListener?()
                }
            }
        }
    }
}
