//
//  MyDogsView.swift
//  Adopt-A-Dog
//
//  Created by Þórkatla Eva Víkingsdóttir on 03/06/2020.
//  Copyright © 2020 Þórkatla Eva Víkingsdóttir. All rights reserved.
//

import Foundation
import UIKit

class MyDogsView: UIView {
    
    let noDogsLabel: UILabel = {
        let this = UILabel()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.heightAnchor.constraint(equalToConstant: 300).isActive = true
        this.widthAnchor.constraint(equalToConstant: 300).isActive = true
        this.text = Title.noDogsListed
        this.font = UIFont.Font.caviarDreamsBoldItalic(size: 28)
        this.numberOfLines = 0
        return this
    }()
    let emptyDogsLabel: UILabel = {
        let this = UILabel()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.heightAnchor.constraint(equalToConstant: 300).isActive = true
        this.widthAnchor.constraint(equalToConstant: 300).isActive = true
        this.text = " "
        this.font = UIFont.Font.caviarDreamsBoldItalic(size: 28)
        this.numberOfLines = 0
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
        self.addSubview(noDogsLabel)
        self.addSubview(emptyDogsLabel)
        }
        
        func setupLayout() {
            NSLayoutConstraint.activate([
                
                noDogsLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                noDogsLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            ])
        }
    
}
