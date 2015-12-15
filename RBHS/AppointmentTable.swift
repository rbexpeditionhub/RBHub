//
//  AppointmentTable.swift
//  RBHS
//
//  Created by Mihir Dutta on 12/14/15.
//  Copyright © 2015 Coding Empire. All rights reserved.
//

import Foundation
import UIKit

class AppointmentTable : UITableViewCell {
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBAction func addButtonAction(sender: AnyObject) {
        //print("add")
    }
    var name = "" {
        didSet {
            headerLabel.text = name
            
        }
    }
    
    
}