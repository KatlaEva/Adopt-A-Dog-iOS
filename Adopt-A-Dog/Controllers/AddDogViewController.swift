//
//  AddDogViewController.swift
//  Adopt-A-Dog
//
//  Created by Þórkatla Eva Víkingsdóttir on 13/05/2020.
//  Copyright © 2020 Þórkatla Eva Víkingsdóttir. All rights reserved.
//

import UIKit
import Firebase

class AddDogViewController: UIViewController{
    
    let dog = Dog()
    
    lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 400)
    
    lazy var scrollView: UIScrollView = {
        let this = UIScrollView(frame: .zero)
        this.frame = self.view.bounds
        this.contentSize = contentViewSize
        this.autoresizingMask = .flexibleHeight
        this.bounces = true
        this.showsHorizontalScrollIndicator = true
        return this
    }()
    
    lazy var containerView: UIView = {
        let this = UIView()
        this.backgroundColor = UIColor.white
        this.frame.size = contentViewSize
        return this
    }()
    
    let dogImage: UIImageView = {
        let this = UIImageView()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.image = UIImage(named: Image.UploadLogo)
        return this
    }()
    
    let dogNameTextField: CustomTextFields = {
        let this = CustomTextFields()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.font = UIFont.Font.caviarDreamsItalic(size: 18)
        this.placeholder = "Name"
        return this
    }()
    
    let dogAgeTextField: CustomTextFields = {
        let this = CustomTextFields()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.font = UIFont.Font.caviarDreamsItalic(size: 18)
        this.placeholder = "Age"
        return this
    }()
    
    let dogRaceTextField: CustomTextFields = {
        let this = CustomTextFields()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.font = UIFont.Font.caviarDreamsItalic(size: 18)
        this.placeholder = "Race"
        return this
    }()
    
    let dogInfoTextField: CustomTextFields = {
        let this = CustomTextFields()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.font = UIFont.Font.caviarDreamsItalic(size: 18)
        this.placeholder = "Write about your dog here...."
        return this
    }()
    
    let addDogSaveButton: UIButton = {
        let this = UIButton()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.setTitle("Save", for: .normal)
        this.titleLabel?.font = UIFont.Font.caviarDreamsBold(size: 20)
        this.setCorner(radius: 22.5)
        this.backgroundColor = Color.darkGreen()
        this.setTitleColor(UIColor.white, for: .normal)
        this.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return this
    }()
    
    @objc
    func saveButtonTapped() {
        let db = Firestore.firestore()
        
        let dogName = dogNameTextField.text
        let dogAge = dogAgeTextField.text
        let dogRace = dogRaceTextField.text
        let dogInfo = dogInfoTextField.text
        let dogDoc = db.collection("dogs").document()
        let currentUser = Auth.auth().currentUser?.uid
        
        dogDoc.setData(["dog_name" : dogName, "dog_age" : dogAge, "dog_race" : dogRace, "dog_info" : dogInfo, "dog_id" : dogDoc, "user_ref" : currentUser]) { (error) in
            if error != nil {
                print(error!.localizedDescription)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        styleElements()
        setUpLayout()
    }
    
    func setUpView() {
        containerView.backgroundColor = Color.lightGreen()
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(dogImage)
//        view.addSubview(dogImage)
        
        
    }
    
    func setUpLayout() {
        let stackView: UIStackView = {
            let this = UIStackView(arrangedSubviews: [dogNameTextField, dogAgeTextField, dogRaceTextField, dogInfoTextField, addDogSaveButton])
            this.translatesAutoresizingMaskIntoConstraints = false
            this.axis = .vertical
            this.alignment = .center
            this.distribution = .equalSpacing
            this.spacing = 10
            return this
        }()
        containerView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
        
            dogImage.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            dogImage.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor, constant: 20),
            dogImage.heightAnchor.constraint(equalToConstant: 200),
            dogImage.widthAnchor.constraint(equalToConstant: 200),
            
            stackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: dogImage.bottomAnchor, constant: 20),
            
            
            //Move below elements to its corresponmding owners.
            dogNameTextField.heightAnchor.constraint(equalToConstant: 45),
            dogNameTextField.widthAnchor.constraint(equalToConstant: 300),
            
            dogAgeTextField.heightAnchor.constraint(equalToConstant: 45),
            dogAgeTextField.widthAnchor.constraint(equalToConstant: 300),
            
            dogRaceTextField.heightAnchor.constraint(equalToConstant: 45),
            dogRaceTextField.widthAnchor.constraint(equalToConstant: 300),
            
            dogInfoTextField.heightAnchor.constraint(equalToConstant: 300),
            dogInfoTextField.widthAnchor.constraint(equalToConstant: 300),
            
            addDogSaveButton.heightAnchor.constraint(equalToConstant: 45),
            addDogSaveButton.widthAnchor.constraint(equalToConstant: 300),
        ])
    }
    
    func styleElements() {
        Utilities.styleTextField(dogNameTextField)
        Utilities.styleTextField(dogAgeTextField)
        Utilities.styleTextField(dogRaceTextField)
        Utilities.styleTextField(dogInfoTextField)
    }

}
