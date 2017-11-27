//
//  UserInfo.swift
//  Parking System
//
//  Created by Mahesh Muthusamy on 30/03/17.
//  Copyright © 2017 Mahesh Muthusamy. All rights reserved.
//

import UIKit
import SwiftyJSON

class UserInfo: NSObject {

    var email:String
    var userId:String
    var firstname:String
    var lastname:String
    var username:String
    var wallet:String
    var mobileNumber:String
    var useWallet:Int
    var vehicleDetails:[VehicleDetails]
    
    override init() {
        self.email = ""
        self.userId = ""
        self.firstname = ""
        self.lastname = ""
        self.username = ""
        self.wallet = ""
        self.mobileNumber = ""
        self.useWallet = 0
        self.vehicleDetails = []
        super.init()
    }
    
    init(json: JSON) {
        self.email = json["email_id"].stringValue
        self.userId = json["user_id"].stringValue
        self.firstname = json["first_name"].stringValue
        self.lastname = json["last_name"].stringValue
        self.username = json["username"].stringValue
        self.wallet = json["wallet"].stringValue
        self.mobileNumber = json["phone_number"].stringValue
        self.useWallet = json["use_wallet"].intValue
        
        var details:[VehicleDetails] = []
        for vehicleDetail in json["vehicle_details"].arrayValue {
            details.append(VehicleDetails.init(json: vehicleDetail))
        }
        self.vehicleDetails = details
        
    }
    
}
