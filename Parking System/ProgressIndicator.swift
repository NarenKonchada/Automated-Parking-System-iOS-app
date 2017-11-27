//
//  ProgressIndicator.swift
//  GRT Jewels
//
//  Created by Mahesh Muthusamy on 10/02/17.
//  Copyright © 2017 GRT. All rights reserved.
//

import Foundation
import SVProgressHUD

/// Activity indicator to show when there are time consuming task
class ProgressIndicator {
    
    static let sharedInstance = ProgressIndicator()
    private init(){
        configureIndicator()}
    
    /** Configures the style of the indicator.You can set color of the indicator, ring radius, ring thickness, Mask style, etc. */
    private func configureIndicator(){
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
    }
    
    /** Use this method to  show the activity indicator from  UIViewContollers/UIView */
    public func showIndicator(){
        SVProgressHUD.show()
    }
    
    /** Use this method to  hide the activity indicator from  UIViewContollers/UIView */
    public func hideIndicator(){
        SVProgressHUD.dismiss()
    }
    
    /** Function to find the visibility of progress indicator.
     - returns : A boolean for visibility of indicator */
    public func isVisible()->Bool{
        return SVProgressHUD.isVisible()
    }
}

