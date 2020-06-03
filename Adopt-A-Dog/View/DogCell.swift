//
//  DogCell.swift
//  Adopt-A-Dog
//
//  Created by Þórkatla Eva Víkingsdóttir on 07/05/2020.
//  Copyright © 2020 Þórkatla Eva Víkingsdóttir. All rights reserved.
//

import UIKit

class DogCell: UITableViewCell {
    
    let dog = Dog()
    
    let cellView: UIView = {
        let this = UIView()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.backgroundColor = Color.darkGreen()
        this.layer.cornerRadius = 20.0
//        this.accessibilityScroll(.up)
        return this
    }()
    
    let stackView: UIStackView = {
        let this = UIStackView()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.axis = .vertical
        this.distribution = .fillEqually
        this.alignment = .leading
        this.spacing = 1
        return this
    }()
    
    let dogImage: CircleImageView = {
        let this = CircleImageView()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.image = UIImage(named: Image.UploadLogo)
        return this
    }()
    
    let dogName: UILabel = {
        let this = UILabel()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.font = UIFont.Font.caviarDreams(size: 18)
        return this
    }()
    
    let dogAge: UILabel = {
        let this = UILabel()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.font = UIFont.Font.caviarDreams(size: 18)
        return this
    }()
    
    let dogRace: UILabel = {
        let this = UILabel()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.font = UIFont.Font.caviarDreams(size: 18)
        return this
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        contentView.backgroundColor = Color.lightGreen()
        contentView.addSubview(cellView)
        cellView.addSubview(dogImage)
        cellView.addSubview(stackView)
        stackView.addArrangedSubview(dogName)
        stackView.addArrangedSubview(dogAge)
        stackView.addArrangedSubview(dogRace)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            
            cellView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            cellView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            cellView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            
            dogImage.centerYAnchor.constraint(equalTo: cellView.centerYAnchor),
            dogImage.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 10),
            dogImage.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 5),
            dogImage.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -10),
            dogImage.widthAnchor.constraint(equalToConstant: 110),
            
            stackView.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: dogImage.trailingAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -10),
        ])
    }
    
    func setDog(dog:Dog) {
        dogName.text = "Name: \(dog.dogName ?? "No name")"
        dogAge.text = "Age: \(dog.dogAge ?? "No age")"
        dogRace.text = "Breed: \(dog.dogBreed ?? "No breed")"
        dogImage.image = dog.dogImage
        
    }

}
