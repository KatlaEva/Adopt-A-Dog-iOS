//
//  PasswordValidation.swift
//  Adopt-A-Dog
//
//  Created by Þórkatla Eva Víkingsdóttir on 06/05/2020.
//  Copyright © 2020 Þórkatla Eva Víkingsdóttir. All rights reserved.
//

import Foundation
import UIKit

class PasswordValidation {
    
    static func isPasswordValid(_ password: String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    static func showError(_ errorLabel: UILabel, _ message: String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    static func validateFields(_ textField: UITextField) -> Bool {
        if textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return false
        }
        return true
    }
}
