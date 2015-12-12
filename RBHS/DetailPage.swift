//
//  DetailPage.swift
//  River Bluff High School
//
//  Created by Emre Cakir on 12/1/15.
//  Copyright © 2015 Emre Cakir. All rights reserved.
// 

import UIKit

class DetailPage: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    
    var displayString = ""
    
    override func viewDidLoad() {
        displayLabel?.text = displayString
    }
    
}