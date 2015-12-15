//
//  DetailViewController.swift
//  RBHS
//
//  Created by Mihir Dutta on 12/12/15.
//  Copyright © 2015 Coding Empire. All rights reserved.
//

import UIKit
import Parse


class DetailViewController: UIViewController {
    var student = "Mihir Dutta"
    var crew = "Mr. Overbay"
    
    @IBAction func acceptButton(sender: AnyObject) {
        print("Accepted")
    }
    
    @IBAction func denyButton(sender: AnyObject) {
        print("Denied")
    }
    
    var selectedIndex:Int = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        //student?.text = "\(selectedIndex)"
        //print(selectedIndex)
        //print("Hello")
        // add back button to the navigation bar.
        
        if splitViewController?.respondsToSelector("displayModeButtonItem") == true {
            navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem()
            navigationItem.leftItemsSupplementBackButton = true
        }
        //getInfo()
        //ParseHelper().parseInputter()
        ParseHelper().appointmentInfo()
       
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
   
    
    func getInfo(){
        
        let query = PFQuery(className:"validationImages")
        query.whereKey("Student", equalTo: "Mihir Dutta")
        
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                for object in objects! {
                    print("Start:")
                    print(String(object))
                }
            } else {
                // Log details of the failure
                print("New User")
            }
        }
        
    }
   
    
    
}
