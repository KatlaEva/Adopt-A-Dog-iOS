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
    
    let signupView = SignupView()
    var user = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLayout()
        setupTargets()
    }
    
    @objc
    func loginButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    @objc
    func signupButtonTapped() {
        guard let firstName = signupView.firstNameTextField.text, let lastName = signupView.lastNameTextField.text, let email = signupView.emailTextField.text, let password = signupView.passwordTextField.text else {
            return
        }
        
        let validFirstName = Validation.isTextFieldValid(firstName)
        if (validFirstName == false) {
            Validation.showError(signupView.errorLabel, ErrorMessage.firstNameNotValid)
            return
        }
        let validLastName = Validation.isTextFieldValid(lastName)
        if (validLastName == false) {
            Validation.showError(signupView.errorLabel, ErrorMessage.lastNameNotValid)
            return
        }
        let validEmail = Validation.isEmailValid(email)
        if (validEmail == false) {
            Validation.showError(signupView.errorLabel, ErrorMessage.emailNotValid)
            return
        }
        let validPassword = Validation.isPasswordValid(password)
        if (validPassword == false) {
            Validation.showError(signupView.errorLabel, ErrorMessage.passwordNotValid)
            return
        }
        if (firstName == "" || lastName == "" || email == "" || password == "") {
            Validation.showError(signupView.errorLabel, ErrorMessage.fillAllFields)
            return
        }
        user.firstName = signupView.firstNameTextField.text!
        user.lastName = signupView.lastNameTextField.text!
        user.email = signupView.emailTextField.text!
        user.password = signupView.passwordTextField.text!
        
        Auth.auth().createUser(withEmail: user.email!, password: user.password!) { (result, error) in
            if error != nil {
                Validation.showError(self.signupView.errorLabel, ErrorMessage.errorCreatingUser)
            }
            else {
                let db = Firestore.firestore()
                db.collection(ConstantForDatabase.userCollection).addDocument(data: [
                    "first_name":self.user.firstName!,
                    "last_name":self.user.lastName!,
                    "uid": result!.user.uid ]) { (error) in
                        if error != nil {
                            Validation.showError(self.signupView.errorLabel, ErrorMessage.errorSavingUser)
                        }
                }
                self.transitionToHome()
            }
        }
    }
    
    
    func setupView() {
        view.addSubview(signupView)
    }
    
    func setupLayout() {
        signupView.pin(to: view)
    }
    
    func setupTargets() {
        signupView.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        signupView.signupButton.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)
    }
    
    func transitionToHome(){
        let mainTabVC = MainTabBarViewController()
        view.window?.rootViewController = mainTabVC
        mainTabVC.modalPresentationStyle = .fullScreen
        self.present(mainTabVC, animated: true, completion: nil)
    }
}
