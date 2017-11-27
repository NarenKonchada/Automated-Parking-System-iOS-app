//
//  HistoryDetailCell.swift
//  Parking System
//
//  Created by Mahesh Muthusamy on 31/03/17.
//  Copyright © 2017 Mahesh Muthusamy. All rights reserved.
//

import UIKit

class HistoryDetailCell: UITableViewCell {

    @IBOutlet weak var regNumber: UILabel!
    @IBOutlet weak var endDate: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var vehicleType: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
