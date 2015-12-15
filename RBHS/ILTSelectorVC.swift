//
//  ThirdViewController.swift
//  River Bluff High School
//
//  Created by Emre Cakir on 11/20/15.
//  Copyright © 2015 Emre Cakir. All rights reserved.
//

import UIKit

class ILTSelectorVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    var selectedCourseName:String = ""
    let teachersOnIlT = ["Test Teacher 1", "Test Teacher 2"]
    var appoint = ["Testing 1", "Testing 2"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if(UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Phone) {
            self.navigationItem.title = ""
        }
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateILTView:", name: "ChangeILT", object: nil)
        
    }
    
    func updateILTView(notification: NSNotification) {
        ParseHelper().findPeeps("8")
        appoint = ParseHelper().commonPeeps
        print(appoint)
        print("updating \(notification.userInfo!["class name"])")
    
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        
        if tableView.tag == 0 {
            count = teachersOnIlT.count
        } else {
            count = appoint.count
        }
        
        return count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if tableView.tag == 0{
            let cellIdentifier = "teacherCell"
            let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
            // Configure the cell...
            cell.textLabel?.text = teachersOnIlT[indexPath.row]
            return cell
        }
        
        let cellIdentifier = "appCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier,
            forIndexPath: indexPath)
        // Configure the cell...
        cell.textLabel?.text = appoint[indexPath.row]
        return cell
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
