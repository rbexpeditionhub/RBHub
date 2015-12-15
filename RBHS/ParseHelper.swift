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
        print(email!)
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                print("Success")
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
}