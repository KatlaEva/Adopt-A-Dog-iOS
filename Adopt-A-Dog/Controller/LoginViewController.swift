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
    
    let loginView = LoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLayout()
        setupTargets()
    }
    
    //email with a password is hardcoded for the purpous of teacher and censor to be able to log in if needed.
     @objc
         func loginButtonTapped() {

    //         guard let email = emailTextField.text, let password = passwordTextField.text else {
    //             return
    //         }
    //         let validEmail = Validation.isEmailValid(email)
    //         if (validEmail == false) {
    //             Validation.showError(errorLabel, "email not valid")
    //             return
    //         }
            Auth.auth().signIn(withEmail: "kh@test.com", password: "Tester123*") { (result, error) in
                 if error != nil {
                    Validation.showError(self.loginView.errorLabel, ErrorMessage.incorrectEmailOrPassword)
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
    
    func setupView() {
        view.addSubview(loginView)
    }
    
    func setupLayout() {
        loginView.pin(to: view)
    }
    
    func setupTargets() {
        loginView.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        loginView.signupButton.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)
    }
    
    func transitionToHome(){
        let mainTabVC = MainTabBarViewController()
        mainTabVC.modalPresentationStyle = .fullScreen
        self.present(mainTabVC, animated: true, completion: nil)
    }
}
