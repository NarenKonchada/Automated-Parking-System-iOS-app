//
//  LoginResponse.swift
//  Parking System
//
//  Created by Mahesh Muthusamy on 30/03/17.
//  Copyright © 2017 Mahesh Muthusamy. All rights reserved.
//

import UIKit
import SwiftyJSON

class LoginResponse: NSObject {

    var userId:String
    var status:String
    
    override init() {
        self.userId = ""
        self.status = ""
        super.init()
    }
    
    init(json: JSON) {
        self.userId = json["user_id"].stringValue
        self.status = json["status"].stringValue
    }
    
}
