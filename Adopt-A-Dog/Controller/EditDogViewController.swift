//
//  EditDogViewController.swift
//  Adopt-A-Dog
//
//  Created by Þórkatla Eva Víkingsdóttir on 15/06/2020.
//  Copyright © 2020 Þórkatla Eva Víkingsdóttir. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class EditDogViewController: UIViewController {
    
    let editDogView = EditDogView()
    let dogModel = DogsModel()
    let dog: Dog
    var dogDocRef = ""
    
    init(dog: Dog) {
        self.dog = dog
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLayout()
        setupTargets()
        setDog(dog: dog)
    }
    
    @objc
    func chooseImageButtonTapped() {
        showImagePickerControllerActionSheet()
    }
    
    @objc
    func editButtonTapped() {
        dogModel.currentUsersDogs = []
        
        print("Edit button tapped!")
        guard let imageSelected = editDogView.dogImage.image else {
            print("No image found")
            return
        }
        guard let imageData = imageSelected.jpegData(compressionQuality: 0.4) else {
            return
        }
        let db = Firestore.firestore()
        
        let dogName = editDogView.dogNameTextField.text
        let dogAge = editDogView.dogAgeTextField.text
        let dogBreed = editDogView.dogBreedTextField.text
        let dogInfo = editDogView.dogInfoTextField.text
        let currentUser = Auth.auth().currentUser?.uid
        let currentDog = db.collection(ConstantForDatabase.dogCollection).document(self.dogDocRef)
        
        let storageRef = Storage.storage().reference(forURL: ConstantForDatabase.storageURL)
        let storageDogImageRef = storageRef.child(ConstantForDatabase.dogImage).child(dogName!)
        
        let metadata = StorageMetadata()
        metadata.contentType = ConstantForDatabase.imageTypeJPG
        storageDogImageRef.putData(imageData, metadata: metadata, completion: {
            (StorageMetadata, error) in
            if error != nil {
                print(error?.localizedDescription as Any)
                return
            }
            storageDogImageRef.downloadURL { (url, error) in
                if let metaImageUrl = url?.absoluteString {
                    print(metaImageUrl)
                    
                    
                    currentDog.updateData(["dog_name" : dogName as Any, "dog_age" : dogAge as Any, "dog_breed" : dogBreed as Any, "dog_info" : dogInfo as Any, "user_ref" : currentUser as Any, "meta_image_url": metaImageUrl]) { (error) in
                        
                        if error != nil {
                            print(error!.localizedDescription)
                        }
                        self.transitionToHome()
                    }
                }
            }
        })
    }
    
    func setupView() {
        view.addSubview(editDogView)
    }
    func setupLayout() {
        editDogView.pin(to: view)
    }
    
    func transitionToHome(){
        let myDogsVC = MyDogsViewController()
        myDogsVC.modalPresentationStyle = .fullScreen
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupTargets() {
        editDogView.chooseImageButton.addTarget(self, action: #selector(chooseImageButtonTapped), for: .touchUpInside)
        editDogView.editDogButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
    }
    
    func setDog(dog:Dog) {
        editDogView.dogNameTextField.text = dog.dogName
        editDogView.dogAgeTextField.text = dog.dogAge
        editDogView.dogBreedTextField.text = dog.dogBreed
        editDogView.dogInfoTextField.text = dog.dogInfo
        editDogView.dogImage.image = dog.dogImage
        self.dogDocRef = dog.dogId!
    }
}

extension EditDogViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func showImagePickerControllerActionSheet() {
        
        let photoLibraryAction = UIAlertAction(title: Title.chooseFromLibrary, style: .default) { (action) in
            self.showImagePickerController(sourceType: .photoLibrary)
        }
        let cameraAction = UIAlertAction(title: Title.newPhoto, style: .default) { (action) in
            self.showImagePickerController(sourceType: .camera)
        }
        
        let cancelAction = UIAlertAction(title: Title.cancel, style: .cancel, handler: nil)
        
        AlertService.showAlert(style: .actionSheet, title: Title.chooseYourImage, message: nil, actions: [photoLibraryAction, cameraAction, cancelAction], completion: nil)
    }
    
    func showImagePickerController(sourceType: UIImagePickerController.SourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = sourceType
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            editDogView.dogImage.image = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            editDogView.dogImage.image = originalImage
        }
        dismiss(animated: true, completion: nil)
    }
}

