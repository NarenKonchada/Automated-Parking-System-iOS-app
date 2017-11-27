//
//  ProfileViewController.swift
//  Parking System
//
//  Created by Mahesh Muthusamy on 30/03/17.
//  Copyright © 2017 Mahesh Muthusamy. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var mobileLabel: UILabel!
    @IBOutlet weak var wallet: UIButton!
    
    @IBOutlet weak var vehicleDetailTableView: UITableView!
    let serviceManager = ServiceManager()
    var userInfo = UserInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.navigationItem.hidesBackButton = true
        self.vehicleDetailTableView.dataSource = self
        self.vehicleDetailTableView.delegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        let addVehicleBtn:UIButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 40, height: 40))
        addVehicleBtn.setBackgroundImage(UIImage.init(named: "addVehicle.png"), for: .normal)
        addVehicleBtn.addTarget(self, action: #selector(ProfileViewController.addVehicleButtonClicked), for: UIControlEvents.touchUpInside)
        let addVehicleBarBtn = UIBarButtonItem(customView: addVehicleBtn)
        self.tabBarController?.navigationItem.rightBarButtonItems = [addVehicleBarBtn]
        self.tabBarController?.navigationItem.title = "MY ACCOUNT"
        self.callGetUserInfoService()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.tabBarController?.navigationItem.rightBarButtonItems = []
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func callGetUserInfoService() {
        
        ProgressIndicator.sharedInstance.showIndicator()
        self.serviceManager.getUserInfo() { response, error in
            guard let userInfo = response else {
                ProgressIndicator.sharedInstance.hideIndicator()
                CommonUtility.showAlert(inView: self, withMessage: error!, messageTitle: AppConfig.Strings.loginFailed, withActions: nil)
                return
            }
            self.userInfo = userInfo
            self.updateDetails(userInfo)
            ProgressIndicator.sharedInstance.hideIndicator()
        }
    }

    func updateDetails(_ userInfo:UserInfo) {
        
        self.nameLabel.text = userInfo.firstname + " " + userInfo.lastname
        self.emailLabel.text = userInfo.email
        self.mobileLabel.text = userInfo.mobileNumber
        self.wallet.setTitle("My Wallet : \(userInfo.wallet)", for: .normal)
        self.vehicleDetailTableView.reloadData()
    }
    
    @IBAction func addMoney(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Add Money", message: "Enter the amount", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "OK", style: .default, handler: {
            alert -> Void in
            guard let amount = alertController.textFields?[0].text else {
                return
            }
            self.callAddMoneyService(amount)
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: {
            (action : UIAlertAction!) -> Void in
        })
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter the amount"
        }
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func signOut(_ sender: Any) {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "rootView") as! UINavigationController
        self.present(viewController, animated: true, completion: nil)
    }
    
    func addVehicleButtonClicked() {
        
        let alertController = UIAlertController(title: "Add Vehicle", message: "Enter the vehicle details", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "OK", style: .default, handler: {
            alert -> Void in
            let vehicleDetail = VehicleDetails()
            guard let regNumber = alertController.textFields?[0].text, regNumber.length > 0 else {
                return
            }
            vehicleDetail.regNumber = regNumber
            
            if alertController.textFields?[1].text == "Two" {
                vehicleDetail.vehicleType = "1"
            } else {
                vehicleDetail.vehicleType = "2"
            }
            self.callAddVehicleDetailService(vehicleDetail)
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: {
            (action : UIAlertAction!) -> Void in
        })
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter the Registration Number"
        }
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter vehicle type Eg.(Two or Four)"
        }
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func callAddVehicleDetailService(_ vehicleDetails:VehicleDetails) {
        let request = AddVehicleRequest()
        request.userId = CommonUtility.getUserId()
        request.regNo = vehicleDetails.regNumber
        request.vehicleTypeId = vehicleDetails.vehicleType
        
        ProgressIndicator.sharedInstance.showIndicator()
        self.serviceManager.addVehicle(requestEntity: request) { response, error in
            guard let status = response, status else {
                ProgressIndicator.sharedInstance.hideIndicator()
                CommonUtility.showAlert(inView: self, withMessage: error!, messageTitle: AppConfig.Strings.error, withActions: nil)
                return
            }
            ProgressIndicator.sharedInstance.hideIndicator()
            CommonUtility.showAlert(inView: self, withMessage: AppConfig.Strings.vehicleAdded, messageTitle: AppConfig.Strings.success, withActions: nil)
            self.callGetUserInfoService()
        }
    }
    
    func callAddMoneyService(_ amount:String) {
        let walletRequest = WalletRequest()
        walletRequest.userId = CommonUtility.getUserId()
        walletRequest.amount = amount
        
        ProgressIndicator.sharedInstance.showIndicator()
        self.serviceManager.addMoney(requestEntity: walletRequest) { response, error in
            guard let status = response, status else {
                ProgressIndicator.sharedInstance.hideIndicator()
                CommonUtility.showAlert(inView: self, withMessage: error!, messageTitle: AppConfig.Strings.error, withActions: nil)
                return
            }
            ProgressIndicator.sharedInstance.hideIndicator()
            CommonUtility.showAlert(inView: self, withMessage: AppConfig.Strings.amountAdded, messageTitle: AppConfig.Strings.success, withActions: nil)
            self.callGetUserInfoService()
        }

    }

}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userInfo.vehicleDetails.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) 
        cell.textLabel?.text = self.userInfo.vehicleDetails[indexPath.row].regNumber
        if (self.userInfo.vehicleDetails[indexPath.row].vehicleType == "1") {
            cell.detailTextLabel?.text = "Two Wheeler"
        } else {
            cell.detailTextLabel?.text = "Four Wheeler"
        }
        
        return cell
    }
}
