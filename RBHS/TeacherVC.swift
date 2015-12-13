//
//  ThirdViewController.swift
//  River Bluff High School
//
//  Created by Emre Cakir on 11/20/15.
//  Copyright © 2015 Mihir Dutta. All rights reserved.
// 

import UIKit
import Parse

class TeacherVC: UITableViewController {
    
    var names: [String] = ["Mihir Dutta","Emre Cakir","Three","Four","Five","Six","Seven","Eight","Nine","Ten"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    // MARK:- Storyboard segue
    
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
    }

}


