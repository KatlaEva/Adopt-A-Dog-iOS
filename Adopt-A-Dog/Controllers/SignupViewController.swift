//
//  SignupViewController.swift
//  Adopt-A-Dog
//
//  Created by Þórkatla Eva Víkingsdóttir on 05/05/2020.
//  Copyright © 2020 Þórkatla Eva Víkingsdóttir. All rights reserved.
//

import UIKit
import Firebase

class SignupViewController: UIViewController {
    
    let user = User()
    
    let nameLabel: UILabel = {
        let this = UILabel()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.text = "Adopt-A-Dog"
        this.textColor = UIColor.black
        this.font = UIFont.Font.strawberry(size: 32)
        return this
    }()
    
    let logoImage: UIImageView = {
        let this = UIImageView(image: UIImage(named: Image.Logo))
        this.translatesAutoresizingMaskIntoConstraints = false
        this.heightAnchor.constraint(equalToConstant: 180).isActive = true
        this.widthAnchor.constraint(equalTo: this.heightAnchor).isActive = true
        this.layer.shadowOpacity = 0.7
        this.layer.shadowRadius = 10.0
        return this
    }()
    
    let firstNameTextField: CustomTextFields = {
        let this = CustomTextFields()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.heightAnchor.constraint(equalToConstant: 45).isActive = true
        this.widthAnchor.constraint(equalToConstant: 300).isActive = true
        this.font = UIFont.Font.caviarDreamsItalic(size: 18)
        this.placeholder = "First name"
        return this
    }()
    
    let lastNameTextField: CustomTextFields = {
        let this = CustomTextFields()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.heightAnchor.constraint(equalToConstant: 45).isActive = true
        this.widthAnchor.constraint(equalToConstant: 300).isActive = true
        this.font = UIFont.Font.caviarDreamsItalic(size: 18)
        this.placeholder = "Last name"
        return this
    }()
    
    let emailTextField: CustomTextFields = {
        let this = CustomTextFields()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.heightAnchor.constraint(equalToConstant: 45).isActive = true
        this.widthAnchor.constraint(equalToConstant: 300).isActive = true
        this.font = UIFont.Font.caviarDreamsItalic(size: 18)
        this.placeholder = "Email"
        return this
    }()
    
    let passwordTextField: CustomTextFields = {
        let this = CustomTextFields()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.heightAnchor.constraint(equalToConstant: 45).isActive = true
        this.widthAnchor.constraint(equalToConstant: 300).isActive = true
        this.font = UIFont.Font.caviarDreamsItalic(size: 18)
        this.placeholder = "Password"
        return this
    }()
    
    let errorLabel: UILabel = {
        let this = UILabel()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.heightAnchor.constraint(equalToConstant: 50).isActive = true
        this.widthAnchor.constraint(equalToConstant: 300).isActive = true
        this.alpha = 0
        this.font = UIFont.Font.caviarDreamsBold(size: 12)
        this.numberOfLines = 0
        this.textColor = UIColor.red
        return this
    }()
    
    let signupButton: UIButton = {
        let this = UIButton()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.heightAnchor.constraint(equalToConstant: 45).isActive = true
        this.widthAnchor.constraint(equalToConstant: 300).isActive = true
        this.setTitle("Signup", for: .normal)
        this.setCorner(radius: 22.5)
        this.backgroundColor = Color.darkGreen()
        this.titleLabel?.font = UIFont.Font.caviarDreamsBold(size: 20)
        this.setTitleColor(UIColor.white, for: .normal)
        this.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)
        return this
    }()
    
    let loginButton: UIButton = {
        let this = UIButton()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.heightAnchor.constraint(equalToConstant: 30).isActive = true
        this.widthAnchor.constraint(equalToConstant: 400).isActive = true
        this.setTitle("Allready have an accoung? - Login here!", for: .normal)
        this.titleLabel?.font = UIFont.Font.caviarDreamsBold(size: 16)
        this.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return this
    }()
    
    
    
    @objc
    func loginButtonTapped() {
//        let loginVC = LoginViewController()
        self.dismiss(animated: true, completion: nil)
    }
    @objc
    func signupButtonTapped() {
        guard let firstName = firstNameTextField.text, let lastName = lastNameTextField.text, let email = emailTextField.text, let password = passwordTextField.text else {
            return
        }
        
        let validFirstName = Validation.isTextFieldValid(firstName)
        if (validFirstName == false) {
            Validation.showError(errorLabel, "First name not valid, must be at least to characters")
            return
        }
        let validLastName = Validation.isTextFieldValid(lastName)
        if (validLastName == false) {
            Validation.showError(errorLabel, "Last name not valid, must be at least to characters")
            return
        }
        let validEmail = Validation.isEmailValid(email)
        if (validEmail == false) {
            Validation.showError(errorLabel, "email not valid")
            return
        }
        let validPassword = Validation.isPasswordValid(password)
        if (validPassword == false) {
            Validation.showError(errorLabel, "Pleas make sure your password is at least 8 characters, contains a special character and a numer.")
            return
        }
        
        if (firstName == "" || lastName == "" || email == "" || password == "") {
            Validation.showError(errorLabel, "Pleas fill inn all fields")
            return
        }
        
        user.firstName = firstNameTextField.text!
        user.lastName = lastNameTextField.text!
        user.email = emailTextField.text!
        user.password = passwordTextField.text!
        
        Auth.auth().createUser(withEmail: user.email!, password: user.password!) { (result, error) in
            if error != nil {
                Validation.showError(self.errorLabel, "Error creating user")
            }
            else {
                let db = Firestore.firestore()
                db.collection("users").addDocument(data: [
                    "first_name":self.user.firstName!,
                    "last_name":self.user.lastName!,
                    "uid": result!.user.uid ]) { (error) in
                        
                        if error != nil {
                            
                            Validation.showError(self.errorLabel, "Error saving user")
                        }
                }
                self.transitionToHome()
                
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLayout()
        styleElements()
    }

    
    func setupView() {
        view.backgroundColor = Color.lightGreen()
        view.addSubview(nameLabel)
        view.addSubview(logoImage)
        view.addSubview(loginButton)
    }

    func setupLayout() {
        
        let stack: UIStackView = {
            let this = UIStackView(arrangedSubviews: [firstNameTextField, lastNameTextField, emailTextField, passwordTextField, errorLabel, signupButton])
            this.translatesAutoresizingMaskIntoConstraints = false
            this.axis = .vertical
            this.distribution = .fill
            this.alignment = .center
            this.spacing = 10
            return this
        }()
        view.addSubview(stack)
        
        NSLayoutConstraint.activate([

            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImage.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 20),
            
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: signupButton.bottomAnchor, constant: 20),
        ])
    }
    
    func transitionToHome(){
        let mainTabVC = MainTabBarViewController()
        view.window?.rootViewController = mainTabVC
        mainTabVC.modalPresentationStyle = .fullScreen
        self.present(mainTabVC, animated: true, completion: nil)
    }
    
    func styleElements() {
        Utilities.styleTextField(firstNameTextField)
        Utilities.styleTextField(lastNameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
    }

}
