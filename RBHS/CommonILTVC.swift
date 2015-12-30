//
//  CommonILTVC.swift
//  RBHS
//
//  Created by Emre Cakir on 12/30/15.
//  Copyright © 2015 Coding Empire. All rights reserved.
//

import UIKit
import Parse

class CommonILTVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var data: [[String]] = [[], []]
    var date = ""
    var mod = 0
    let email = NSUserDefaults.standardUserDefaults().stringForKey("email")
    let name = NSUserDefaults.standardUserDefaults().stringForKey("name")
    let sectionTitles = ["Students", "Teachers"]
    var dataRaw: [String: String] = NSDictionary() as! [String : String]
    override func viewDidLoad() {
    data[0] = []
    data[1] = []
    filtered[0] = []
    filtered[1] = []
    tableView.reloadData()
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "getAllUsers:", name: "allILTUsers", object: nil)
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "getAllTeachers:", name: "allTeachers", object: nil)
    }
    
    @IBAction func findCommonILTBtn(sender: AnyObject) {
        
    }
    
    override func viewWillDisappear(animated: Bool) {
    data[0] = []
    data[1] = []
    filtered[0] = []
    filtered[1] = []
    dataRaw.removeAll()
    tableView.reloadData()
    }
    
    func getAllUsers(notification: NSNotification) {
    data[0] = []
    let data1 = notification.userInfo!["iltUsers"]! as! [[String]]
    date = notification.userInfo!["date"]! as! String
    mod = notification.userInfo!["mod"]! as! Int
    for var i = data1.count - 1; i >= 0; i = i - 1 {
    data[0].append(String(data1[i][0]))
    dataRaw[data1[i][0]] = data1[i][1]
    }
    tableView.reloadData()
    }
    
    func getAllTeachers(notification: NSNotification) {
    data[1] = []
    let data1 = notification.userInfo!["iltTeachers"]! as! [[String]]
    for var i = data1.count - 1; i >= 0; i = i - 1 {
    data[1].append(String(data1[i][0]))
    dataRaw[data1[i][0]] = data1[i][1]
    }
    tableView.reloadData()
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBAction func cancelBtn(sender: AnyObject) {
    self.dismissViewControllerAnimated(true, completion: nil)
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
    cell.textLabel?.text = filtered[indexPath.section][indexPath.row] + ": " + self.dataRaw[data[indexPath.section][indexPath.row]]!
    } else {
    cell.textLabel?.text = data[indexPath.section][indexPath.row] + ": " + self.dataRaw[data[indexPath.section][indexPath.row]]!
    }
    
    return cell;
    }
    
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    if section < sectionTitles.count {
    return sectionTitles[section]
    }
    
    return nil
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
    let appointWithTeacher = UITableViewRowAction(style: .Normal, title: "Meeting") { action, index in
    self.parseInputter(self.data[indexPath.section][indexPath.row], appointmentWithEmail: self.dataRaw[self.data[indexPath.section][indexPath.row]]!, hasAppointmentAccepted: 0, dateOfAppointment: String(self.date), modOfAppointment: self.mod)
    }
    appointWithTeacher.backgroundColor = UIColor(red:0.16, green:0.48, blue:0.27, alpha:1.0)
    
    
    return [appointWithTeacher]
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    // you need to implement this method too or you can't swipe to display the actions
    }
    
    //Set Appointments
    func parseInputter(appointmentWithName: String, appointmentWithEmail: String, hasAppointmentAccepted: Int, dateOfAppointment: String, modOfAppointment: Int) -> Bool {
    
    let appointments = PFObject(className: "Appointments")
    //Data
    appointments["appointmentSetByName"] = name
    appointments["appointmentSetByEmail"] = email
    appointments["appointmentWithName"] = appointmentWithName
    appointments["appointmentWithEmail"] = appointmentWithEmail
    appointments["hasAppointmentAccepted"] = hasAppointmentAccepted
    //yy-MM-dd
    appointments["dateOfAppointment"] = dateOfAppointment
    appointments["modOfAppointment"] = modOfAppointment
    
    var success1 = false
    appointments.saveInBackgroundWithBlock {
    (success: Bool, error: NSError?) -> Void in
    if (success) {
    print("Added Appointment")
    success1 = true
    self.tableView.reloadData()
    } else {
    // There was a problem, check error.description
    success1 = false
    }
    }
    return success1
    }
}
