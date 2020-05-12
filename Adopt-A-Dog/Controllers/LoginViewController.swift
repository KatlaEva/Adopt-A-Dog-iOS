//
//  ViewController.swift
//  Adopt-A-Dog
//
//  Created by Þórkatla Eva Víkingsdóttir on 27/04/2020.
//  Copyright © 2020 Þórkatla Eva Víkingsdóttir. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    let logoLabel: UILabel = {
        let this = UILabel()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.text = "Adopt-A-Dog"
        this.textColor = UIColor.black
        this.font = UIFont.Font.strawberry(size: 38)
        return this
    }()
    
    let logoImage: UIImageView = {
        let this = UIImageView(image: UIImage(named: Image.Logo))
        this.translatesAutoresizingMaskIntoConstraints = false
        this.layer.shadowOpacity = 0.7
        this.layer.shadowRadius = 10.0
        return this
    }()
    
    let userNameTextField: CustomTextFields = {
        let this = CustomTextFields()
        this.font = UIFont.Font.caviarDreamsItalic(size: 18)
        this.placeholder = "Username"
        this.layer.shadowOffset = CGSize(width: 20, height: 10)
        return this
    }()
    
    let passwordTextField: CustomTextFields = {
        let this = CustomTextFields()
        this.font = UIFont.Font.caviarDreamsItalic(size: 18)
        this.placeholder = "Password"
        this.layer.shadowOffset = CGSize(width: 20, height: 10)
        return this
    }()
    
    let errorLabel: UILabel = {
        let this = UILabel()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.font = UIFont.Font.caviarDreamsItalic(size: 18)
        this.alpha = 0
        this.textColor = UIColor.red
        return this
    }()
    
    let loginButton: UIButton = {
        let this = UIButton()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.setTitle("Login", for: .normal)
        this.titleLabel?.font = UIFont.Font.caviarDreamsBold(size: 20)
        this.setCorner(radius: 22.5)
        this.backgroundColor = Color.darkGreen()
        this.setTitleColor(UIColor.white, for: .normal)
        this.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return this
    }()
    
    let signupButton: UIButton = {
        let this = UIButton()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.setTitle("Dont have an account? - Signup here!", for: .normal)
        this.titleLabel?.font = UIFont.Font.caviarDreamsBold(size: 18)
        this.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)
        return this
    }()
    
    @objc
    func loginButtonTapped() {
        //Validate textFields
        //       if PasswordValidation.validateFields(userNameTextField) ||
        //        PasswordValidation.validateFields(passwordTextField) == false {
        //                PasswordValidation.showError(errorLabel, "Pleas fill in the fields")
        //       }else {
        //Sign in the user
        
//        let email = userNameTextField.text!
//        let password = passwordTextField.text!
        
        Auth.auth().signIn(withEmail: "d@test.com", password: "123456*Test") { (result, error) in
            if error != nil {
                PasswordValidation.showError(self.errorLabel, "Password or email is incorrect")
            }
            else {
                self.transitionToHome()
            }
        }
    }
    
    @objc
    func signupButtonTapped() {
        let signupVC = SignupViewController()
        signupVC.modalPresentationStyle = .fullScreen
        self.present(signupVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLayout()
        styleElements()
    }
    
    
    func setupView() {
        view.backgroundColor = Color.lightGreen()
        view.addSubview(logoLabel)
        view.addSubview(logoImage)
        //        view.addSubview(noAccountLabel)
        view.addSubview(signupButton)
    }
    
    func setupLayout() {
        
        let stack: UIStackView = {
            let this = UIStackView(arrangedSubviews: [userNameTextField, passwordTextField, errorLabel, loginButton])
            this.translatesAutoresizingMaskIntoConstraints = false
            this.axis = .vertical
            this.distribution = .fill
            this.alignment = .center
            this.spacing = 10
            return this
        }()
        view.addSubview(stack)
        
        NSLayoutConstraint.activate([
            
            logoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImage.topAnchor.constraint(equalTo: logoLabel.bottomAnchor, constant: 20),
            logoImage.heightAnchor.constraint(equalToConstant: 180),
            logoImage.widthAnchor.constraint(equalTo: logoImage.heightAnchor),
            
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 30),
            
            userNameTextField.heightAnchor.constraint(equalToConstant: 45),
            userNameTextField.widthAnchor.constraint(equalToConstant: 300),
            
            passwordTextField.heightAnchor.constraint(equalToConstant: 45),
            passwordTextField.widthAnchor.constraint(equalToConstant: 300),
            
            errorLabel.heightAnchor.constraint(equalToConstant: 30),
            errorLabel.widthAnchor.constraint(equalToConstant: 300),
            
            loginButton.heightAnchor.constraint(equalToConstant: 45),
            loginButton.widthAnchor.constraint(equalToConstant: 300),

            signupButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signupButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 30),
            signupButton.heightAnchor.constraint(equalToConstant: 30),
            signupButton.widthAnchor.constraint(equalToConstant: 400)
            
            
        ])
    }
    
    func transitionToHome(){
        let mainTabVC = MainTabBarViewController()
        view.window?.rootViewController = mainTabVC
        mainTabVC.modalPresentationStyle = .fullScreen
        self.present(mainTabVC, animated: true, completion: nil)

        
        
    }
    
    func styleElements() {
        Utilities.styleTextField(userNameTextField)
        Utilities.styleTextField(passwordTextField)
    }
    
}

