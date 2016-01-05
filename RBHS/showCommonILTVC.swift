//
//  CommonILTVC.swift
//  RBHS
//
//  Created by Emre Cakir on 12/30/15.
//  Copyright © 2015 Coding Empire. All rights reserved.
//

import UIKit
import Parse

class showCommonILTVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var date = ""
    let email = NSUserDefaults.standardUserDefaults().stringForKey("email")
    let name = NSUserDefaults.standardUserDefaults().stringForKey("name")
    var ILTMods:[String : [Int]] = ["Monday": []]
    var selectedRaw:[String] = []
    var selected:[String] = []
    var selectedEmails:[String: String] = ["Name": "Email"]
    var selectedEmailArray:[String] = []
    var availableMods:[String] = []
    var allSchedules:[String: [PFObject]] = ["monday": [], "tuesday": [], "wednesday": [], "thursday": [], "friday": []]
    
    override func viewDidLoad() {
        let outDataILT = NSUserDefaults.standardUserDefaults().dataForKey("ILT")
        ILTMods = NSKeyedUnarchiver.unarchiveObjectWithData(outDataILT!)! as! [String : [Int]]
        availableMods.removeAll()
        allSchedules = ["monday": [], "tuesday": [], "wednesday": [], "thursday": [], "friday": []]
        selected.removeAll()
        tableView.reloadData()
        for var g = 0; g < selectedRaw.count; g++ {
            if let range = selectedRaw[g].rangeOfString(":") {
                let firstPart = selectedRaw[g][selectedRaw[g].startIndex..<range.startIndex]
                selected.append(firstPart)
                let secondPart = selectedRaw[g][range.startIndex.advancedBy(2)..<selectedRaw[g].endIndex]
                selectedEmailArray.append(secondPart)
            }
        }
        //DOWNLOAD SELECTED SCHEDULES
        downloadSchedules()
    }
    
    
    func downloadSchedules() {
        let dayNames = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
        var loopCount = 0
        for var i = 0; i < dayNames.count; i++ {
                //START STUDENT FIND
                let query = PFQuery(className: dayNames[i].lowercaseString + "Schedule")
                query.whereKey("email", containedIn:selectedEmailArray)
                query.findObjectsInBackgroundWithBlock {
                    (objects: [PFObject]?, error: NSError?) -> Void in
                    
                    if error == nil{
                        if let objects = objects {
                            for object in objects {
                                let rawObjTxt = String(object)
                                if let range = rawObjTxt.rangeOfString("S") {
                                    let firstPart = rawObjTxt[rawObjTxt.startIndex.advancedBy(1)..<range.startIndex]
                                    self.allSchedules[firstPart]?.append(object)
                                }
                            }
                        }
                        loopCount++
                        if loopCount == 5 {
                            let dayNames = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
                            for var i = 0; i < dayNames.count; i++ {
                                for var b = 0; b < self.ILTMods[dayNames[i]]!.count; b++ {
                                    let mod = self.ILTMods[dayNames[i]]![b]
                                    
                                    
                                    //THIS NEEDS TO BE BROKEN IF ONE PERSON CAN'T MAKE IT
                                    for var h = 0; h < self.allSchedules[dayNames[i].lowercaseString]!.count; h++ {
                                        //print("Day: \(dayNames[i]) Mod: \(mod) Email: \(selected[h])")
                                        if self.allSchedules[dayNames[i].lowercaseString]![h]["g\(mod)"] as! String == "ILT" {
                                            if h == self.allSchedules[dayNames[i].lowercaseString]!.count - 1 {
                                                //THIS MOD WORKS
                                                print("Day: \(dayNames[i]) Mod: \(mod) Works for: \(self.selected[h])")
                                                self.availableMods.append("\(dayNames[i]) Mod \(mod)")
                                                self.tableView.reloadData()
                                            }
                                        } else {
                                            //STOP> Person can't fit
                                            print("Does not work")
                                            break
                                        }
                                    }
                                    //THIS NEEDS TO BE BROKEN IF ONE PERSON CAN'T MAKE IT
                                    
                                    
                                }
                            }
                        }
                        
                    } else {
                        // Log details of the failure
                        print("Error: \(error!) \(error!.userInfo)")
                    }
                }
                //END
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        selectedRaw.removeAll()
        availableMods.removeAll()
        allSchedules = ["monday": [], "tuesday": [], "wednesday": [], "thursday": [], "friday": []]
        selected.removeAll()
        selectedEmailArray.removeAll()
        tableView.reloadData()
    }
    

    @IBOutlet weak var tableView: UITableView!
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 
        return availableMods.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")! as UITableViewCell;
        
            cell.textLabel?.text = availableMods[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        //GROUP MEETING
        //self.parseInputter(self.data[indexPath.section][indexPath.row], appointmentWithEmail: self.dataRaw[self.data[indexPath.section][indexPath.row]]!, hasAppointmentAccepted: 0, dateOfAppointment: String(self.date), modOfAppointment: self.mod)
        self.dismissViewControllerAnimated(true, completion: nil)
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
