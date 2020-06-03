//
//  HomeView.swift
//  Adopt-A-Dog
//
//  Created by Þórkatla Eva Víkingsdóttir on 02/06/2020.
//  Copyright © 2020 Þórkatla Eva Víkingsdóttir. All rights reserved.
//

import Foundation
import UIKit

class DetailsView: UIView {
    
    lazy var contentViewSize = CGSize(width: self.frame.width, height: self.frame.height + 800)
    
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
        this.backgroundColor = Color.lightGreen()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.frame.size = contentViewSize
        return this
    }()
    
    let dogImage: CircleImageView = {
        let this = CircleImageView()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.heightAnchor.constraint(equalToConstant: 200).isActive = true
        this.widthAnchor.constraint(equalToConstant: 200).isActive = true
        this.image = UIImage(named: Image.UploadLogo)
        return this
    }()
    
    let dogNameLabel: UILabel = {
        let this = UILabel()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.font = UIFont.Font.caviarDreamsBold(size: 32)
        return this
    }()
    
    let favoritesButton: UIButton = {
        let this = UIButton()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.heightAnchor.constraint(equalToConstant: 50).isActive = true
        this.widthAnchor.constraint(equalToConstant: 50).isActive = true
        this.setImage(#imageLiteral(resourceName: "favorites32"), for: .normal)
        return this
    }()
       
       let dogAgeLabel: UILabel = {
           let this = UILabel()
           this.translatesAutoresizingMaskIntoConstraints = false
           this.font = UIFont.Font.caviarDreamsBold(size: 22)
           return this
       }()
       
       let dogBreedLabel: UILabel = {
           let this = UILabel()
           this.translatesAutoresizingMaskIntoConstraints = false
           this.font = UIFont.Font.caviarDreamsBold(size: 22)
           return this
       }()
       
       let infoLabel: UILabel = {
           let this = UILabel()
           this.translatesAutoresizingMaskIntoConstraints = false
           this.font = UIFont.Font.caviarDreamsBold(size: 26)
           this.text = Title.moreInfo
           return this
       }()
       
       let moreInfoTextView: UITextView = {
           let this = UITextView()
           this.translatesAutoresizingMaskIntoConstraints = false
           this.heightAnchor.constraint(equalToConstant: 300).isActive = true
           this.widthAnchor.constraint(equalToConstant: 300).isActive = true
           this.backgroundColor = Color.darkGreen()
           this.font = UIFont.Font.caviarDreamsBoldItalic(size: 16)
           this.isEditable = false
           this.isScrollEnabled = true
           this.layer.cornerRadius = 10
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
        self.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(dogImage)
        containerView.addSubview(dogNameLabel)
        containerView.addSubview(favoritesButton)
        containerView.addSubview(infoLabel)
        containerView.addSubview(moreInfoTextView)
    }
    
    func setupLayout() {
        
        let stackView: UIStackView = {
             let this = UIStackView(arrangedSubviews: [dogAgeLabel, dogBreedLabel])
             this.translatesAutoresizingMaskIntoConstraints = false
             this.frame.size = contentViewSize
             this.axis = .vertical
             this.alignment = .center
             this.distribution = .equalSpacing
             this.spacing = 10
             return this
         }()
         containerView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            
            scrollView.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            scrollView.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor),
            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),

            containerView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            
            dogImage.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            dogImage.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor, constant: 20),

            dogNameLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            dogNameLabel.topAnchor.constraint(equalTo: dogImage.bottomAnchor, constant: 15),
            
            favoritesButton.centerYAnchor.constraint(equalTo: dogNameLabel.centerYAnchor),
            favoritesButton.leadingAnchor.constraint(equalTo: dogNameLabel.trailingAnchor, constant: 10),
            
            stackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: dogNameLabel.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            
            infoLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            infoLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            
            moreInfoTextView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            moreInfoTextView.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 10),
            moreInfoTextView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            moreInfoTextView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
        ])
    }
}
