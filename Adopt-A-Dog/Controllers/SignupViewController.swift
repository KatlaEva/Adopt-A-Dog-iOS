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
        this.layer.shadowOpacity = 0.7
        this.layer.shadowRadius = 10.0
        return this
    }()
    
    let firstNameTextField: CustomTextFields = {
        let this = CustomTextFields()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.font = UIFont.Font.caviarDreamsItalic(size: 18)
        this.placeholder = "First name"
        return this
    }()
    
    let lastNameTextField: CustomTextFields = {
        let this = CustomTextFields()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.font = UIFont.Font.caviarDreamsItalic(size: 18)
        this.placeholder = "Last name"
        return this
    }()
    
    let emailTextField: CustomTextFields = {
        let this = CustomTextFields()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.font = UIFont.Font.caviarDreamsItalic(size: 18)
        this.placeholder = "Username"
        return this
    }()
    
    let passwordTextField: CustomTextFields = {
        let this = CustomTextFields()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.font = UIFont.Font.caviarDreamsItalic(size: 18)
        this.placeholder = "Password"
        return this
    }()
    
    let errorLabel: UILabel = {
        let this = UILabel()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.alpha = 0
        this.font = UIFont.Font.caviarDreamsBold(size: 18)
        this.textColor = UIColor.red
        return this
    }()
    
    let signupButton: UIButton = {
        let this = UIButton()
        this.translatesAutoresizingMaskIntoConstraints = false
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
        //Validate the fields
        if PasswordValidation.validateFields(firstNameTextField) ||
           PasswordValidation.validateFields(lastNameTextField) ||
           PasswordValidation.validateFields(emailTextField) == false {
            
            PasswordValidation.showError(errorLabel, "Pleas fill inn all fields")
            
        }else
            
            if PasswordValidation.isPasswordValid(passwordTextField.text!) == false {
                PasswordValidation.showError(errorLabel, "Pleas make sure your password is at least 8 characters, contains a special character and a numer.")
        }
        user.firstName = firstNameTextField.text!
        user.lastName = lastNameTextField.text!
        user.email = emailTextField.text!
        user.password = passwordTextField.text!
        
        Auth.auth().createUser(withEmail: user.email!, password: user.password!) { (result, error) in
            if error != nil {
                PasswordValidation.showError(self.errorLabel, "Error creating user")
            }
            else {
                let db = Firestore.firestore()
                db.collection("users").addDocument(data: [
                    "first_name":self.user.firstName!,
                    "last_name":self.user.lastName!,
                    "uid": result!.user.uid ]) { (error) in
                        
                        if error != nil {
                            
                            PasswordValidation.showError(self.errorLabel, "Error saving user")
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
//        view.addSubview(noAccountLabel)
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
            logoImage.heightAnchor.constraint(equalToConstant: 180),
            logoImage.widthAnchor.constraint(equalTo: logoImage.heightAnchor),
            
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 20),
            
            firstNameTextField.heightAnchor.constraint(equalToConstant: 45),
            firstNameTextField.widthAnchor.constraint(equalToConstant: 300),
            
            lastNameTextField.heightAnchor.constraint(equalToConstant: 45),
            lastNameTextField.widthAnchor.constraint(equalToConstant: 300),

            emailTextField.heightAnchor.constraint(equalToConstant: 45),
            emailTextField.widthAnchor.constraint(equalToConstant: 300),

            passwordTextField.heightAnchor.constraint(equalToConstant: 45),
            passwordTextField.widthAnchor.constraint(equalToConstant: 300),
            
            errorLabel.heightAnchor.constraint(equalToConstant: 30),
            errorLabel.widthAnchor.constraint(equalToConstant: 300),
            
            signupButton.heightAnchor.constraint(equalToConstant: 45),
            signupButton.widthAnchor.constraint(equalToConstant: 300),

            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: signupButton.bottomAnchor, constant: 20),
            loginButton.heightAnchor.constraint(equalToConstant: 30),
            loginButton.widthAnchor.constraint(equalToConstant: 400)
        
            
        ])
    }
    
    func transitionToHome(){
        let homeVC = MainTabBarViewController()
        self.present(homeVC, animated: true, completion: nil)
 
    }
    
    func styleElements() {
        Utilities.styleTextField(firstNameTextField)
        Utilities.styleTextField(lastNameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
    }

}
