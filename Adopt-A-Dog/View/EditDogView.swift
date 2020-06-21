//
//  EditDogView.swift
//  Adopt-A-Dog
//
//  Created by Þórkatla Eva Víkingsdóttir on 15/06/2020.
//  Copyright © 2020 Þórkatla Eva Víkingsdóttir. All rights reserved.
//

import Foundation
import UIKit

class EditDogView: UIView {
    
    lazy var contentViewSize = CGSize(width: self.frame.width, height: self.frame.height + 900)
    
    lazy var scrollView: UIScrollView = {
        let this = UIScrollView(frame: .zero)
        this.frame = self.bounds
        this.contentSize = contentViewSize
        this.autoresizingMask = .flexibleHeight
        this.translatesAutoresizingMaskIntoConstraints = false
        this.bounces = true
        this.showsHorizontalScrollIndicator = true
        return this
    }()
    
    lazy var containerView: UIView = {
        let this = UIView()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.backgroundColor = Color.lightGreen()
        this.self.frame.size = contentViewSize
        return this
    }()
    
    let dogImage: CircleImageView = {
        let this = CircleImageView()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.heightAnchor.constraint(equalToConstant: 200).isActive = true
        this.widthAnchor.constraint(equalToConstant: 200).isActive = true
        this.layoutSubviews()
        this.image = UIImage(named: Image.UploadLogo)
        return this
    }()
    
    let chooseImageButton: UIButton = {
        let this = UIButton()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.heightAnchor.constraint(equalToConstant: 30).isActive = true
        this.widthAnchor.constraint(equalToConstant: 190).isActive = true
        this.setTitle(Title.chooseImage, for: .normal)
        this.setCorner(radius: 15)
        this.backgroundColor = Color.darkGreen()
        this.setTitleColor(UIColor.white, for: .normal)
        this.titleLabel?.font = UIFont.Font.caviarDreamsBold(size: 15)
        return this
    }()
    
    let dogNameTextField: CustomTextFields = {
        let this = CustomTextFields()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.heightAnchor.constraint(equalToConstant: 45).isActive = true
        this.widthAnchor.constraint(equalToConstant: 300).isActive = true
        this.font = UIFont.Font.caviarDreamsItalic(size: 18)
        this.placeholder = Title.name
        return this
    }()
    
    let dogAgeTextField: CustomTextFields = {
        let this = CustomTextFields()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.heightAnchor.constraint(equalToConstant: 45).isActive = true
        this.widthAnchor.constraint(equalToConstant: 300).isActive = true
        this.font = UIFont.Font.caviarDreamsItalic(size: 18)
        this.placeholder = Title.age
        return this
    }()
    
    let dogBreedTextField: CustomTextFields = {
        let this = CustomTextFields()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.heightAnchor.constraint(equalToConstant: 45).isActive = true
        this.widthAnchor.constraint(equalToConstant: 300).isActive = true
        this.font = UIFont.Font.caviarDreamsItalic(size: 18)
        this.placeholder = Title.breed
        return this
    }()
    
    let dogInfoTextField: CustomTextFields = {
        let this = CustomTextFields()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.heightAnchor.constraint(equalToConstant: 200).isActive = true
        this.widthAnchor.constraint(equalToConstant: 300).isActive = true
        this.font = UIFont.Font.caviarDreamsItalic(size: 18)
        this.placeholder = Title.writeAbout
        return this
    }()
    
    let editDogButton: UIButton = {
        let this = UIButton()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.heightAnchor.constraint(equalToConstant: 45).isActive = true
        this.widthAnchor.constraint(equalToConstant: 300).isActive = true
        this.setTitle(Title.edit, for: .normal)
        this.titleLabel?.font = UIFont.Font.caviarDreamsBold(size: 20)
        this.setCorner(radius: 15)
        this.backgroundColor = Color.darkGreen()
        this.setTitleColor(UIColor.white, for: .normal)
        return this
    }()
    
    override init(frame:CGRect) {
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
        containerView.backgroundColor = Color.lightGreen()
        self.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(dogImage)
        containerView.addSubview(chooseImageButton)
    }
    
    func setupLayout() {
        
        let stackView: UIStackView = {
            let this = UIStackView(arrangedSubviews: [dogNameTextField, dogAgeTextField, dogBreedTextField, dogInfoTextField, editDogButton])
            this.translatesAutoresizingMaskIntoConstraints = false
            this.axis = .vertical
            this.alignment = .center
            this.distribution = .equalSpacing
            this.spacing = 10
            return this
        }()
        containerView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            
            scrollView.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            
            containerView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            
            dogImage.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            dogImage.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            chooseImageButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            chooseImageButton.topAnchor.constraint(equalTo: dogImage.bottomAnchor, constant: 10),
            
            stackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: chooseImageButton.bottomAnchor, constant: 20)
        ])
    }
    
    func styleElements() {
        CustomTextFields.styleTextField(dogNameTextField)
        CustomTextFields.styleTextField(dogAgeTextField)
        CustomTextFields.styleTextField(dogBreedTextField)
        CustomTextFields.styleTextField(dogInfoTextField)
    }
}

