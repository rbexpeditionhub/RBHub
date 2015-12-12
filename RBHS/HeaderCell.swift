//
//  HeaderCell.swift
//  River Bluff High School
//
//  Created by Emre Cakir on 12/1/15.
//  Copyright © 2015 Emre Cakir. All rights reserved.
// 

import UIKit

class HeaderCell : UITableViewCell {
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBAction func addButtonAction(sender: AnyObject) {
        print("add")
    }
    var name = "" {
        didSet {
            headerLabel.text = name
            
        }
    }
    
    
}