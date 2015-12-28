//
//  TeacherVC.swift
//  River Bluff High School
//
//  Created by Mihir Dutta on 11/30/15.
//  Copyright © 2015 Mihir Dutta. All rights reserved.
// 

import UIKit
import Parse

class TeacherVC: UITableViewController {
    
    var names: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.refreshControl?.addTarget(self, action: "handleRefresh:", forControlEvents: UIControlEvents.ValueChanged)
    
        ParseHelper().getNames() {
            (nameList: [String]) in
            
            self.names = nameList
            self.tableView.reloadData()
            let numberOfStudents = self.names.count
            
            let tabArray = self.tabBarController?.tabBar.items as NSArray!
            let tabItem = tabArray.objectAtIndex(4) as! UITabBarItem
            tabItem.badgeValue = String(numberOfStudents)
            
        }
        
        
        
    }
    
    func handleRefresh(refreshControl: UIRefreshControl) {
        // Do some reloading of data and update the table view's data source
        // Fetch more objects from a web service, for example...
        
        // Simply adding an object to the data source for this example
        ParseHelper().getNames() {
            (nameList: [String]) in
            
            self.names = nameList
            self.tableView.reloadData()
            let numberOfStudents = self.names.count
            let tabArray = self.tabBarController?.tabBar.items as NSArray!
            let tabItem = tabArray.objectAtIndex(4) as! UITabBarItem
            tabItem.badgeValue = String(numberOfStudents)
            refreshControl.endRefreshing()
            
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CellIdentifier", forIndexPath: indexPath) 
        
        cell.selected = true
        cell.textLabel?.text = names[indexPath.row]
        
        return cell
    }
    
    var oldSelectedRow:NSIndexPath = NSIndexPath(index: 400)
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
            oldSelectedRow = indexPath
            //print("You selected cell number: \(indexPath.row)!")
            //dateFormatter.dateFormat = "yy-MM-dd"
            //let dayArray = dateFormatter.dateFromString("\(days[selectedButton.tag])")
            //dateFormatter.dateFormat = "EEEE"
            //let dayString1 = dateFormatter.stringFromDate(dayArray!)
            NSNotificationCenter.defaultCenter().postNotificationName(
                "StudentChange",
                object: nil,
                userInfo: ["Name": self.names[indexPath.row]]
        )
        }
        
    }//End of class
    
    




