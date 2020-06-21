//
//  MyAccountViewController.swift
//  Adopt-A-Dog
//
//  Created by Þórkatla Eva Víkingsdóttir on 07/05/2020.
//  Copyright © 2020 Þórkatla Eva Víkingsdóttir. All rights reserved.
//

import UIKit
import Firebase

class MyAccountViewController: UIViewController {

    let myAccountView = MyAccountView()
    let userModel = UsersModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLayout()
        configureNavBar()
        setupTargets()
        userModel.getCurrentUserData()
    }
    
    @objc
    func myDogsTapped() {
        let myDogsVC = MyDogsViewController()
        myDogsVC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(myDogsVC, animated: true)
    }
    
    @objc
    func contactInformationTapped() {
        guard let user = userModel.currentUserList.first else {return}
        let contactVC = ContactInformationViewController(user: user)
        modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(contactVC, animated: true)
    }
    
    @objc
    func signOutTapped() {
        let loginVC = LoginViewController()
        do {
            try  Auth.auth().signOut()
        } catch let signOutError as NSError {
            print(ErrorMessage.signOutError, signOutError)
        }
        loginVC.modalPresentationStyle = .fullScreen
        self.present(loginVC, animated: true, completion: nil)
    }
    
    func setupView() {
        view.addSubview(myAccountView)
    }
    
    func setupLayout() {
        myAccountView.pin(to: view)
    }
    
    func configureNavBar() {
        let signOutBarButtonItem = UIBarButtonItem(title: Title.signOut, style: .plain, target: self, action: #selector(signOutTapped))
        navigationItem.leftBarButtonItem = signOutBarButtonItem
    }

    func setupTargets() {
        myAccountView.myDogsButton.addTarget(self, action: #selector(myDogsTapped), for: .touchUpInside)
        myAccountView.contactInformationButton.addTarget(self, action: #selector(contactInformationTapped), for: .touchUpInside)
    }
}


