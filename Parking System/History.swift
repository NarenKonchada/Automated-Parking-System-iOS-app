//
//  History.swift
//  Parking System
//
//  Created by Mahesh Muthusamy on 01/04/17.
//  Copyright © 2017 Mahesh Muthusamy. All rights reserved.
//

import UIKit
import SwiftyJSON

class History: NSObject {

    var regNumber:String
    var startTime:String
    var endTime:String
    var amount:String
    var vehicleType:String
    
    override init() {
        self.regNumber = ""
        self.startTime = ""
        self.endTime = ""
        self.amount = ""
        self.vehicleType = ""
        super.init()
    }
    
    init(json: JSON) {
        self.regNumber = json["reg_no"].stringValue
        self.startTime = json["starttime"].stringValue
        self.endTime = json["endtime"].stringValue
        self.amount = json["amount"].stringValue
        self.vehicleType = json["vehicle_type"].stringValue
    }

}
