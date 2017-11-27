//
//  WalletRequest.swift
//  Parking System
//
//  Created by Mahesh Muthusamy on 31/03/17.
//  Copyright © 2017 Mahesh Muthusamy. All rights reserved.
//

import UIKit
import SwiftyJSON

class WalletRequest: NSObject {

    var userId:String
    var amount:String
    
    override init() {
        self.userId = ""
        self.amount = ""
        super.init()
    }
    
    init(json: JSON) {
        self.userId = json["user_id"].stringValue
        self.amount = json["amount"].stringValue
    }
    
    func toJSON() -> JSON? {
        let dict:[String:Any] = ["user_id" :userId, "amount": amount]
        let json = JSON.init(dict)
        
        return json
    }
    
}
