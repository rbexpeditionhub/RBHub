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
        ParseHelper().getNames() {
            (nameList: [String]) in
            self.names = nameList
            print("in asynch")
            print(self.names)
            self.tableView.reloadData()
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
            print("You selected cell number: \(indexPath.row)!")
            //dateFormatter.dateFormat = "yy-MM-dd"
            //let dayArray = dateFormatter.dateFromString("\(days[selectedButton.tag])")
            //dateFormatter.dateFormat = "EEEE"
            //let dayString1 = dateFormatter.stringFromDate(dayArray!)
            NSNotificationCenter.defaultCenter().postNotificationName(
                "StudentChange",
                object: nil,
                userInfo: ["Student": self.names[indexPath.row]]
        )
        }
        
    }//End of class
    
    // MARK:- Storyboard segue
    /*
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("tads")
        if (segue.identifier == "ShowDetailIdentifier") {
            print("t")
            var detail: DetailViewController
            if let navigationController = segue.destinationViewController as? UINavigationController {
                detail = navigationController.topViewController as! DetailViewController
            } else {
                detail = segue.destinationViewController as! DetailViewController
            }
            
            if let path = tableView.indexPathForSelectedRow {
                detail.selectedIndex = path.row + 1
                print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA")
            }
        }
    } */




