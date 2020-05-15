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
        this.heightAnchor.constraint(equalToConstant: 180).isActive = true
        this.widthAnchor.constraint(equalTo: this.heightAnchor).isActive = true
        this.layer.shadowOpacity = 0.7
        this.layer.shadowRadius = 10.0
        return this
    }()
    
    let emailTextField: CustomTextFields = {
        let this = CustomTextFields()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.heightAnchor.constraint(equalToConstant: 45).isActive = true
        this.widthAnchor.constraint(equalToConstant: 300).isActive = true
        this.font = UIFont.Font.caviarDreamsItalic(size: 18)
        this.placeholder = "Email"
        this.layer.shadowOffset = CGSize(width: 20, height: 10)
        return this
    }()
    
    let passwordTextField: CustomTextFields = {
        let this = CustomTextFields()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.heightAnchor.constraint(equalToConstant: 45).isActive = true
        this.widthAnchor.constraint(equalToConstant: 300).isActive = true
        this.font = UIFont.Font.caviarDreamsItalic(size: 18)
        this.placeholder = "Password"
        this.layer.shadowOffset = CGSize(width: 20, height: 10)
        return this
    }()
    
    let errorLabel: UILabel = {
        let this = UILabel()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.heightAnchor.constraint(equalToConstant: 30).isActive = true
        this.widthAnchor.constraint(equalToConstant: 300).isActive = true
        this.font = UIFont.Font.caviarDreamsItalic(size: 12)
        this.numberOfLines = 0
        this.alpha = 0
        this.textColor = UIColor.red
        return this
    }()
    
    let loginButton: UIButton = {
        let this = UIButton()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.heightAnchor.constraint(equalToConstant: 45).isActive = true
        this.widthAnchor.constraint(equalToConstant: 300).isActive = true
        this.setTitle("Login", for: .normal)
        this.titleLabel?.font = UIFont.Font.caviarDreamsBold(size: 20)
        this.setCorner(radius: 22.5)
        this.backgroundColor = Color.darkGreen()
        this.setTitleColor(UIColor.white, for: .normal)
        this.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return this
    }()
    
     @objc
     func loginButtonTapped() {
    
         guard let email = emailTextField.text, let password = passwordTextField.text else {
             return
         }
         let validEmail = Validation.isEmailValid(email)
         if (validEmail == false) {
             Validation.showError(errorLabel, "email not valid")
             return
         }
         Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
             if error != nil {
                 Validation.showError(self.errorLabel, "Password or email is incorrect")
             }
             else {
                 self.transitionToHome()
             }
         }
     }
    
    let signupButton: UIButton = {
        let this = UIButton()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.heightAnchor.constraint(equalToConstant: 30).isActive = true
        this.widthAnchor.constraint(equalToConstant: 400).isActive = true
        this.setTitle("Dont have an account? - Signup here!", for: .normal)
        this.titleLabel?.font = UIFont.Font.caviarDreamsBold(size: 18)
        this.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)
        return this
    }()
    
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
            let this = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, errorLabel, loginButton])
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

            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 30),

            signupButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signupButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 30),
        ])
    }
    
    func transitionToHome(){
        let mainTabVC = MainTabBarViewController()
        view.window?.rootViewController = mainTabVC
        mainTabVC.modalPresentationStyle = .fullScreen
        self.present(mainTabVC, animated: true, completion: nil)
    }
    
    func styleElements() {
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
    }
}
