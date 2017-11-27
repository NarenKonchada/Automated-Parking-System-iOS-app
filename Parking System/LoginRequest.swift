//
//  LoginRequest.swift
//  Parking System
//
//  Created by Mahesh Muthusamy on 30/03/17.
//  Copyright © 2017 Mahesh Muthusamy. All rights reserved.
//

import UIKit
import SwiftyJSON

class LoginRequest: NSObject {

    var username:String
    var password:String
    
    override init() {
        self.username = ""
        self.password = ""
        super.init()
    }
    
    init(json: JSON) {
        self.username = json["user_name"].stringValue
        self.password = json["password"].stringValue
    }
    
    func toJSON() -> JSON? {
        let dict:[String:Any] = ["user_name" :username, "password": password]
        let json = JSON.init(dict)
        
        return json
    }
}
