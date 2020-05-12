//
//  Utilities.swift
//  Adopt-A-Dog
//
//  Created by Þórkatla Eva Víkingsdóttir on 05/05/2020.
//  Copyright © 2020 Þórkatla Eva Víkingsdóttir. All rights reserved.
//

import Foundation
import UIKit

class Utilities {
    
    static func styleTextField(_ textfield: UITextField) {
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.setCorner(radius: 22.5)
        textfield.backgroundColor = UIColor.white
    }
}
