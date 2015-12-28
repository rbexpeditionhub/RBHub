//
//  ThirdViewController.swift
//  River Bluff High School
//
//  Created by Emre Cakir on 11/20/15.
//  Copyright © 2015 Emre Cakir. All rights reserved.
//

import UIKit
import Parse

class ILTSelectorVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var teacherTableView: UITableView!
    @IBOutlet weak var appointTableView: UITableView!
    @IBAction func searchAllUsers(sender: AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName(
            "allILTUsers",
            object: nil,
            userInfo: ["iltUsers": self.allUsersOnILT])
        NSNotificationCenter.defaultCenter().postNotificationName(
            "allTeachers",
            object: nil,
            userInfo: ["iltTeachers": self.teachersOnIlT])
    }
    let email = NSUserDefaults.standardUserDefaults().stringForKey("email")
    let name = NSUserDefaults.standardUserDefaults().stringForKey("name")
    var selectedCourseName:String = ""
    var teachersOnIlT:[[String]] = []
    var allUsersOnILT:[[String]] = []
    var appoint:[[AnyObject]] = []
    
    var date = ""
    var mod: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        teachersOnIlT = []
        // Do any additional setup after loading the view, typically from a nib.
        if(UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Phone) {
            self.navigationItem.title = ""
        }
        
        //NSNotificationCenter.defaultCenter().addObserver(self, selector: "refreshList:", name:"refreshMyTableView", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateILTView:", name: "ChangeILT", object: nil)
        
    }
    
    
    func updateILTView(notification: NSNotification) {
        
        teachersOnIlT = []
        allUsersOnILT = []
        appoint = []
        appointTableView.reloadData()
        teacherTableView.reloadData()
        /*
        ParseHelper().findPeeps("8")
        appoint = ParseHelper().commonPeeps
        print(appoint)*/
        self.appointTableView.reloadData()
        
        date = String(notification.userInfo!["Date"]!)
        
        
        let dayName = notification.userInfo!["DayName"]?.lowercaseString
        mod = Int(String(notification.userInfo!["Mod"]!))!
        
        appointmentInfo(mod, currentDate: date)
        
        
        let query = PFQuery(className: dayName! + "Schedule")
        query.whereKey("g\(mod)", equalTo:"ILT")
        query.whereKey("isTeacher", equalTo: false)
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                self.allUsersOnILT = []
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) students.")
                // Do something with the found objects
                if let objects = objects {
                    for object in objects {
                        self.allUsersOnILT.append([])
                        self.allUsersOnILT[self.allUsersOnILT.count - 1].append(String(object["Name"]))
                        self.allUsersOnILT[self.allUsersOnILT.count - 1].append(String(object["email"]))
                    }
                    print(self.allUsersOnILT)
                    NSNotificationCenter.defaultCenter().postNotificationName(
                        "allILTUsers",
                        object: nil,
                        userInfo: ["iltUsers": self.allUsersOnILT])
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        let query1 = PFQuery(className: dayName! + "Schedule")
        query1.whereKey("g\(mod)", equalTo:"ILT")
        query1.whereKey("isTeacher", equalTo: true)
        query1.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                self.teachersOnIlT = []
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) teachers.")
                // Do something with the found objects
                if let objects = objects {
                    for object in objects {
                        self.teachersOnIlT.append([])
                        self.teachersOnIlT[self.teachersOnIlT.count - 1].append(String(object["Name"]))
                        self.teachersOnIlT[self.teachersOnIlT.count - 1].append(String(object["email"]))
                    }
                    NSNotificationCenter.defaultCenter().postNotificationName(
                        "allTeachers",
                        object: nil,
                        userInfo: ["iltTeachers": self.teachersOnIlT])
                    self.teacherTableView.reloadData()
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        
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
            cell.textLabel?.text = teachersOnIlT[indexPath.row][0]
            return cell
        }
        
        let cellIdentifier = "appCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier,
            forIndexPath: indexPath)
        // Configure the cell...
        if appoint[indexPath.row][1] as! String == email{
            cell.textLabel?.text = appoint[indexPath.row][2] as? String
        } else {
            cell.textLabel?.text = appoint[indexPath.row][0] as? String
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let appointWithTeacher = UITableViewRowAction(style: .Normal, title: "Meeting") { action, index in
            print("notfiyTeacher button tapped")
            self.parseInputter(self.teachersOnIlT[indexPath.row][0], appointmentWithEmail: self.teachersOnIlT[indexPath.row][1], hasAppointmentAccepted: false, dateOfAppointment: String(self.date), modOfAppointment: self.mod)
        }
        appointWithTeacher.backgroundColor = UIColor(red:0.16, green:0.48, blue:0.27, alpha:1.0)
        let notifyStudent = UITableViewRowAction(style: .Normal, title: "Help") { action, index in
            print("notifyStudent button tapped")
        }
        notifyStudent.backgroundColor = UIColor(red:0.16, green:0.48, blue:0.27, alpha:1.0)
        if (tableView.tag == 0){
            return [appointWithTeacher]
        }
        if (tableView.tag == 0){
            return [notifyStudent]
        }
        return nil
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        // you need to implement this method too or you can't swipe to display the actions
    }
    
    /*func refreshList(notification: NSNotification){
        appointTableView.reloadData()
        print("Recieved")
    }*/

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Set Appointments
    func parseInputter(appointmentWithName: String, appointmentWithEmail: String, hasAppointmentAccepted: Bool, dateOfAppointment: String, modOfAppointment: Int) -> Bool {
        
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
            } else {
                // There was a problem, check error.description
                success1 = false
            }
        }
        return success1
    }
    
    func appointmentInfo(currentMod: Int, currentDate: String){
        //[appointmentSetByName, appointmentSetByEmail, appointmentWithName, appointmentWithEmail, hasAppointmentAccepted, dateOfAppointment, modOfAppointment, lastUpdatedAt]
        //Set Query
        let userCheckOne = PFQuery(className: "Appointments")
        userCheckOne.whereKey("appointmentSetByEmail", equalTo: email!)
        let userCheckTwo = PFQuery(className: "Appointments")
        userCheckTwo.whereKey("appointmentWithEmail", equalTo: email!)
        let userCheck = PFQuery.orQueryWithSubqueries([userCheckOne, userCheckTwo])
        //Find Query
        userCheck.whereKey("modOfAppointment", equalTo: currentMod)
        userCheck.whereKey("dateOfAppointment", containsString: currentDate)
        
        userCheck.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                self.appoint.removeAll()
                //print("Success")
                for object in objects! {
                    self.appoint.append([])
                    self.appoint[self.appoint.count-1].append(String(object["appointmentSetByName"]))
                    self.appoint[self.appoint.count-1].append(String(object["appointmentSetByEmail"]))
                    self.appoint[self.appoint.count-1].append(String(object["appointmentWithName"]))
                    self.appoint[self.appoint.count-1].append(String(object["appointmentWithEmail"]))
                    self.appoint[self.appoint.count-1].append(String(object["hasAppointmentAccepted"]).toBool()!)
                    self.appoint[self.appoint.count-1].append(String(object["dateOfAppointment"]!))
                    self.appoint[self.appoint.count-1].append(Int(String(object["modOfAppointment"]))!)
                    self.appoint[self.appoint.count-1].append(object.updatedAt!)
                        //object["UpdatedAt"] as! NSDate
                }
                print(self.appoint)
                self.appointTableView.reloadData()
            } else {
                // Log details of the failure
                print(error)
            }
        }
        
    }
    
}

extension String {
    func toBool() -> Bool? {
        switch self {
        case "True", "true", "yes", "1":
            return true
        case "False", "false", "no", "0":
            return false
        default:
            return nil
        }
    }
}
