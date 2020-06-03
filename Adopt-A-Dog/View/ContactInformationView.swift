//
//  ContactInformationView.swift
//  Adopt-A-Dog
//
//  Created by Þórkatla Eva Víkingsdóttir on 03/06/2020.
//  Copyright © 2020 Þórkatla Eva Víkingsdóttir. All rights reserved.
//

import Foundation
import UIKit

class ContactInformationView: UIView {
    
    let topLabel: UILabel = {
        let this = UILabel()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.text = Title.contactInfo
        this.textColor = UIColor.black
        this.font = UIFont.Font.caviarDreamsBold(size: 32)
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
    
    let phoneNumberTextField: CustomTextFields = {
        let this = CustomTextFields()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.heightAnchor.constraint(equalToConstant: 45).isActive = true
        this.widthAnchor.constraint(equalToConstant: 300).isActive = true
        this.font = UIFont.Font.caviarDreamsItalic(size: 18)
        this.placeholder = Title.phoneNumber
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
    
    let saveButton: UIButton = {
        let this = UIButton()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.heightAnchor.constraint(equalToConstant: 45).isActive = true
        this.widthAnchor.constraint(equalToConstant: 300).isActive = true
        this.setTitle(Title.save, for: .normal)
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
           self.addSubview(topLabel)
       }
       
       func setupLayout() {
           
           let stack: UIStackView = {
               let this = UIStackView(arrangedSubviews: [firstNameTextField, lastNameTextField, emailTextField, phoneNumberTextField, errorLabel, saveButton])
               this.translatesAutoresizingMaskIntoConstraints = false
               this.axis = .vertical
               this.distribution = .fill
               this.alignment = .center
               this.spacing = 10
               return this
           }()
           self.addSubview(stack)
           
           NSLayoutConstraint.activate([

               topLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
               topLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
               
               stack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
               stack.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 20),
           ])
       }
       
       func styleElements() {
           CustomTextFields.styleTextField(firstNameTextField)
           CustomTextFields.styleTextField(lastNameTextField)
           CustomTextFields.styleTextField(emailTextField)
           CustomTextFields.styleTextField(phoneNumberTextField)
       }
}
