//
//  Validation.swift
//  RitaPaySDK
//
//  Created by Jihad Mahmoud on 01/04/2021.
//

import Foundation
import UIKit

/// Validation to PIN and PAN and Expiry date
class Validation {
    /// Singelton to access validation functions
    static let shared = Validation()
    
    /**
     Function to validate card expiry date in format YYMM
     - returns: A Bool stating the validation result
     - parameters:
        - dateString: the card expiry date string
     */
    func expiryDateValidation(dateString:String) -> Bool {
        let currentYear = Calendar.current.component(.year, from: Date()) % 100   // This will give you current year (i.e. if 2019 then it will be 19)
        let currentMonth = Calendar.current.component(.month, from: Date()) // This will give you current month (i.e if June then it will be 6)

        let enteredMonth = Int(dateString.suffix(2)) ?? 0 // get last two digit from entered string as year
        let enteredYear = Int(dateString.prefix(2)) ?? 0 // get first two digit from entered string as month

        if enteredYear > currentYear {
            if (1 ... 12).contains(enteredMonth) {
                return true
            } else {
                return false
            }
        } else if currentYear == enteredYear {
            if enteredMonth >= currentMonth {
                if (1 ... 12).contains(enteredMonth) {
                    return true
                } else {
                    return false
                }
            } else {
                return false
            }
        } else {
            return false
        }
    }
    
    /**
     Function to validate card iPIN - should be not less than 4 digits
     - returns: A Bool stating the validation result
     - parameters:
        - pinString: the card pin string
     */
    func iPinValidation(pinString: String) -> Bool {
        if pinString.count >= 4 {
            let numbers: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
            return Set(pinString).isSubset(of: numbers)
        } else {
            return false
        }
    }
    
    /**
     Function to validate card number (PAN) - should be 16 or 19 digits
     - returns: A Bool stating the validation result
     - parameters:
        - panString: the card number (PAN) string
     */
    func panValidation(panString: String) -> Bool {
        if panString.count == 16 || panString.count == 19 {
            let numbers: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
            return Set(panString).isSubset(of: numbers)
        } else {
            return false
        }
    }
    
    /**
     Function for alerting user on validation failure
     - returns: a UIAlertViewController to be presented to the user with the proper title and message
     - parameters:
        - alertType: the alert type to be returned 
     */
    func validationAlert(for alertType: AlertType) -> UIAlertController {
        let title = NSLocalizedString("Validation.Error.Title", bundle: Bundle(for: type(of: self)), comment: "The validation error title text")
        var validationAlert: UIAlertController = UIAlertController()
        let okayText = NSLocalizedString("Okay.Title", bundle: Bundle(for: type(of: self)), comment: "The Okay button title text")
        let okayAction = UIAlertAction(title: okayText, style: .default, handler: nil)
        switch alertType {
        case .pan:
            let message = NSLocalizedString("PAN.Error.Message", bundle: Bundle(for: type(of: self)), comment: "The card number (PAN) error message")
            validationAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            validationAlert.addAction(okayAction)
        case .ipin:
            let message = NSLocalizedString("PIN.Error.Message", bundle: Bundle(for: type(of: self)), comment: "The PIN error message")
            validationAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            validationAlert.addAction(okayAction)
        case .expiryDate:
            let message = NSLocalizedString("Expiry.Date.Error.Message", bundle: Bundle(for: type(of: self)), comment: "The expiry date error message")
            validationAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            validationAlert.addAction(okayAction)
        }
        return validationAlert
    }
    
    /// Enum to determine validation alert type
    enum AlertType: String {
        case pan
        case ipin
        case expiryDate
    }
}
