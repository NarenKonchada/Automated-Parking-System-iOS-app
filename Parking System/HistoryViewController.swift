//
//  HistoryViewController.swift
//  Parking System
//
//  Created by Mahesh Muthusamy on 30/03/17.
//  Copyright © 2017 Mahesh Muthusamy. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {

    @IBOutlet weak var historyTableView: UITableView!
    
    let serviceManager = ServiceManager()
    var history:[History] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.historyTableView.dataSource = self
        self.historyTableView.delegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tabBarController?.navigationItem.title = "PARKING HISTORY"
        self.callGetHistoryService()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func callGetHistoryService() {
        ProgressIndicator.sharedInstance.showIndicator()
        self.serviceManager.getHistory() { response, error in
            guard let historyResponse = response else {
                ProgressIndicator.sharedInstance.hideIndicator()
                CommonUtility.showAlert(inView: self, withMessage: error!, messageTitle: AppConfig.Strings.error, withActions: nil)
                return
            }
            self.history = historyResponse
            self.historyTableView.reloadData()
            ProgressIndicator.sharedInstance.hideIndicator()
        }
    }

}

extension HistoryViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.history.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyDetailCell", for: indexPath) as! HistoryDetailCell
        cell.regNumber.text = self.history[indexPath.row].regNumber
        cell.startTime.text = self.history[indexPath.row].startTime
        cell.endDate.text = self.history[indexPath.row].endTime
        if self.history[indexPath.row].vehicleType == "1" {
            cell.vehicleType.text = "Two wheeler"
        } else {
            cell.vehicleType.text = "Four wheeler"
        }
        cell.amount.text = "\u{20B9}\(self.history[indexPath.row].amount)"
        
        return cell
    }
}
