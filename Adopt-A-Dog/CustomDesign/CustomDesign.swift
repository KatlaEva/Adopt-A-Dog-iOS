//
//  CustomTextFields.swift
//  Adopt-A-Dog
//
//  Created by Þórkatla Eva Víkingsdóttir on 05/05/2020.
//  Copyright © 2020 Þórkatla Eva Víkingsdóttir. All rights reserved.
//

import Foundation
import UIKit

class CustomTextFields: UITextField {
    let padding = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 5)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    static func styleTextField(_ textField: UITextField) {
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.setCorner(radius: 22.5)
        textField.backgroundColor = UIColor.white
    }

}
extension UIView {
    func setCorner(radius: CGFloat) {
        layer.cornerRadius = radius
        clipsToBounds = true
    }
}



