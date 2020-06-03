//
//  UsersModel.swift
//  Adopt-A-Dog
//
//  Created by Þórkatla Eva Víkingsdóttir on 20/05/2020.
//  Copyright © 2020 Þórkatla Eva Víkingsdóttir. All rights reserved.
//

import Foundation
import Firebase

class UsersModel {
    
    var userListener: (()-> Void)?
    var userList: [User] = []
    
    init() {
        
    }
    
    func getCurrentUserData() {
    let db = Firestore.firestore()
    
    db.collection(ConstantForDatabase.userCollection).addSnapshotListener { (document, error) in
        if error != nil {
            print(error?.localizedDescription as Any)
        } else {
            var userList: [User] = []
            for field in document!.documents {
                var user = User()
                
                user.firstName = field["first_name"]as?String
                user.lastName = field["last_name"]as?String
                user.phoneNr = field["phone_number"]as?String
                user.userUid = field["uid"]as?String
    
                    userList.append(user)
                }
            DispatchQueue.main.async {
                self.userList = userList
                self.userListener?()
              }
            }
        }
    }
}
