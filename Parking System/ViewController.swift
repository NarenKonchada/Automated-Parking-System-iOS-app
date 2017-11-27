//
//  ViewController.swift
//  Parking System
//
//  Created by Mahesh Muthusamy on 28/03/17.
//  Copyright © 2017 Mahesh Muthusamy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let serviceManager = ServiceManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func signIn(_ sender: Any) {
        
        guard let username = usernameTextField?.text, !username.isEmpty else {
            CommonUtility.showAlert(inView: self, withMessage: AppConfig.Strings.usernameEmpty, messageTitle:AppConfig.Strings.loginFailed , withActions: nil)
            return
        }
        
        guard let password = passwordTextField?.text,  !password.isEmpty else {
            CommonUtility.showAlert(inView: self, withMessage: AppConfig.Strings.passwordEmpty, messageTitle: AppConfig.Strings.loginFailed, withActions: nil)
            return
        }
        
        self.callLoginService()
    }

    func callLoginService() {
        
        let loginRequest = LoginRequest()
        loginRequest.username = self.usernameTextField.text!
        loginRequest.password = self.passwordTextField.text!
        
        ProgressIndicator.sharedInstance.showIndicator()
        self.serviceManager.login(requestEntity: loginRequest) { response, error in
            guard let loginRes = response else {
                ProgressIndicator.sharedInstance.hideIndicator()
                CommonUtility.showAlert(inView: self, withMessage: error!, messageTitle: AppConfig.Strings.loginFailed, withActions: nil)
                return
            }
            ProgressIndicator.sharedInstance.hideIndicator()
            CommonUtility.saveUserId(loginRes.userId)
            self.performSegue(withIdentifier: "home", sender: self)
        }
    }
    
    @IBAction func register(_ sender: Any) {
        self.performSegue(withIdentifier: "register", sender: self)
    }
    
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}
