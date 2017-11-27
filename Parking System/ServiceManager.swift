//
//  ServiceManager.swift
//  Parking System
//
//  Created by Mahesh Muthusamy on 30/03/17.
//  Copyright © 2017 Mahesh Muthusamy. All rights reserved.
//

import UIKit
import Alamofire

class ServiceManager: APIClient {

    public func login(requestEntity:LoginRequest,completionHandler: @escaping (LoginResponse?, String?) -> ()){
        
        manager.request(AppConfig.URLStrings.loginURL, method: .post, parameters: requestEntity.toJSON()?.dictionaryObject, encoding: JSONEncoding(options: []),headers :nil).validate().responseJSON { response in
            
            switch response.result {
            case .success(let value):
                do {
                    let successResponse =  try Parser.parseLoginResponse(response: value as? NSDictionary)
                    print("Response.:\(successResponse).")
                    completionHandler(successResponse,nil)
                } catch {
                    print("Response.:\(error.localizedDescription).")
                    completionHandler(nil, error.localizedDescription)
                }
            case .failure(let error):
                print("Response.:\(error.localizedDescription).")
                completionHandler(nil, error.localizedDescription)
            }
        }
    }
    
    public func register(requestEntity:RegistrationRequest,completionHandler: @escaping (LoginResponse?, String?) -> ()){
        
        manager.request(AppConfig.URLStrings.registerURL, method: .post, parameters: requestEntity.toJSON()?.dictionaryObject, encoding: JSONEncoding(options: []),headers :nil).validate().responseJSON { response in
            
            switch response.result {
            case .success(let value):
                do {
                    let successResponse =  try Parser.parseLoginResponse(response: value as? NSDictionary)
                    print("Response.:\(successResponse).")
                    completionHandler(successResponse,nil)
                } catch {
                    print("Response.:\(error.localizedDescription).")
                    completionHandler(nil, error.localizedDescription)
                }
            case .failure(let error):
                print("Response.:\(error.localizedDescription).")
                completionHandler(nil, error.localizedDescription)
            }
        }
    }
    
    public func getUserInfo(completionHandler: @escaping (UserInfo?, String?) -> ()) {
        
        let url = AppConfig.URLStrings.getUserInfoURL + "\(CommonUtility.getUserId())"
        manager.request(url, method: .get, parameters: nil, encoding: JSONEncoding(options: []),headers :nil).validate().responseJSON { response in
            
            switch response.result {
            case .success(let value):
                do {
                    let successResponse =  try Parser.parseUserInfo(response: value as? NSDictionary)
                    print("Response.:\(successResponse).")
                    completionHandler(successResponse,nil)
                } catch {
                    print("Response.:\(error.localizedDescription).")
                    completionHandler(nil, error.localizedDescription)
                }
            case .failure(let error):
                print("Response.:\(error.localizedDescription).")
                completionHandler(nil, error.localizedDescription)
            }
        }
    }
    
    public func addMoney(requestEntity:WalletRequest,completionHandler: @escaping (Bool?, String?) -> ()){
        
        manager.request(AppConfig.URLStrings.addMoneyURL, method: .post, parameters: requestEntity.toJSON()?.dictionaryObject, encoding: JSONEncoding(options: []),headers :nil).validate().responseJSON { response in
            
            switch response.result {
            case .success(let value):
                do {
                    let successResponse =  try Parser.parseAddMoneyResponse(response: value as? NSDictionary)
                    print("Response.:\(successResponse).")
                    completionHandler(successResponse,nil)
                } catch {
                    print("Response.:\(error.localizedDescription).")
                    completionHandler(nil, error.localizedDescription)
                }
            case .failure(let error):
                print("Response.:\(error.localizedDescription).")
                completionHandler(nil, error.localizedDescription)
            }
        }
    }

    public func addVehicle(requestEntity:AddVehicleRequest,completionHandler: @escaping (Bool?, String?) -> ()){
        
        manager.request(AppConfig.URLStrings.addVehicleURL, method: .post, parameters: requestEntity.toJSON()?.dictionaryObject, encoding: JSONEncoding(options: []),headers :nil).validate().responseJSON { response in
            
            switch response.result {
            case .success(let value):
                do {
                    let successResponse =  try Parser.parseAddMoneyResponse(response: value as? NSDictionary)
                    print("Response.:\(successResponse).")
                    completionHandler(successResponse,nil)
                } catch {
                    print("Response.:\(error.localizedDescription).")
                    completionHandler(nil, error.localizedDescription)
                }
            case .failure(let error):
                print("Response.:\(error.localizedDescription).")
                completionHandler(nil, error.localizedDescription)
            }
        }
    }
    
    public func getHistory(completionHandler: @escaping ([History]?, String?) -> ()) {
        
        let url = AppConfig.URLStrings.getHistoryURL + "\(CommonUtility.getUserId())"
        manager.request(url, method: .get, parameters: nil, encoding: JSONEncoding(options: []),headers :nil).validate().responseJSON { response in
            
            switch response.result {
            case .success(let value):
                do {
                    let successResponse =  try Parser.parseHistory(response: value as? NSDictionary)
                    print("Response.:\(successResponse).")
                    completionHandler(successResponse,nil)
                } catch {
                    print("Response.:\(error.localizedDescription).")
                    completionHandler(nil, error.localizedDescription)
                }
            case .failure(let error):
                print("Response.:\(error.localizedDescription).")
                completionHandler(nil, error.localizedDescription)
            }
        }
    }
}
