//
//  AppConfig.swift
//  Parking System
//
//  Created by Mahesh Muthusamy on 29/03/17.
//  Copyright © 2017 Mahesh Muthusamy. All rights reserved.
//

import UIKit

class AppConfig: NSObject {

    // Web Service Settings
    struct URLStrings{
        static let host = "172.24.144.160:8080"
        static let appBaseURL = "http://\(host)"
        static let loginURL = "\(appBaseURL)/user/validate"
        static let registerURL = "\(appBaseURL)/user/insert"
        static let getUserInfoURL = "\(appBaseURL)/user/get/"
        static let addMoneyURL = "\(appBaseURL)/user/wallet/update"
        static let addVehicleURL = "\(appBaseURL)/user/add/vehicle"
        static let getHistoryURL = "\(appBaseURL)/transaction/getList/"
    }
    
    // HTTP Header strings
    struct HTTPHeader {
        static let contentTypeKey = "Accept"
        static let contentTypeValue = "application/json"
    }
    
    struct Strings {
        static let error = "Error"
        static let success = "Success"
        static let warning = "Warning!!!"
        static let loginFailed = "Login Failed"
        static let usernameEmpty = "Username is Empty"
        static let passwordEmpty = "Password is Empty"
        static let firstnameEmpty = "Firstname is Empty"
        static let lastnameEmpty = "Lastname is Empty"
        static let currentPasswordEmpty = "Current Password is Empty"
        static let newPasswordEmpty = "New Password is Empty"
        static let confirmPasswordEmpty = "Confirm Password is Empty"
        static let mobileNumberEmpty = "Mobile Number is Empty"
        static let emailNotValid = "Enter a valid email address"
        static let emailEmpty = "Email Id is Empty"
        static let passwordMismatch = "Password and Confirm password are not matching"
        static let regNumberEmpty = "Registration Number is Empty"
        static let amountAdded = "Amount added to wallet successfully"
        static let vehicleAdded = "Vehicle added successfully"
    }
}
