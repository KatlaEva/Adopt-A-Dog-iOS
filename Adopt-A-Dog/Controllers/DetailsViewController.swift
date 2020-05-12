//
//  DetailsViewController.swift
//  Adopt-A-Dog
//
//  Created by Þórkatla Eva Víkingsdóttir on 11/05/2020.
//  Copyright © 2020 Þórkatla Eva Víkingsdóttir. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    let dogImage: UIImageView = {
        let this = UIImageView()
        this.translatesAutoresizingMaskIntoConstraints = false
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
        this.setImage(#imageLiteral(resourceName: "favorites32"), for: .normal)
        this.addTarget(self, action: #selector(favoritesTapped), for: .touchUpInside)
        return this
    }()
    
    @objc
    func favoritesTapped() {
        let favVC = FavoritesViewController()
        favVC.handleFavorites(dog: dog)
    
    }
    
    let stackViewHorizontal: UIStackView = {
        let this = UIStackView()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.axis = .horizontal
        this.alignment = .center
        this.distribution = .equalCentering
        this.spacing = 1
        return this
        
    }()
    
    let dogAgeLabel: UILabel = {
        let this = UILabel()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.font = UIFont.Font.caviarDreamsBold(size: 22)
        return this
    }()
    
    let dogRaceLabel: UILabel = {
        let this = UILabel()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.font = UIFont.Font.caviarDreamsBold(size: 22)
        return this
    }()
    
    let infoLabel: UILabel = {
        let this = UILabel()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.font = UIFont.Font.caviarDreamsBold(size: 26)
        this.text = "More Info"
        return this
    }()
    
    let moreInfoTextView: UITextView = {
        let this = UITextView()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.backgroundColor = Color.darkGreen()
        this.font = UIFont.Font.caviarDreamsBoldItalic(size: 16)
        this.isEditable = false
        this.sizeToFit()
        this.isScrollEnabled = true
        this.layer.cornerRadius = 10
        return this
    }()
    
    
    let dog: Dog
    
    init(dog: Dog) {
        self.dog = dog
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        setupLayout()
        configureNavBar()
        setDog(dog: dog)
    }
    
    func setupView() {
        view.backgroundColor = Color.lightGreen()
        view.addSubview(dogImage)
        view.addSubview(dogNameLabel)
        view.addSubview(favoritesButton)
        view.addSubview(stackViewHorizontal)
        stackViewHorizontal.addArrangedSubview(dogAgeLabel)
        stackViewHorizontal.addArrangedSubview(dogRaceLabel)
        view.addSubview(infoLabel)
        view.addSubview(moreInfoTextView)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            
            dogImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dogImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            dogImage.heightAnchor.constraint(equalToConstant: 200),
            dogImage.widthAnchor.constraint(equalToConstant: 200),
        
            dogNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dogNameLabel.topAnchor.constraint(equalTo: dogImage.bottomAnchor, constant: 15),
            
            favoritesButton.centerYAnchor.constraint(equalTo: dogNameLabel.centerYAnchor),
            favoritesButton.leadingAnchor.constraint(equalTo: dogNameLabel.trailingAnchor, constant: 10),
            favoritesButton.heightAnchor.constraint(equalToConstant: 50),
            favoritesButton.widthAnchor.constraint(equalTo: favoritesButton.heightAnchor),
            
            stackViewHorizontal.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackViewHorizontal.topAnchor.constraint(equalTo: dogNameLabel.bottomAnchor, constant: 20),
            stackViewHorizontal.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackViewHorizontal.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            infoLabel.topAnchor.constraint(equalTo: stackViewHorizontal.bottomAnchor, constant: 20),
            
            moreInfoTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            moreInfoTextView.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 10),
            moreInfoTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            moreInfoTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            moreInfoTextView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    func configureNavBar() {
        let navBar = UINavigationBar()
        navBar.barTintColor = Color.lightGreen()
        let backButton = UIBarButtonItem(title: "back", style: .plain, target: self, action: #selector(backToHomeVC))
        navigationItem.leftBarButtonItem = backButton
       
        
        
    }
    
    @objc
    func backToHomeVC() {
        dismiss(animated: true, completion: nil)
    }
    
    func setDog(dog: Dog) {
        dogNameLabel.text = dog.dogName
        dogAgeLabel.text = "Age: \(dog.dogAge ?? "Unknown")"
        dogRaceLabel.text = "Race: \(dog.dogRace ?? "Unknown")"
        moreInfoTextView.text = dog.dogInfo
    }
}
