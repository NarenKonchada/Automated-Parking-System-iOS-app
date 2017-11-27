//
//  RegistrationRequest.swift
//  Parking System
//
//  Created by Mahesh Muthusamy on 30/03/17.
//  Copyright © 2017 Mahesh Muthusamy. All rights reserved.
//

import UIKit
import SwiftyJSON

class RegistrationRequest: NSObject {
    
    var email:String
    var firstname:String
    var lastname:String
    var username:String
    var password:String
    var wallet:String
    var mobileNumber:String
    var useWallet:Int
    var vehicleDetails:[[String:Any]]
    
    override init() {
        self.email = ""
        self.firstname = ""
        self.lastname = ""
        self.username = ""
        self.password = ""
        self.wallet = ""
        self.mobileNumber = ""
        self.useWallet = 0
        self.vehicleDetails = []
        super.init()
    }
    
    func toJSON() -> JSON? {
        
        let dict:[String:Any] = ["user_name": username, "email_id" :email, "first_name": firstname, "last_name": lastname, "password": password, "wallet": wallet, "phone_number": mobileNumber, "use_wallet": useWallet, "vehicle_details": vehicleDetails]
        let json = JSON.init(dict)
        print("\(json)")
        return json
    }
    
}

class VehicleDetails: NSObject {
    
    var regNumber:String
    var vehicleType:String
    
    override init() {
        self.regNumber = ""
        self.vehicleType = ""
        super.init()
    }
    
    init(json: JSON) {
        self.regNumber = json["reg_no"].stringValue
        self.vehicleType = json["vehicle_type_id"].stringValue
    }
    
    func toJSON() -> JSON? {
        
        let dict:[String:Any] = ["reg_no": regNumber, "vehicle_type_id": vehicleType]
        let json = JSON.init(dict)
        
        return json
    }
}
