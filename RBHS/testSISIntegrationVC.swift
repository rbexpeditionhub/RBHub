//
//  testSISIntegrationVC.swift
//  RBHS
//
//  Created by Emre Cakir on 12/24/15.
//  Copyright © 2015 Coding Empire. All rights reserved.
//

import UIKit
import Parse

class testSISIntegration: UIViewController {
    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var teacherCode: UITextField!
    @IBOutlet weak var scheduleText: UITextField!
    
    
    let mondaySchedule = PFObject(className: "mondaySchedule")
    let tuesdaySchedule = PFObject(className: "tuesdaySchedule")
    let wednesdaySchedule = PFObject(className: "wednesdaySchedule")
    let thursdaySchedule = PFObject(className: "thursdaySchedule")
    let fridaySchedule = PFObject(className: "fridaySchedule")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
        if(UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Phone) {
            self.navigationItem.title = ""
        }
    }
    
    @IBAction func loadTestData(sender: AnyObject) {
        
        let name = nameText.text!
        var email = name.removeWhitespace().lowercaseString
        email = email + "@hogwarts.edu"

        
        var schedule:[String : [Int : String]] = [
            "Monday": [1: "ILT", 2: "ILT", 3: "Potions", 4: "Potions", 5: "Defence Against the Dark Arts", 6: "ILT", 7: "Herbology", 8: "Herbology", 9: "Muggle Studies", 10: "Muggle Studies", 11: "Magical Theory", 12: "Magical Theory", 13: "Magical Theory", 14: "Arithmancy", 15: "Arithmancy"],
            "Tuesday": [1: "Defence Against the Dark Arts", 2: "Defence Against the Dark Arts", 3: "Muggle Studies", 4: "ILT", 5: "Herbology", 6: "Herbology", 7: "ILT", 8: "ILT", 9: "ILT", 10: "Potions", 11: "Potions", 12: "Magical Theory", 13: "Magical Theory", 14: "Arithmancy", 15: "Arithmancy"],
            "Wednesday": [1: "ILT", 2: "Herbology", 3: "Herbology", 4: "ILT", 5: "Potions", 6: "Potions", 7: "ILT", 8: "ILT", 9: "Magical Theory", 10: "Magical Theory", 11: "Defence Against the Dark Arts", 12: "Defence Against the Dark Arts", 13: "ILT", 14: "Muggle Studies", 15: "Muggle Studies"],
            "Thursday": [1: "Arithmancy", 2: "Arithmancy", 3: "Muggle Studies", 4: "Muggle Studies", 5: "ILT", 6: "ILT", 7: "Herbology", 8: "Herbology", 9: "ILT", 10: "ILT", 11: "Magical Theory", 12: "Magical Theory", 13: "Magical Theory", 14: "Magical Theory", 15: "Magical Theory"],
            "Friday": [1: "Muggle Studies", 2: "Muggle Studies", 3: "ILT", 4: "ILT", 5: "ILT", 6: "ILT", 7: "ILT", 8: "ILT", 9: "Herbology", 10: "Herbology", 11: "Arithmancy", 12: "Arithmancy", 13: "Arithmancy", 14: "Muggle Studies", 15: "Muggle Studies"]
        ]
        
        if scheduleText.text == "1" {
            schedule = [
                "Monday": [1: "ILT", 2: "ILT", 3: "Potions", 4: "Potions", 5: "Defence Against the Dark Arts", 6: "ILT", 7: "Herbology", 8: "Herbology", 9: "Muggle Studies", 10: "Muggle Studies", 11: "Magical Theory", 12: "Magical Theory", 13: "Magical Theory", 14: "Arithmancy", 15: "Arithmancy"],
                "Tuesday": [1: "Defence Against the Dark Arts", 2: "Defence Against the Dark Arts", 3: "Muggle Studies", 4: "ILT", 5: "Herbology", 6: "Herbology", 7: "ILT", 8: "ILT", 9: "ILT", 10: "Potions", 11: "Potions", 12: "Magical Theory", 13: "Magical Theory", 14: "Arithmancy", 15: "Arithmancy"],
                "Wednesday": [1: "ILT", 2: "Herbology", 3: "Herbology", 4: "ILT", 5: "Potions", 6: "Potions", 7: "ILT", 8: "ILT", 9: "Magical Theory", 10: "Magical Theory", 11: "Defence Against the Dark Arts", 12: "Defence Against the Dark Arts", 13: "ILT", 14: "Muggle Studies", 15: "Muggle Studies"],
                "Thursday": [1: "Arithmancy", 2: "Arithmancy", 3: "Muggle Studies", 4: "Muggle Studies", 5: "ILT", 6: "ILT", 7: "Herbology", 8: "Herbology", 9: "ILT", 10: "ILT", 11: "Magical Theory", 12: "Magical Theory", 13: "Magical Theory", 14: "Magical Theory", 15: "Magical Theory"],
                "Friday": [1: "Muggle Studies", 2: "Muggle Studies", 3: "ILT", 4: "ILT", 5: "ILT", 6: "ILT", 7: "ILT", 8: "ILT", 9: "Herbology", 10: "Herbology", 11: "Arithmancy", 12: "Arithmancy", 13: "Arithmancy", 14: "Muggle Studies", 15: "Muggle Studies"]
            ]
        } else if scheduleText.text == "2" {
            schedule = [
                "Monday": [1: "ILT", 2: "ILT", 3: "Potions", 4: "Potions", 5: "Defence Against the Dark Arts", 6: "ILT", 7: "ILT", 8: "ILT", 9: "Muggle Studies", 10: "Muggle Studies", 11: "Magical Theory", 12: "Magical Theory", 13: "Magical Theory", 14: "Magical Theory", 15: "Magical Theory"],
                "Tuesday": [1: "Defence Against the Dark Arts", 2: "Defence Against the Dark Arts", 3: "Muggle Studies", 4: "ILT", 5: "ILT", 6: "ILT", 7: "ILT", 8: "ILT", 9: "ILT", 10: "Potions", 11: "Potions", 12: "Magical Theory", 13: "Magical Theory", 14: "Magical Theory", 15: "Magical Theory"],
                "Wednesday": [1: "ILT", 2: "ILT", 3: "ILT", 4: "ILT", 5: "Potions", 6: "Potions", 7: "ILT", 8: "ILT", 9: "Magical Theory", 10: "Magical Theory", 11: "Defence Against the Dark Arts", 12: "Defence Against the Dark Arts", 13: "ILT", 14: "Muggle Studies", 15: "Muggle Studies"],
                "Thursday": [1: "Magical Theory", 2: "Magical Theory", 3: "Muggle Studies", 4: "Muggle Studies", 5: "ILT", 6: "ILT", 7: "ILT", 8: "ILT", 9: "ILT", 10: "ILT", 11: "Magical Theory", 12: "Magical Theory", 13: "Magical Theory", 14: "Magical Theory", 15: "Magical Theory"],
                "Friday": [1: "Muggle Studies", 2: "Muggle Studies", 3: "ILT", 4: "ILT", 5: "ILT", 6: "ILT", 7: "ILT", 8: "ILT", 9: "ILT", 10: "ILT", 11: "Magical Theory", 12: "Magical Theory", 13: "Magical Theory", 14: "Muggle Studies", 15: "Muggle Studies"]
            ]
        } else if scheduleText.text == "3" {
            schedule = [
                "Monday": [1: "ILT", 2: "ILT", 3: "Potions", 4: "Potions", 5: "ILT", 6: "ILT", 7: "ILT", 8: "ILT", 9: "Muggle Studies", 10: "Muggle Studies", 11: "Magical Theory", 12: "Magical Theory", 13: "Magical Theory", 14: "Magical Theory", 15: "Magical Theory"],
                "Tuesday": [1: "ILT", 2: "ILT", 3: "Muggle Studies", 4: "ILT", 5: "ILT", 6: "ILT", 7: "ILT", 8: "ILT", 9: "ILT", 10: "Potions", 11: "Potions", 12: "Magical Theory", 13: "Magical Theory", 14: "Magical Theory", 15: "Magical Theory"],
                "Wednesday": [1: "ILT", 2: "ILT", 3: "ILT", 4: "ILT", 5: "Potions", 6: "Potions", 7: "ILT", 8: "ILT", 9: "Magical Theory", 10: "Magical Theory", 11: "ILT", 12: "ILT", 13: "ILT", 14: "Muggle Studies", 15: "Muggle Studies"],
                "Thursday": [1: "Magical Theory", 2: "Magical Theory", 3: "Muggle Studies", 4: "Muggle Studies", 5: "ILT", 6: "ILT", 7: "ILT", 8: "ILT", 9: "ILT", 10: "ILT", 11: "Magical Theory", 12: "Magical Theory", 13: "Magical Theory", 14: "Magical Theory", 15: "Magical Theory"],
                "Friday": [1: "Muggle Studies", 2: "Muggle Studies", 3: "ILT", 4: "ILT", 5: "ILT", 6: "ILT", 7: "ILT", 8: "ILT", 9: "ILT", 10: "ILT", 11: "Magical Theory", 12: "Magical Theory", 13: "Magical Theory", 14: "Muggle Studies", 15: "Muggle Studies"]
            ]
        } else if scheduleText.text == "4" {
            schedule = [
                "Monday": [1: "ILT", 2: "ILT", 3: "Potions", 4: "Potions", 5: "Defence Against the Dark Arts", 6: "ILT", 7: "ILT", 8: "ILT", 9: "ILT", 10: "ILT", 11: "Magical Theory", 12: "Magical Theory", 13: "Magical Theory", 14: "Magical Theory", 15: "Magical Theory"],
                "Tuesday": [1: "Defence Against the Dark Arts", 2: "Defence Against the Dark Arts", 3: "ILT", 4: "ILT", 5: "ILT", 6: "ILT", 7: "ILT", 8: "ILT", 9: "ILT", 10: "Potions", 11: "Potions", 12: "Magical Theory", 13: "Magical Theory", 14: "Magical Theory", 15: "Magical Theory"],
                "Wednesday": [1: "ILT", 2: "ILT", 3: "ILT", 4: "ILT", 5: "Potions", 6: "Potions", 7: "ILT", 8: "ILT", 9: "Magical Theory", 10: "Magical Theory", 11: "Defence Against the Dark Arts", 12: "Defence Against the Dark Arts", 13: "ILT", 14: "ILT", 15: "ILT"],
                "Thursday": [1: "Magical Theory", 2: "Magical Theory", 3: "ILT", 4: "ILT", 5: "ILT", 6: "ILT", 7: "ILT", 8: "ILT", 9: "ILT", 10: "ILT", 11: "Magical Theory", 12: "Magical Theory", 13: "Magical Theory", 14: "Magical Theory", 15: "Magical Theory"],
                "Friday": [1: "ILT", 2: "ILT", 3: "ILT", 4: "ILT", 5: "ILT", 6: "ILT", 7: "ILT", 8: "ILT", 9: "ILT", 10: "ILT", 11: "Magical Theory", 12: "Magical Theory", 13: "Magical Theory", 14: "ILT", 15: "ILT"]
            ]
        } else if scheduleText.text == "5" {
            schedule = [
                "Monday": [1: "Transfiguration", 2: "Transfiguration", 3: "Potions", 4: "Potions", 5: "Defence Against the Dark Arts", 6: "Transfiguration", 7: "Transfiguration", 8: "Transfiguration", 9: "Muggle Studies", 10: "Muggle Studies", 11: "ILT", 12: "ILT", 13: "ILT", 14: "ILT", 15: "ILT"],
                "Tuesday": [1: "Defence Against the Dark Arts", 2: "Defence Against the Dark Arts", 3: "Muggle Studies", 4: "Transfiguration", 5: "Transfiguration", 6: "Transfiguration", 7: "Transfiguration", 8: "Transfiguration", 9: "Transfiguration", 10: "Potions", 11: "Potions", 12: "ILT", 13: "ILT", 14: "ILT", 15: "ILT"],
                "Wednesday": [1: "Transfiguration", 2: "Transfiguration", 3: "Transfiguration", 4: "Transfiguration", 5: "Potions", 6: "Potions", 7: "Transfiguration", 8: "Transfiguration", 9: "ILT", 10: "ILT", 11: "Defence Against the Dark Arts", 12: "Defence Against the Dark Arts", 13: "Transfiguration", 14: "Muggle Studies", 15: "Muggle Studies"],
                "Thursday": [1: "ILT", 2: "ILT", 3: "Muggle Studies", 4: "Muggle Studies", 5: "Transfiguration", 6: "Transfiguration", 7: "Transfiguration", 8: "Transfiguration", 9: "Transfiguration", 10: "Transfiguration", 11: "ILT", 12: "ILT", 13: "ILT", 14: "ILT", 15: "ILT"],
                "Friday": [1: "Muggle Studies", 2: "Muggle Studies", 3: "Transfiguration", 4: "Transfiguration", 5: "Transfiguration", 6: "Transfiguration", 7: "Transfiguration", 8: "Transfiguration", 9: "Transfiguration", 10: "Transfiguration", 11: "ILT", 12: "ILT", 13: "ILT", 14: "Muggle Studies", 15: "Muggle Studies"]
            ]
        } else if scheduleText.text == "6" {
            schedule = [
                "Monday": [1: "Astronomy", 2: "Astronomy", 3: "ILT", 4: "ILT", 5: "Defence Against the Dark Arts", 6: "Astronomy", 7: "Astronomy", 8: "Astronomy", 9: "Muggle Studies", 10: "Muggle Studies", 11: "Magical Theory", 12: "Magical Theory", 13: "Magical Theory", 14: "Magical Theory", 15: "Magical Theory"],
                "Tuesday": [1: "Defence Against the Dark Arts", 2: "Defence Against the Dark Arts", 3: "Muggle Studies", 4: "Astronomy", 5: "Astronomy", 6: "Astronomy", 7: "Astronomy", 8: "Astronomy", 9: "Astronomy", 10: "ILT", 11: "ILT", 12: "Magical Theory", 13: "Magical Theory", 14: "Magical Theory", 15: "Magical Theory"],
                "Wednesday": [1: "Astronomy", 2: "Astronomy", 3: "Astronomy", 4: "Astronomy", 5: "ILT", 6: "ILT", 7: "Astronomy", 8: "Astronomy", 9: "Magical Theory", 10: "Magical Theory", 11: "Defence Against the Dark Arts", 12: "Defence Against the Dark Arts", 13: "Astronomy", 14: "Muggle Studies", 15: "Muggle Studies"],
                "Thursday": [1: "Magical Theory", 2: "Magical Theory", 3: "Muggle Studies", 4: "Muggle Studies", 5: "Astronomy", 6: "Astronomy", 7: "Astronomy", 8: "Astronomy", 9: "Astronomy", 10: "Astronomy", 11: "Magical Theory", 12: "Magical Theory", 13: "Magical Theory", 14: "Magical Theory", 15: "Magical Theory"],
                "Friday": [1: "Muggle Studies", 2: "Muggle Studies", 3: "Astronomy", 4: "Astronomy", 5: "Astronomy", 6: "Astronomy", 7: "Astronomy", 8: "Astronomy", 9: "Astronomy", 10: "Astronomy", 11: "Magical Theory", 12: "Magical Theory", 13: "Magical Theory", 14: "Muggle Studies", 15: "Muggle Studies"]
            ]
        } else if scheduleText.text == "7" {
            schedule = [
                "Monday": [1: "ILT", 2: "ILT", 3: "ILT", 4: "ILT", 5: "ILT", 6: "ILT", 7: "ILT", 8: "ILT", 9: "ILT", 10: "ILT", 11: "ILT", 12: "ILT", 13: "ILT", 14: "ILT", 15: "ILT"],
                "Tuesday": [1: "ILT", 2: "ILT", 3: "ILT", 4: "ILT", 5: "ILT", 6: "ILT", 7: "ILT", 8: "ILT", 9: "ILT", 10: "ILT", 11: "ILT", 12: "ILT", 13: "ILT", 14: "ILT", 15: "ILT"],
                "Wednesday": [1: "ILT", 2: "ILT", 3: "ILT", 4: "ILT", 5: "ILT", 6: "ILT", 7: "ILT", 8: "ILT", 9: "ILT", 10: "ILT", 11: "ILT", 12: "ILT", 13: "ILT", 14: "ILT", 15: "ILT"],
                "Thursday": [1: "ILT", 2: "ILT", 3: "ILT", 4: "ILT", 5: "ILT", 6: "ILT", 7: "ILT", 8: "ILT", 9: "ILT", 10: "ILT", 11: "ILT", 12: "ILT", 13: "ILT", 14: "ILT", 15: "ILT"],
                "Friday": [1: "ILT", 2: "ILT", 3: "ILT", 4: "ILT", 5: "ILT", 6: "ILT", 7: "ILT", 8: "ILT", 9: "ILT", 10: "ILT", 11: "ILT", 12: "ILT", 13: "ILT", 14: "ILT", 15: "ILT"]
            ]
        }
        
        var isTeacher = false
        if teacherCode.text == "teacher" {
            isTeacher = true
        }
        
        var ILTMods: [String : [Int]] = ["Monday":[], "Tuesday": [], "Wednesday": [], "Thursday": [], "Friday": []]
        let dayNames = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
        let parseDayNames = [mondaySchedule, tuesdaySchedule, wednesdaySchedule, thursdaySchedule, fridaySchedule]
        for var i = schedule.count - 1; i >= 0; i=i-1 {
            for var h = schedule[dayNames[i]]!.count; h > 0; h=h-1 {
                print(schedule[dayNames[i]]![h])
                if schedule[dayNames[i]]![h]! == "ILT" {
                    ILTMods[dayNames[i]]?.append(h)
                }
                parseDayNames[i].setObject(schedule[dayNames[i]]![h]!, forKey: "g" + String(h))
            }
        }
        print(ILTMods)
        let query = PFQuery(className:"mondaySchedule")
        query.whereKey("email", equalTo: email)
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                for object in objects! {
                    print(object)
                    object.deleteInBackground()
                }
                self.mondaySchedule.saveInBackgroundWithBlock { (succeeded, error) -> Void in
                    if succeeded {
                        print("Object Uploaded")
                    } else {
                        print("Error: \(error) \(error!.userInfo)")
                    }
                }
            } else {
                // Log details of the failure
                print("New User")
            }
        }
        
        let query1 = PFQuery(className:"tuesdaySchedule")
        query1.whereKey("email", equalTo: email)
        query1.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                for object in objects! {
                    object.deleteInBackground()
                }
                self.tuesdaySchedule.saveInBackgroundWithBlock { (succeeded, error) -> Void in
                    if succeeded {
                        print("Object Uploaded")
                    } else {
                        print("Error: \(error) \(error!.userInfo)")
                    }
                }
            } else {
                // Log details of the failure
                print("New User")
            }
        }
        
        let query2 = PFQuery(className:"wednesdaySchedule")
        query2.whereKey("email", equalTo: email)
        query2.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                for object in objects! {
                    object.deleteInBackground()
                }
                self.wednesdaySchedule.saveInBackgroundWithBlock { (succeeded, error) -> Void in
                    if succeeded {
                        print("Object Uploaded")
                    } else {
                        print("Error: \(error) \(error!.userInfo)")
                    }
                }
            } else {
                // Log details of the failure
                print("New User")
            }
        }
        
        let query3 = PFQuery(className:"thursdaySchedule")
        query3.whereKey("email", equalTo: email)
        query3.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                for object in objects! {
                    object.deleteInBackground()
                }
                self.thursdaySchedule.saveInBackgroundWithBlock { (succeeded, error) -> Void in
                    if succeeded {
                        print("Object Uploaded")
                    } else {
                        print("Error: \(error) \(error!.userInfo)")
                    }
                }
            } else {
                // Log details of the failure
                print("New User")
            }
        }
        
        let query4 = PFQuery(className:"fridaySchedule")
        query4.whereKey("email", equalTo: email)
        query4.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                for object in objects! {
                    object.deleteInBackground()
                }
                self.fridaySchedule.saveInBackgroundWithBlock { (succeeded, error) -> Void in
                    if succeeded {
                        print("Object Uploaded")
                    } else {
                        print("Error: \(error) \(error!.userInfo)")
                    }
                }
            } else {
                // Log details of the failure
                print("New User")
            }
        }
        
        let data = NSKeyedArchiver.archivedDataWithRootObject(schedule)
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: "schedule")
        let dataILT = NSKeyedArchiver.archivedDataWithRootObject(ILTMods)
        NSUserDefaults.standardUserDefaults().setObject(dataILT, forKey: "ILT")
        let name = "Minerva McGonagall"
        NSUserDefaults.standardUserDefaults().setValue(name, forKey: "name")
        let email = "mcgonagallminerva@hogwarts.edu"
        NSUserDefaults.standardUserDefaults().setValue(email, forKey: "email")
        NSUserDefaults.standardUserDefaults().setValue(isTeacher, forKey: "isTeacher")
        
        mondaySchedule.setObject(name, forKey: "Name")
        tuesdaySchedule.setObject(name, forKey: "Name")
        wednesdaySchedule.setObject(name, forKey: "Name")
        thursdaySchedule.setObject(name, forKey: "Name")
        fridaySchedule.setObject(name, forKey: "Name")
        
        mondaySchedule.setObject(email, forKey: "email")
        tuesdaySchedule.setObject(email, forKey: "email")
        wednesdaySchedule.setObject(email, forKey: "email")
        thursdaySchedule.setObject(email, forKey: "email")
        fridaySchedule.setObject(email, forKey: "email")
        
        mondaySchedule.setObject(isTeacher, forKey: "isTeacher")
        tuesdaySchedule.setObject(isTeacher, forKey: "isTeacher")
        wednesdaySchedule.setObject(isTeacher, forKey: "isTeacher")
        thursdaySchedule.setObject(isTeacher, forKey: "isTeacher")
        fridaySchedule.setObject(isTeacher, forKey: "isTeacher")
        
        
        self.performSegueWithIdentifier("startApp", sender: self)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

extension String {
    func replace(string:String, replacement:String) -> String {
        return self.stringByReplacingOccurrencesOfString(string, withString: replacement, options: NSStringCompareOptions.LiteralSearch, range: nil)
    }
    
    func removeWhitespace() -> String {
        return self.replace(" ", replacement: "")
    }
}
