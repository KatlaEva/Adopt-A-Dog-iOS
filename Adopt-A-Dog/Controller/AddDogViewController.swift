//
//  AddDogViewController.swift
//  Adopt-A-Dog
//
//  Created by Þórkatla Eva Víkingsdóttir on 13/05/2020.
//  Copyright © 2020 Þórkatla Eva Víkingsdóttir. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage


class AddDogViewController: UIViewController{

    let addDogView = AddDogView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLayout()
        setupTargets()
    }
    
    @objc
    func chooseImageButtonTapped() {
        showImagePickerControllerActionSheet()
    }
    
    //Skoða að færa þetta í DogsModel
    @objc
    func saveButtonTapped() {
        print("Save button tapped!")
        guard let imageSelected = addDogView.dogImage.image else {
            print("No image found")
            return
        }
        guard let imageData = imageSelected.jpegData(compressionQuality: 0.4) else {
            return
        }
        let db = Firestore.firestore()
        
        let dogName = addDogView.dogNameTextField.text
        let dogAge = addDogView.dogAgeTextField.text
        let dogBreed = addDogView.dogBreedTextField.text
        let dogInfo = addDogView.dogInfoTextField.text
        let dogDoc = db.collection(ConstantForDatabase.dogCollection).document()
        let currentUser = Auth.auth().currentUser?.uid
        
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
                    
                    dogDoc.setData(["dog_name" : dogName as Any, "dog_age" : dogAge as Any, "dog_breed" : dogBreed as Any, "dog_info" : dogInfo as Any, "dog_id" : dogDoc.documentID, "user_ref" : currentUser as Any, "meta_image_url": metaImageUrl]) { (error) in
                        
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
        view.addSubview(addDogView)
    }
    func setupLayout() {
        addDogView.pin(to: view)
    }

    func transitionToHome(){
        let myDogsVC = MyDogsViewController()
        myDogsVC.modalPresentationStyle = .fullScreen
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupTargets() {
        addDogView.chooseImageButton.addTarget(self, action: #selector(chooseImageButtonTapped), for: .touchUpInside)
        addDogView.addDogSaveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
}

extension AddDogViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
            addDogView.dogImage.image = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            addDogView.dogImage.image = originalImage
        }
        dismiss(animated: true, completion: nil)
    }
}
