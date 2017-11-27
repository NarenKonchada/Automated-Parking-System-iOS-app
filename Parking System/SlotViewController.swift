//
//  SlotViewController.swift
//  Parking System
//
//  Created by Mahesh Muthusamy on 31/03/17.
//  Copyright © 2017 Mahesh Muthusamy. All rights reserved.
//

import UIKit

class SlotViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var slotCollectionView: UICollectionView!
    
    var slotStatus:[Int] = [0,0,0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.slotCollectionView.dataSource = self
        self.slotCollectionView.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(SlotViewController.updateSlotStatus(_:)), name: NSNotification.Name(rawValue: "SLOTSTATUS"), object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tabBarController?.navigationItem.title = "SLOT MANAGEMENT"
        self.slotStatus = CommonUtility.getSlotStatus()
        self.slotCollectionView.reloadData()
        NotificationCenter.default.addObserver(self, selector: #selector(SlotViewController.updateSlotStatus(_:)), name: NSNotification.Name(rawValue: "SLOTSTATUS"), object: nil)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "SLOTSTATUS"), object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Collection view data source methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "slotDetailCell", for: indexPath) as! SlotDetailCell
        
        
        guard indexPath.row < 3 else {
            cell.imageView.image = nil
            cell.nameLabel.text = "SLOT UNDER MAINTENANCE "
            return cell
        }
        
        cell.nameLabel.text = "SLOT \(indexPath.row+1) "
        if self.slotStatus[indexPath.row] == 1 {
            cell.imageView.image = UIImage.init(named: "car_available.jpg")
        } else {
            cell.imageView.image = UIImage.init(named: "car_unavailable.jpg")
        }
        
        return cell
    }
    
    // MARK: Collection view delegate methods
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        return CGSize(width:collectionView.frame.size.width * 0.38 , height:200)
    }
    
    func updateSlotStatus(_ notification:Notification) {
        print("\(CommonUtility.getSlotStatus())")
        self.slotStatus = CommonUtility.getSlotStatus()
        self.slotCollectionView.reloadData()
    }
}
