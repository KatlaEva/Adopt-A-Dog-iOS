//
//  MyAccountViewController.swift
//  Adopt-A-Dog
//
//  Created by Þórkatla Eva Víkingsdóttir on 07/05/2020.
//  Copyright © 2020 Þórkatla Eva Víkingsdóttir. All rights reserved.
//

import UIKit

class MyAccountViewController: UIViewController {
    
    let topLabel: UILabel = {
        let this = UILabel()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.font = UIFont.Font.caviarDreamsBold(size: 32)
        this.text = "My account"
        return this
    }()
    
    let logoImage: UIImageView = {
        let this = UIImageView(image: UIImage(named: Image.Logo))
        this.translatesAutoresizingMaskIntoConstraints = false
        this.layer.shadowOpacity = 0.7
        this.layer.shadowRadius = 10.0
        return this
    }()
    
    let myDogsButton: UIButton = {
        let this = UIButton()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.setCorner(radius: 22.5)
        this.titleLabel?.font = UIFont.Font.caviarDreamsBold(size: 18)
        this.setTitle("My dogs", for: .normal)
        this.setTitleColor(Color.creamWhite(), for: .normal)
        this.backgroundColor = Color.darkGreen()
        this.addTarget(self, action: #selector(myDogsTapped), for: .touchUpInside)
        return this
    }()
    
    @objc
    func myDogsTapped() {
        let myDogsVC = MyDogsViewController()
        myDogsVC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(myDogsVC, animated: true)
    }
    
    let myTalesButton: UIButton = {
        let this = UIButton()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.setCorner(radius: 22.5)
        this.titleLabel?.font = UIFont.Font.caviarDreamsBold(size: 18)
        this.setTitle("My tales", for: .normal)
        this.setTitleColor(Color.creamWhite(), for: .normal)
        this.backgroundColor = Color.darkGreen()
        return this
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpLayout()
        
    }
    
    func setUpView() {
        view.backgroundColor = Color.lightGreen()
        view.addSubview(topLabel)
        view.addSubview(logoImage)
        view.addSubview(myDogsButton)
        view.addSubview(myTalesButton)
    }
    
    func setUpLayout() {
        NSLayoutConstraint.activate([
            topLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            topLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImage.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 30),
            logoImage.heightAnchor.constraint(equalToConstant: 180),
            logoImage.widthAnchor.constraint(equalTo: logoImage.heightAnchor),
            
            myDogsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            myDogsButton.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 50),
            myDogsButton.heightAnchor.constraint(equalToConstant: 45),
            myDogsButton.widthAnchor.constraint(equalToConstant: 300),
            
            myTalesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            myTalesButton.topAnchor.constraint(equalTo: myDogsButton.bottomAnchor, constant: 20),
            myTalesButton.heightAnchor.constraint(equalToConstant: 45),
            myTalesButton.widthAnchor.constraint(equalToConstant: 300),
        
        ])
    }


}
