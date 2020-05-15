//
//  PasswordValidation.swift
//  Adopt-A-Dog
//
//  Created by Þórkatla Eva Víkingsdóttir on 06/05/2020.
//  Copyright © 2020 Þórkatla Eva Víkingsdóttir. All rights reserved.
//

import Foundation
import UIKit

class Validation {
    
    static func isPasswordValid(_ password: String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    static func isEmailValid(_ email: String) -> Bool {
        let emailTest = NSPredicate(format:"SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
        return emailTest.evaluate(with: email)
    }
    
    static func isTextFieldValid(_ textField: String) -> Bool {
        let fieldTested = NSPredicate(format: "SELF MATCHES %@", "^\\w{2,30}$")
        return fieldTested.evaluate(with: textField)
    }
    
    static func showError(_ errorLabel: UILabel, _ message: String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
}
