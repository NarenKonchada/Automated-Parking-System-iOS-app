//
//  AddVehicleRequest.swift
//  Parking System
//
//  Created by Mahesh Muthusamy on 31/03/17.
//  Copyright © 2017 Mahesh Muthusamy. All rights reserved.
//

import UIKit
import SwiftyJSON

class AddVehicleRequest: NSObject {

    var userId:String
    var regNo:String
    var vehicleTypeId:String
    
    override init() {
        self.userId = ""
        self.regNo = ""
        self.vehicleTypeId = ""
        super.init()
    }
    
    func toJSON() -> JSON? {
        let dict:[String:Any] = ["user_id" :userId, "reg_no":regNo ,"vehicle_type_id": vehicleTypeId]
        let json = JSON.init(dict)
        
        return json
    }
}
