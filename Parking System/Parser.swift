//
//  Parser.swift
//  Parking System
//
//  Created by Mahesh Muthusamy on 30/03/17.
//  Copyright © 2017 Mahesh Muthusamy. All rights reserved.
//

import UIKit
import SwiftyJSON

class Parser: NSObject {

    static func parseLoginResponse(response:NSDictionary!) throws->LoginResponse {
        var parsedResponse = LoginResponse()
        if let successResponse = response {
            let json = JSON.init(successResponse)
            parsedResponse = LoginResponse.init(json: json)
        }
        
        return parsedResponse
    }

    static func parseUserInfo(response:NSDictionary!) throws->UserInfo {
        var parsedResponse = UserInfo()
        if let successResponse = response {
            let json = JSON.init(successResponse)
            parsedResponse = UserInfo.init(json: json)
        }
        
        return parsedResponse
    }
    
    static func parseAddMoneyResponse(response:NSDictionary!) throws->Bool {
        
        if let successResponse = response {
            let json = JSON.init(successResponse)
            if json["status"].stringValue == "Success" {
                return true
            }
        }
        
        return false
    }
    
    static func parseHistory(response:NSDictionary!) throws->[History] {
        var parsedResponse:[History] = []
        if let successResponse = response {
            let json = JSON.init(successResponse)
            var historyArray:[History] = []
            for history in json["transaction_history"]["1"].arrayValue {
                historyArray.append(History.init(json: history))
            }
            parsedResponse = historyArray
        }
        
        return parsedResponse
    }
}
