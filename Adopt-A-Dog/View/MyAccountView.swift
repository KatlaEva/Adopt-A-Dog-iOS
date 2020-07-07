//
//  MyAccountView.swift
//  Adopt-A-Dog
//
//  Created by Þórkatla Eva Víkingsdóttir on 03/06/2020.
//  Copyright © 2020 Þórkatla Eva Víkingsdóttir. All rights reserved.
//

import Foundation
import UIKit

class MyAccountView: UIView {
    
    let topLabel: UILabel = {
        let this = UILabel()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.font = UIFont.Font.caviarDreamsBold(size: 32)
        this.text = Title.myAccount
        return this
    }()
    
    let logoImage: UIImageView = {
        let this = UIImageView(image: UIImage(named: Image.Logo))
        this.translatesAutoresizingMaskIntoConstraints = false
        this.heightAnchor.constraint(equalToConstant: 180).isActive = true
        this.widthAnchor.constraint(equalToConstant: 180).isActive = true
        this.layer.shadowOpacity = 0.7
        this.layer.shadowRadius = 10.0
        return this
    }()
    
    let myDogsButton: UIButton = {
        let this = UIButton()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.heightAnchor.constraint(equalToConstant: 45).isActive = true
        this.widthAnchor.constraint(equalToConstant: 300).isActive = true
        this.setCorner(radius: 22.5)
        this.titleLabel?.font = UIFont.Font.caviarDreamsBold(size: 18)
        this.setTitle(Title.myDogs, for: .normal)
        this.setTitleColor(Color.creamWhite(), for: .normal)
        this.backgroundColor = Color.darkGreen()
        return this
    }()
    
    let contactInformationButton: UIButton = {
        let this = UIButton()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.heightAnchor.constraint(equalToConstant: 45).isActive = true
        this.widthAnchor.constraint(equalToConstant: 300).isActive = true
        this.setCorner(radius: 22.5)
        this.titleLabel?.font = UIFont.Font.caviarDreamsBold(size: 18)
        this.setTitle(Title.contactInfo, for: .normal)
        this.setTitleColor(Color.creamWhite(), for: .normal)
        this.backgroundColor = Color.darkGreen()
        return this
    }()
    
    let myTalesButton: UIButton = {
        let this = UIButton()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.heightAnchor.constraint(equalToConstant: 45).isActive = true
        this.widthAnchor.constraint(equalToConstant: 300).isActive = true
        this.setCorner(radius: 22.5)
        this.titleLabel?.font = UIFont.Font.caviarDreamsBold(size: 18)
        this.setTitle(Title.myTales, for: .normal)
        this.setTitleColor(Color.creamWhite(), for: .normal)
        this.backgroundColor = Color.darkGreen()
        return this
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupView() {
        self.backgroundColor = Color.lightGreen()
        self.addSubview(topLabel)
        self.addSubview(logoImage)
        self.addSubview(myDogsButton)
        self.addSubview(myTalesButton)
        self.addSubview(contactInformationButton)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            topLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            topLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            logoImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            logoImage.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 30),
            
            myDogsButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            myDogsButton.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 50),
            
            myTalesButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            myTalesButton.topAnchor.constraint(equalTo: myDogsButton.bottomAnchor, constant: 20),
            
            contactInformationButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            contactInformationButton.topAnchor.constraint(equalTo: myTalesButton.bottomAnchor, constant: 20),
        ])
    }
}
