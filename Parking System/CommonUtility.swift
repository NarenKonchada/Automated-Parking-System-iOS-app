//
//  CommonUtility.swift
//  GRT Jewels
//
//  Created by Mahesh Muthusamy on 14/02/17.
//  Copyright © 2017 GRT. All rights reserved.
//

import UIKit

class CommonUtility {
    
    public static func showAlert(inView:UIViewController,withMessage: String, messageTitle:String, withActions: [UIAlertAction]?) {
        
        let presentingViewController = inView
        let alertController = UIAlertController(title: messageTitle, message: withMessage, preferredStyle: .alert)
        
        if let actions = withActions, !actions.isEmpty {
            for(_, anAlertAction) in actions.enumerated() {
                alertController.addAction(anAlertAction)
            }
        } else {
            alertController.addAction(getDefaultAlertAction())
        }
        
        presentingViewController.present(alertController, animated: true, completion: nil)
        
    }
    // Simple alert
    private static func getDefaultAlertAction()->UIAlertAction{
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        return defaultAction
    }
    
    public static func saveUserId(_ userId:String) {
        let defaults = UserDefaults.standard
        defaults.set(userId, forKey: "userId")
        defaults.synchronize()
    }
    
    public static func getUserId() -> String {
        let defaults = UserDefaults.standard
        if let userId = defaults.object(forKey: "userId") as? String {
            return userId
        }
        return ""
    }
    
    public static func saveSlotStatus(_ status:[Int]) {
        let defaults = UserDefaults.standard
        defaults.set(status, forKey: "slotStatus")
        defaults.synchronize()
    }
    
    public static func getSlotStatus() -> [Int] {
        let defaults = UserDefaults.standard
        if let status = defaults.object(forKey: "slotStatus") as? [Int] {
            return status
        }
        return [0,0,0]
    }
    
}

//MARK:- Device Details
extension CommonUtility {
    // Returns true if the current device is iPad
    public static func isiPad() -> Bool {
        if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad {
            return true
        }
        return false
    }
}

//MARK:- Validations
extension CommonUtility {
    
    public static func isValidEmail(_ email:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let predicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return predicate.evaluate(with: email)
    }
    
    static func isValid(phoneNumber: String) -> Bool {
        let charcterSet  = NSCharacterSet(charactersIn: "+0123456789").inverted
        let inputString = phoneNumber.components(separatedBy: charcterSet)
        let filtered = inputString.joined(separator: "")
        return  phoneNumber == filtered
    }
}

extension String {
    
    /** Finds length of a String */
    var length : Int {
        return self.characters.count
    }
    
}

