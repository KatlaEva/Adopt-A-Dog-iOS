//
//  DetailsViewController.swift
//  Adopt-A-Dog
//
//  Created by Þórkatla Eva Víkingsdóttir on 11/05/2020.
//  Copyright © 2020 Þórkatla Eva Víkingsdóttir. All rights reserved.
//
import Foundation
import UIKit

class DetailsViewController: UIViewController {
    
    let detailsView = DetailsView()
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
        setupView()
        setupLayout()
        configureNavBar()
        setDog(dog: dog)
    }
    
    @objc
    func backToHomeVC() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupView() {
        view.addSubview(detailsView)
    }
    
    func setupLayout() {
        detailsView.pin(to: view)
    }

    func setDog(dog: Dog) {
        detailsView.dogNameLabel.text = dog.dogName
        detailsView.dogAgeLabel.text = "Age: \(dog.dogAge ?? "Unknown")"
        detailsView.dogBreedLabel.text = "Breed: \(dog.dogBreed ?? "Unknown")"
        detailsView.moreInfoTextView.text = dog.dogInfo
        detailsView.dogImage.image = dog.dogImage
    }
    
    func configureNavBar() {
        let navBar = UINavigationBar()
        navBar.backgroundColor = Color.lightGreen()
        let backButton = UIBarButtonItem(title: Title.back, style: .plain, target: self, action: #selector(backToHomeVC))
        navigationItem.backBarButtonItem = backButton
    }
}
