//
//  ParseHelper.swift
//  RBHS
//
//  Created by Mihir Dutta on 12/14/15.
//  Copyright © 2015 Coding Empire. All rights reserved.
//

import Foundation
import Parse



class ParseHelper  {
    var commonPeeps: [String] = []
    
    var appointmentWith = ""
    var appointmentSetBy = ""
    var monthOfAppointment = ""
    var dayOfAppointment = ""
    var modOfAppointment = ""
    
    let email = NSUserDefaults.standardUserDefaults().stringForKey("email")
    let name = NSUserDefaults.standardUserDefaults().stringForKey("name")
    let appointment = PFObject(className: "Appointments")
    let query = PFQuery(className: "Appointments")
    
    func parseInputter(){
        let appointments = PFObject(className: "Appointments")
        appointments["appointmentWith"] = "duttamihir@lexington1.net"
        appointments["appointmentSetBy"] = "cakirmehmete@lexington1.net"
        appointments["appointmentTime"] = [2,15]
        appointments.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                print("WINNER!!!!!!")
                // The object has been saved.
            } else {
                // There was a problem, check error.description
            }
        }
    }
    func appointmentInfo(){
        
        query.whereKey("appointmentWith", equalTo: email!)
        //print(email!)
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                //print("Success")
                for object in objects! {
                    //print(object)
                    self.appointmentWith = String(object.objectForKey("appointmentWith"))
                    self.appointmentSetBy = String(object.objectForKey("appointmentSetBy"))
                    let appointmentTime = object.objectForKey("appointmentTime")
                    //print(appointmentWith!)
                    //print(appointmentSetBy!)
                    //print(appointmentTime!)
                    self.monthOfAppointment = String(appointmentTime![0])
                    self.dayOfAppointment = String(appointmentTime![1])
                    self.modOfAppointment = String(appointmentTime![2])
                    
                }
            } else {
                // Log details of the failure
                print("New User")
                print(error)
            }
        }
    }
    
    func getDayOfWeek()->Int? {
        
        let formatter  = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let today: String = formatter.stringFromDate(NSDate())
        if let todayDate = formatter.dateFromString(today) {
            let myCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
            let myComponents = myCalendar.components(.Weekday, fromDate: todayDate)
            let weekDay = myComponents.weekday
            return weekDay-1
        } else {
            return nil
        }
    }

    
    func findPeeps(currentMod: String){
        let dayCase = Int(self.getDayOfWeek()!)
        var peepQuery = PFQuery(className: "mondaySchedules")
        var commonPeep: [String] = []
        var nameOfStudent = ""
        var emailOfStudent = ""
        var displayedInfo = ""
        switch (dayCase){
        case 1:
            print("Monday")
            peepQuery = PFQuery(className: "mondaySchedule")
        case 2:
            print("Tuesday")
            peepQuery = PFQuery(className: "tuesdaySchedule")
        case 3:
            print("Wednesday")
            peepQuery = PFQuery(className: "wednesdaySchedule")
        case 4:
            print("Thursday")
            peepQuery = PFQuery(className: "thursdaySchedule")
        case 5:
            print("Friday")
            peepQuery = PFQuery(className: "fridaySchedule")
        default:
            print("Blast")
        }
        
        let modClass = "g" + currentMod
        //print(modClass)
        peepQuery.whereKey(modClass, equalTo: "ILT")
        peepQuery.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                //print("Success: found mods")
                //print(objects!)
                for object in objects! {
                    //print(object)
                    nameOfStudent = String(object.objectForKey("Name")!)
                    emailOfStudent = String(object.objectForKey("email")!)
                    displayedInfo = nameOfStudent + ":" + emailOfStudent
                    //print(displayedInfo)
                    commonPeep.append(displayedInfo)
                    //print(commonPeeps)
                }
                //print(self.commonPeeps)
                self.commonPeeps = commonPeep
                NSNotificationCenter.defaultCenter().postNotificationName("refreshMyTableView", object: self.commonPeeps)
                print("Notified")
                
            }
            else {
                // Log details of the failure
                print("Can't access mod data")
                print(error)
            }
            //print(self.commonPeeps)
        }
        
       
    }
}