//
//  LoginView.swift
//  Adopt-A-Dog
//
//  Created by Þórkatla Eva Víkingsdóttir on 20/05/2020.
//  Copyright © 2020 Þórkatla Eva Víkingsdóttir. All rights reserved.
//

import Foundation
import UIKit

class LoginView: UIView {
    
    let appNameLabel: UILabel = {
        let this = UILabel()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.text = Title.appName
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
        this.placeholder = Title.email
        this.layer.shadowOffset = CGSize(width: 20, height: 10)
        return this
    }()
    
    let passwordTextField: CustomTextFields = {
        let this = CustomTextFields()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.heightAnchor.constraint(equalToConstant: 45).isActive = true
        this.widthAnchor.constraint(equalToConstant: 300).isActive = true
        this.font = UIFont.Font.caviarDreamsItalic(size: 18)
        this.placeholder = Title.password
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
        this.setTitle(Title.login, for: .normal)
        this.titleLabel?.font = UIFont.Font.caviarDreamsBold(size: 20)
        this.setCorner(radius: 22.5)
        this.backgroundColor = Color.darkGreen()
        this.setTitleColor(UIColor.white, for: .normal)
        
        return this
    }()
    
    let signupButton: UIButton = {
        let this = UIButton()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.heightAnchor.constraint(equalToConstant: 30).isActive = true
        this.widthAnchor.constraint(equalToConstant: 400).isActive = true
        this.setTitle(Title.noAccount, for: .normal)
        this.titleLabel?.font = UIFont.Font.caviarDreamsBold(size: 18)
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
        self.addSubview(signupButton)
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
        self.addSubview(stack)
        
        NSLayoutConstraint.activate([
            
            appNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            appNameLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            logoImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            logoImage.topAnchor.constraint(equalTo: appNameLabel.bottomAnchor, constant: 20),
            
            stack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stack.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 30),
            
            signupButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            signupButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 30),
        ])
    }
    
    func styleElements() {
        CustomTextFields.styleTextField(emailTextField)
        CustomTextFields.styleTextField(passwordTextField)
    }
}
