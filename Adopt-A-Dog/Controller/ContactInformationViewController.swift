//
//  ContactInformationViewController.swift
//  Adopt-A-Dog
//
//  Created by Þórkatla Eva Víkingsdóttir on 16/05/2020.
//  Copyright © 2020 Þórkatla Eva Víkingsdóttir. All rights reserved.
//

import UIKit
import Firebase

class ContactInformationViewController: UIViewController {
    
    let usersModel = UsersModel()
    let contactInformationView = ContactInformationView()
    let user: User
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.lightGreen()
        setupView()
        setupLayout()
        setUser(user: user)
    }
    
    @objc
    func saveButtonTapped() {
        
    }
    
    func setupView() {
        view.addSubview(contactInformationView)
    }
    
    func setupLayout() {
        contactInformationView.pin(to: view)
    }
    
    func setupTargets() {
        contactInformationView.saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    func setUser(user: User) {
        contactInformationView.firstNameTextField.text = user.firstName
        contactInformationView.lastNameTextField.text = user.lastName
        contactInformationView.emailTextField.text = user.email
        contactInformationView.phoneNumberTextField.text = user.phoneNr
    }
    
}
