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
    let dateFormatter = NSDateFormatter()
    
    let email = NSUserDefaults.standardUserDefaults().stringForKey("email")
    let name = NSUserDefaults.standardUserDefaults().stringForKey("name")
    let appointment = PFObject(className: "Appointments")
    let query = PFQuery(className: "Appointments")
    
    //Set Appointments
    func parseInputter(appointmentWithName: String, appointmentWithEmail: String, hasAppointmentAccepted: Bool, dateOfAppointment: NSDate, modOfAppointment: Int) -> Bool {
        
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
                print("WINNER!!!!!!")
                success1 = true
            } else {
                // There was a problem, check error.description
            success1 = false
            }
        }
        return success1
    }
    
       /* EXAMPLE OF GETTING APPOINTMENT
       if let appointmentData = appointmentInfo(10, selectedDate) {
        appointmentSetByName
        appointmentSetByEmail
        appointmentWithName
        appointmentWithEmail
        hasAppointmentAccepted
        dateOfAppointment
        modOfAppointment
        lastUpdatedAt
    ILTSelectorView Data:
    let appointments = [
    
    [appointmentSetByName, appointmentSetByEmail, appointmentWithName, appointmentWithEmail, hasAppointmentAccepted, dateOfAppointment, modOfAppointment, lastUpdatedAt],
    []
    
    ]
    }
    */
    
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

    func getNames(completion: (nameList: [String]) -> Void){
        let nameQuery = PFQuery(className: "validationImages")
        
        print(name!)
        
        nameQuery.whereKey("CREW", equalTo: name!)
        nameQuery.orderByAscending("Student")
        var nameOfStudent: String = ""
         var listOfStudents: [String] = []
        
        nameQuery.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            print("Checkpoint 1")
            if error == nil {
                print("Checkpoint 2")
                for object in objects! {
                    print("Checkpoint 3")
                    nameOfStudent = String(object.objectForKey("Student")!)
                    listOfStudents.append(nameOfStudent)
                }
                
            }
            else {
                print("Can't access mod data")
                print(error)
            }
            print("Checkpoint 4")
            completion(nameList: listOfStudents)
        }
    }
    
    func findPeepsOnILT(currentMod: String){
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
