//
//  SignupView.swift
//  Adopt-A-Dog
//
//  Created by Þórkatla Eva Víkingsdóttir on 20/05/2020.
//  Copyright © 2020 Þórkatla Eva Víkingsdóttir. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class SignupView: UIView {
    
    let appNameLabel: UILabel = {
        let this = UILabel()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.text = Title.appName
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
        this.placeholder = Title.firstName
        return this
    }()
    
    let lastNameTextField: CustomTextFields = {
        let this = CustomTextFields()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.heightAnchor.constraint(equalToConstant: 45).isActive = true
        this.widthAnchor.constraint(equalToConstant: 300).isActive = true
        this.font = UIFont.Font.caviarDreamsItalic(size: 18)
        this.placeholder = Title.lastName
        return this
    }()
    
    let emailTextField: CustomTextFields = {
        let this = CustomTextFields()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.heightAnchor.constraint(equalToConstant: 45).isActive = true
        this.widthAnchor.constraint(equalToConstant: 300).isActive = true
        this.font = UIFont.Font.caviarDreamsItalic(size: 18)
        this.placeholder = Title.email
        return this
    }()
    
    let passwordTextField: CustomTextFields = {
        let this = CustomTextFields()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.heightAnchor.constraint(equalToConstant: 45).isActive = true
        this.widthAnchor.constraint(equalToConstant: 300).isActive = true
        this.font = UIFont.Font.caviarDreamsItalic(size: 18)
        this.placeholder = Title.password
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
    
    let loginButton: UIButton = {
        let this = UIButton()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.heightAnchor.constraint(equalToConstant: 30).isActive = true
        this.widthAnchor.constraint(equalToConstant: 400).isActive = true
        this.setTitle(Title.hasAccount, for: .normal)
        this.titleLabel?.font = UIFont.Font.caviarDreamsBold(size: 16)
        return this
    }()
    
    let signupButton: UIButton = {
        let this = UIButton()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.heightAnchor.constraint(equalToConstant: 45).isActive = true
        this.widthAnchor.constraint(equalToConstant: 300).isActive = true
        this.setTitle(Title.signup, for: .normal)
        this.setCorner(radius: 22.5)
        this.backgroundColor = Color.darkGreen()
        this.titleLabel?.font = UIFont.Font.caviarDreamsBold(size: 20)
        this.setTitleColor(UIColor.white, for: .normal)
        return this
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupLayout()
        styleElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.backgroundColor = Color.lightGreen()
        self.addSubview(appNameLabel)
        self.addSubview(logoImage)
        self.addSubview(loginButton)
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
        self.addSubview(stack)
        
        NSLayoutConstraint.activate([
            
            appNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            appNameLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            logoImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            logoImage.topAnchor.constraint(equalTo: appNameLabel.bottomAnchor, constant: 20),
            
            stack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stack.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 20),
            
            loginButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: signupButton.bottomAnchor, constant: 20),
        ])
    }
    
    func styleElements() {
        CustomTextFields.styleTextField(firstNameTextField)
        CustomTextFields.styleTextField(lastNameTextField)
        CustomTextFields.styleTextField(emailTextField)
        CustomTextFields.styleTextField(passwordTextField)
    }
}
