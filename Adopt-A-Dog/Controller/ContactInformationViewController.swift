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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.lightGreen()
        setupView()
        setupLayout()
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
    
}
