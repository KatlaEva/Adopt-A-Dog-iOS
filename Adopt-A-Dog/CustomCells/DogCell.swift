//
//  DogCell.swift
//  Adopt-A-Dog
//
//  Created by Þórkatla Eva Víkingsdóttir on 07/05/2020.
//  Copyright © 2020 Þórkatla Eva Víkingsdóttir. All rights reserved.
//

import UIKit

class DogCell: UITableViewCell {
    
    let cellView: UIView = {
        let this = UIView()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.backgroundColor = Color.darkGreen()
        this.layer.cornerRadius = 20.0
        this.accessibilityScroll(.up)
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
    
    let dogImage: UIImageView = {
        let this = UIImageView()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.image = UIImage(named: Image.UploadLogo)
        this.layer.cornerRadius = 10
        this.clipsToBounds = true
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
    
    let heartButton: UIButton = {
        let this = UIButton()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.setImage(#imageLiteral(resourceName: "favorites32"), for: .normal)
        this.addTarget(self, action: #selector(handleMarkAsFavorites), for: .touchUpInside)
        return this
    }()
    
    @objc
    func handleMarkAsFavorites() {
        print("marking as favorite")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setView()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setView() {
        contentView.backgroundColor = Color.lightGreen()
        contentView.addSubview(cellView)
        cellView.addSubview(dogImage)
        cellView.addSubview(stackView)
        stackView.addArrangedSubview(dogName)
        stackView.addArrangedSubview(dogAge)
        stackView.addArrangedSubview(dogRace)
        cellView.addSubview(heartButton)
        
        
    }
    
    func setLayout() {
        NSLayoutConstraint.activate([
            
            cellView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            cellView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            cellView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            
            dogImage.centerYAnchor.constraint(equalTo: cellView.centerYAnchor),
            dogImage.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 10),
            dogImage.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 5),
            dogImage.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -10),
            //        dogImage.heightAnchor.constraint(equalToConstant: 80),
            dogImage.widthAnchor.constraint(equalToConstant: 110),
            
            stackView.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: dogImage.trailingAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -10),
            stackView.trailingAnchor.constraint(equalTo: heartButton.leadingAnchor, constant: -10),
            
            heartButton.centerYAnchor.constraint(equalTo: cellView.centerYAnchor),
            heartButton.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -10),
            heartButton.heightAnchor.constraint(equalToConstant: 50),
            heartButton.widthAnchor.constraint(equalTo: heartButton.heightAnchor),
            
        ])
    }
    
    func setDog(dog:Dog) {
        dogName.text = "Name: \(dog.dogName ?? "No name")"
        dogAge.text = "Age: \(dog.dogAge ?? "No age")"
        dogRace.text = "Race: \(dog.dogRace ?? "No race")"
        
    }

}
