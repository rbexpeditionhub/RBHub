//
//  DetailViewController.swift
//  RBHS
//
//  Created by Mihir Dutta on 12/12/15.
//  Copyright © 2015 Coding Empire. All rights reserved.
//

import UIKit
import Parse


class TeacherDetailView: UIViewController {
    var image: UIImage?
    var studentName: String = ""

    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var helperLabel: UILabel!
    @IBOutlet var topicLabel: UILabel!
    @IBOutlet var pictureLabel: UILabel!
    
    @IBOutlet var denyButton: UIButton!
    
    @IBAction func acceptButton(sender: AnyObject) {
        print("Accepted")
        //Add points to Student's score
    }
    
    @IBAction func denyButton(sender: AnyObject) {
        print("Denied")
        let query = PFQuery(className: "validationImages")
        query.whereKey("Name", equalTo: studentName)
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            for object in objects! {
                object.deleteEventually()
            }
        }
        //Do not add points to student's score
    }
    
    var selectedIndex:Int = 1

    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        if splitViewController?.respondsToSelector("displayModeButtonItem") == true {
            navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem()
            navigationItem.leftItemsSupplementBackButton = true
        }
        print("Detail View Loaded-Image of:")
        self.getInfo("Harry Potter")
        
        denyButton.hidden = true
        //print("Detail View Loaded-Image of:")
        //self.getInfo("Harry Potter")
        //print("Harold Potter")
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "changeStudent:", name: "StudentChange", object: nil)
        
        nameLabel.text = ""
        helperLabel.text = ""
        topicLabel.text = ""
        pictureLabel.text = ""
        
        
    }
    
    func changeStudent(notification: NSNotification) {
        //let mod = notification.userInfo!["Mod"]
        let studentname = notification.userInfo!["Name"]
        print(studentname!)
        getInfo(String(studentname!))
        studentName = String(studentname!)
        denyButton.hidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
   
    
    func getInfo(studentName: String){
        let imageQuery = PFQuery(className: "validationImages")
        //var studentName: String = ""
        var helperName: String = ""
        var topicName: String = ""
        var isHelper: Bool = false
        
        imageQuery.whereKey("Student", equalTo: studentName)
        imageQuery.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                for object in objects! {
                    let studyingPic = object["Image"] as! PFFile

                    helperName = object["helperName"] as! String
                    topicName = object["Topic"] as! String
                    isHelper = object["isHelper"] as! Bool
                    
                    studyingPic.getDataInBackgroundWithBlock {
                        (imageData: NSData?, error: NSError?) -> Void in
                        if error == nil {
                            self.image = UIImage(data:imageData!)
                            self.displayImage(self.image!, name: studentName, isHelper: isHelper, helperName: helperName, topic: topicName)
                            
                            }
                    }
                    
                }
                
            }
            else {
                print("Can't access mod data")
                print(error)
            }
            
        }

    }
    func displayImage(image: UIImage!, name: String, isHelper: Bool, helperName: String, topic: String){
        //Image Set
        //let screenSize: CGRect = UIScreen.mainScreen().bounds
        //let screenWidthMiddle = (screenSize.width)/2
        //let screenHeightMiddle = (screenSize.height)/2
        
        //Name label
        let nameLabel = UILabel(frame: CGRectMake(0, 0, 200, 200))
        nameLabel.center = CGPointMake(160, 284)
        nameLabel.textAlignment = NSTextAlignment.Center
        nameLabel.text = "Name: Harry Potter"
        self.view.addSubview(nameLabel)
    }
   
    
    
}
