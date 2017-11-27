//
//  RegistrationViewController.swift
//  Parking System
//
//  Created by Mahesh Muthusamy on 29/03/17.
//  Copyright © 2017 Mahesh Muthusamy. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var firstnameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var useMyWallet: UISwitch!
    @IBOutlet weak var vehicleTypeTextField: UITextField!
    @IBOutlet weak var vehicleRegNumberTextField: UITextField!
    
    let serviceManager = ServiceManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func register(_ sender: Any) {
        
        guard self.validateInputs() else {
            return
        }
        
        let regRequest = RegistrationRequest()
        regRequest.email = self.emailTextField.text!
        regRequest.username = self.emailTextField.text!
        regRequest.firstname = self.firstnameTextField.text!
        regRequest.lastname = self.lastnameTextField.text!
        regRequest.mobileNumber = self.mobileTextField.text!
        regRequest.password = self.passwordTextField.text!
        
        if useMyWallet.isOn {
            regRequest.useWallet = 1
        }
        
        let vehicleDetails = VehicleDetails()
        vehicleDetails.regNumber = self.vehicleRegNumberTextField.text!
        vehicleDetails.vehicleType = self.vehicleTypeTextField.text!
        
        if let vehicleDetail = vehicleDetails.toJSON()?.dictionaryObject {
            regRequest.vehicleDetails = [vehicleDetail]
        }
        
        ProgressIndicator.sharedInstance.showIndicator()
        self.serviceManager.register(requestEntity: regRequest) { response, error in
            guard let _ = response else {
                ProgressIndicator.sharedInstance.hideIndicator()
                CommonUtility.showAlert(inView: self, withMessage: error!, messageTitle: AppConfig.Strings.error, withActions: nil)
                return
            }
            ProgressIndicator.sharedInstance.hideIndicator()
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "rootView") as! UINavigationController
            self.present(viewController, animated: true, completion: nil)
        }
        
        
    }

    func validateInputs() -> Bool {
        
        guard let email = emailTextField?.text, !email.isEmpty else {
            CommonUtility.showAlert(inView: self, withMessage: AppConfig.Strings.emailEmpty, messageTitle:AppConfig.Strings.warning , withActions: nil)
            return false
        }
        
        guard CommonUtility.isValidEmail(email) else {
            CommonUtility.showAlert(inView: self, withMessage: AppConfig.Strings.emailNotValid, messageTitle: AppConfig.Strings.warning, withActions: nil)
            return false
        }
        
        guard let firstname = firstnameTextField?.text, !firstname.isEmpty else {
            CommonUtility.showAlert(inView: self, withMessage: AppConfig.Strings.firstnameEmpty, messageTitle: AppConfig.Strings.warning, withActions: nil)
            return false
        }
        
        guard let lastname = lastnameTextField?.text, !lastname.isEmpty else {
            CommonUtility.showAlert(inView: self, withMessage: AppConfig.Strings.lastnameEmpty, messageTitle: AppConfig.Strings.warning, withActions: nil)
            return false
        }
        
        guard let mobileNumber = mobileTextField?.text, !mobileNumber.isEmpty else {
            CommonUtility.showAlert(inView: self, withMessage: AppConfig.Strings.mobileNumberEmpty, messageTitle: AppConfig.Strings.warning, withActions: nil)
            return false
        }
        
        guard let password = passwordTextField?.text, !password.isEmpty else {
            CommonUtility.showAlert(inView: self, withMessage: AppConfig.Strings.passwordEmpty, messageTitle: AppConfig.Strings.warning, withActions: nil)
            return false
        }
        
        guard let confirmPassword = confirmPasswordTextField?.text, !confirmPassword.isEmpty else {
            CommonUtility.showAlert(inView: self, withMessage: AppConfig.Strings.confirmPasswordEmpty, messageTitle: AppConfig.Strings.warning, withActions: nil)
            return false
        }
        
        guard password == confirmPassword else {
            CommonUtility.showAlert(inView: self, withMessage: AppConfig.Strings.passwordMismatch, messageTitle: AppConfig.Strings.warning, withActions: nil)
            return false
        }
        
        return true
    }
    
    @IBAction func vehicleTypeDidBeginEditing(_ sender: Any) {
        
        self.vehicleTypeTextField.resignFirstResponder()
        
        let alertController = UIAlertController.init(title: "", message: "Select the Vehicle Type", preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil)
        let twoWheeler  = UIAlertAction.init(title: "Two wheeler", style: .default, handler: { action -> Void in
            self.vehicleTypeTextField.text = "1"
        })
        let fourWheeler = UIAlertAction.init(title: "Four Wheeler", style: .default, handler: { action -> Void in
            self.vehicleTypeTextField.text = "2"
        })
        
        alertController.addAction(cancelAction)
        alertController.addAction(twoWheeler)
        alertController.addAction(fourWheeler)
        
        alertController.modalPresentationStyle = .popover
        let popOverController = alertController.popoverPresentationController
        popOverController?.sourceView = self.vehicleTypeTextField
        popOverController?.sourceRect = self.vehicleTypeTextField.bounds
        
        self.present(alertController, animated: true, completion: nil)
    }
}

extension RegistrationViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}
