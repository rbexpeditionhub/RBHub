//
//  CommonILTVC.swift
//  RBHS
//
//  Created by Emre Cakir on 12/30/15.
//  Copyright © 2015 Coding Empire. All rights reserved.
//

import UIKit
import Parse

class CommonILTVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate  {
    
    var data: [[String]] = [[], []]
    var date = ""
    var mod = 0
    let email = NSUserDefaults.standardUserDefaults().stringForKey("email")
    let name = NSUserDefaults.standardUserDefaults().stringForKey("name")
    let sectionTitles = ["Students", "Teachers"]
    var dataRaw: [String: String] = NSDictionary() as! [String : String]
    var teachersOnIlT:[[String]] = []
    var allUsersOnILT:[[String]] = []
    var ILTMods:[String : [Int]] = ["Monday": []]
    var selectedRows:[String] = []

    
    
    override func viewDidLoad() {
        let outDataILT = NSUserDefaults.standardUserDefaults().dataForKey("ILT")
        ILTMods = NSKeyedUnarchiver.unarchiveObjectWithData(outDataILT!)! as! [String : [Int]]
    data[0] = []
    data[1] = []
    filtered[0] = []
    filtered[1] = []
        teachersOnIlT = []
        allUsersOnILT = []
    tableView.reloadData()
        let dayNames = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
        var dayCounter = 0
        var modCounter = 0
        for var i = 0; i < dayNames.count; i++ {
            dayCounter++
            modCounter = 0
            for var b = 0; b < ILTMods[dayNames[i]]!.count; b++ {
                modCounter++
        //START STUDENT FIND
        let query = PFQuery(className: dayNames[i].lowercaseString + "Schedule")
        query.whereKey("g\(ILTMods[dayNames[i]]![b])", equalTo:"ILT")
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil{
                // The find succeeded.
                //print("Successfully retrieved \(objects!.count) students.")
                // Do something with the found objects
                if let objects = objects {
                    for object in objects {
                        if object["Name"] as? String != self.name {
                            if object["isTeacher"] as! Bool == false{
                            self.allUsersOnILT.append([])
                            self.allUsersOnILT[self.allUsersOnILT.count - 1].append(String(object["Name"]))
                            self.allUsersOnILT[self.allUsersOnILT.count - 1].append(String(object["email"]))
                            } else {
                            
                            self.teachersOnIlT.append([])
                            self.teachersOnIlT[self.teachersOnIlT.count - 1].append(String(object["Name"]))
                            self.teachersOnIlT[self.teachersOnIlT.count - 1].append(String(object["email"]))
                            }
                        }
                    }
                }
                
                for var i = self.allUsersOnILT.count - 1; i >= 0; i = i - 1 {
                    if self.data[0].indexOf(String(self.allUsersOnILT[i][0])) == nil {
                        self.data[0].append(String(self.allUsersOnILT[i][0]))
                        self.dataRaw[self.allUsersOnILT[i][0]] = self.allUsersOnILT[i][1]
                    }
                }
                for var i = self.teachersOnIlT.count - 1; i >= 0; i = i - 1 {
                    if self.data[1].indexOf(String(self.teachersOnIlT[i][0])) == nil {
                    self.data[1].append(String(self.teachersOnIlT[i][0]))
                    self.dataRaw[self.teachersOnIlT[i][0]] = self.teachersOnIlT[i][1]
                    }
                }
                
                let goal = self.ILTMods[dayNames[dayCounter - 1]]!.count
                if dayCounter == 5  && modCounter == goal{
                    self.tableView.reloadData()
                }
                
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        //END STUDENT FIND
        }
        }
    }
    
    

    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBAction func cancelBtn(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func findCommonILTBtn(sender: AnyObject) {
        self.performSegueWithIdentifier("common", sender: self)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
            let secondViewController = segue.destinationViewController as! showCommonILTVC
            secondViewController.selectedRaw = selectedRows
            secondViewController.selectedEmails = dataRaw
    }
    
    var searchActive : Bool = false
    var filtered:[[String]] = [[],[]]
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
    searchActive = true;
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
    searchActive = false;
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
    searchActive = false;
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    searchActive = false;
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
    let options:NSStringCompareOptions = [.AnchoredSearch, .CaseInsensitiveSearch]
    filtered[0] = data[0].filter({ (text) -> Bool in
    let tmp: NSString = text
    let range = tmp.rangeOfString(searchText, options: options)
    return range.location != NSNotFound
    })
    filtered[1] = data[1].filter({ (text) -> Bool in
    let tmp: NSString = text
    let range = tmp.rangeOfString(searchText, options: options)
    return range.location != NSNotFound
    })
    
    if searchText != ""{
    searchActive = true;
    }
    if searchText == "" {
    filtered[0] = []
    filtered[1] = []
    searchActive = false
    }
    self.tableView.reloadData()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return sectionTitles.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if(searchActive) {
    return filtered[section].count
    }
    return data[section].count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell")! as UITableViewCell;
    if(searchActive){
    cell.textLabel?.text = filtered[indexPath.section][indexPath.row] + ": " + self.dataRaw[filtered[indexPath.section][indexPath.row]]!
    } else {
    cell.textLabel?.text = data[indexPath.section][indexPath.row] + ": " + self.dataRaw[data[indexPath.section][indexPath.row]]!
    }
        if selectedRows.indexOf((cell.textLabel?.text)!) != nil {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        } else {
            cell.accessoryType = UITableViewCellAccessoryType.None
        }
        
    return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        
        
                if cell!.accessoryType == UITableViewCellAccessoryType.None
                {
                    cell!.accessoryType = UITableViewCellAccessoryType.Checkmark
                    selectedRows.append((cell?.textLabel?.text)!)
                }
                else
                {
                    cell!.accessoryType = UITableViewCellAccessoryType.None
                    selectedRows.removeAtIndex(selectedRows.indexOf((cell?.textLabel?.text)!)!)
                }

    }

    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    if section < sectionTitles.count {
    return sectionTitles[section]
    }
    
    return nil
    }
    

}
