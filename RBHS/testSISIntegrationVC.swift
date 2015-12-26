//
//  testSISIntegrationVC.swift
//  RBHS
//
//  Created by Emre Cakir on 12/24/15.
//  Copyright © 2015 Coding Empire. All rights reserved.
//

import UIKit

class testSISIntegration: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if(UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Phone) {
            self.navigationItem.title = ""
        }
    }
    
    @IBAction func loadTestData(sender: AnyObject) {
        
        let schedule:[String : [Int : String]] = [
            "Monday": [1: "ILT", 2: "ILT", 3: "Potions", 4: "Potions", 5: "Defence Against the Dark Arts", 6: "ILT", 7: "Herbology", 8: "Herbology", 9: "Muggle Studies", 10: "Muggle Studies", 11: "Magical Theory", 12: "Magical Theory", 13: "Magical Theory", 14: "Arithmancy", 15: "Arithmancy"],
            "Tuesday": [1: "Defence Against the Dark Arts", 2: "Defence Against the Dark Arts", 3: "Muggle Studies", 4: "ILT", 5: "Herbology", 6: "Herbology", 7: "ILT", 8: "ILT", 9: "ILT", 10: "Potions", 11: "Potions", 12: "Magical Theory", 13: "Magical Theory", 14: "Arithmancy", 15: "Arithmancy"],
            "Wednesday": [1: "ILT", 2: "Herbology", 3: "Herbology", 4: "ILT", 5: "Potions", 6: "Potions", 7: "ILT", 8: "ILT", 9: "Magical Theory", 10: "Magical Theory", 11: "Defence Against the Dark Arts", 12: "Defence Against the Dark Arts", 13: "ILT", 14: "Muggle Studies", 15: "Muggle Studies"],
            "Thursday": [1: "Arithmancy", 2: "Arithmancy", 3: "Muggle Studies", 4: "Muggle Studies", 5: "ILT", 6: "ILT", 7: "Herbology", 8: "Herbology", 9: "ILT", 10: "ILT", 11: "Magical Theory", 12: "Magical Theory", 13: "Magical Theory", 14: "Magical Theory", 15: "Magical Theory"],
            "Friday": [1: "Muggle Studies", 2: "Muggle Studies", 3: "ILT", 4: "ILT", 5: "ILT", 6: "ILT", 7: "ILT", 8: "ILT", 9: "Herbology", 10: "Herbology", 11: "Arithmancy", 12: "Arithmancy", 13: "Arithmancy", 14: "Muggle Studies", 15: "Muggle Studies"]
        ]
        
        let ILTMods: [String : [Int]] = ["Monday":[1,2,6], "Tuesday": [4,7,8,9], "Wednesday": [1,4,7,8,13], "Thursday": [5,6,9,10], "Friday": [3,4,5,6,7,8]]
        
        let data = NSKeyedArchiver.archivedDataWithRootObject(schedule)
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: "schedule")
        let dataILT = NSKeyedArchiver.archivedDataWithRootObject(ILTMods)
        NSUserDefaults.standardUserDefaults().setObject(dataILT, forKey: "ILT")
        let name = "Newt Scamander"
        NSUserDefaults.standardUserDefaults().setValue(name, forKey: "name")
        let email = "newtcamander@hogwarts.edu"
        NSUserDefaults.standardUserDefaults().setValue(email, forKey: "email")
        self.performSegueWithIdentifier("startApp", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
