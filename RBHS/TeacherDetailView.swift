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
    var imageView : UIImageView = UIImageView(frame:CGRectMake(0, 160, 720, 400));
    var isHelper = Bool()
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var helperLabel: UILabel!
    @IBOutlet var topicLabel: UILabel!
    @IBOutlet var pictureLabel: UILabel!
    
    
    @IBOutlet var acceptButton: UIButton!
    @IBOutlet var denyButton: UIButton!
    
    
    @IBAction func acceptButton(sender: AnyObject) {
        print("Accepted")
        let query = PFQuery(className: "validationImages")
        print(studentName)
        query.whereKey("Student", equalTo: studentName)
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil{
                print(objects!)
                for object in objects! {
                    object.deleteInBackground()
                }
            }
            else{
                print(error)
            }
        }
        //Add points to Student's score
        self.findOldPoints()
        
    } 
    
    func findOldPoints(){
        var oldPoints = Int()
        let pointsQuery = PFQuery(className: "ELPoints")
        pointsQuery.whereKey("Student", equalTo: studentName)
        pointsQuery.orderByAscending("Student")
        pointsQuery.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                
                for object in objects! {
                    oldPoints = object["Points"] as! Int
                    print(oldPoints)
                    self.addPoints(oldPoints)
                    print(oldPoints)
                }
                
            }
            else {
                print("Can't access mod data")
                print(error)
            }
            
        }

    }
    
    func addPoints(oldpoints: Int){
        var pointsOfStudent = Int()
        if self.isHelper{
            pointsOfStudent = oldpoints + 100
            //saving to Parse
            let ELPoints = PFObject(className: "ELPoints")
            ELPoints.setObject(studentName, forKey: "Student")
            ELPoints.setObject(pointsOfStudent, forKey: "Points")
            ELPoints.saveInBackgroundWithBlock { (succeeded, error) -> Void in
                if succeeded {
                    print("Object Uploaded")
                } else {
                    print("Error: \(error) \(error!.userInfo)")
                }
            } //Ends Here
        }
        else{
            pointsOfStudent = oldpoints + 50
            print(pointsOfStudent)
            //saving to Parse
            let ELPoints = PFObject(className: "ELPoints")
            ELPoints.setObject(studentName, forKey: "Student")
            ELPoints.setObject(pointsOfStudent, forKey: "Points")
            ELPoints.saveInBackgroundWithBlock { (succeeded, error) -> Void in
                if succeeded {
                    print("Object Uploaded")
                } else {
                    print("Error: \(error) \(error!.userInfo)")
                }
            } //Ends Here
            
        }
    }
    
    @IBAction func denyButton(sender: AnyObject) {
        print("Denied")
        let query = PFQuery(className: "validationImages")
        print(studentName)
        query.whereKey("Student", equalTo: studentName)
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil{
                print(objects!)
               for object in objects! {
                   object.deleteInBackground()
                }
            }
            else{
                print(error)
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
        self.getInfo("Harry Potter")
        
        acceptButton.hidden = true
        denyButton.hidden = true
        nameLabel.hidden = true
        helperLabel.hidden = true
        topicLabel.hidden = true
        pictureLabel.hidden = true
        imageView.hidden = true
        //print("Detail View Loaded-Image of:")
        //self.getInfo("Harry Potter")
        //print("Harold Potter")
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "changeStudent:", name: "StudentChange", object: nil)
        
        
        
        
    }
    
    func changeStudent(notification: NSNotification) {
        //let mod = notification.userInfo!["Mod"]
        let studentname = notification.userInfo!["Name"]
        print(studentname!)
        getInfo(String(studentname!))
        studentName = String(studentname!)
        
        acceptButton.hidden = false
        denyButton.hidden = false
        nameLabel.hidden = false
        helperLabel.hidden = false
        topicLabel.hidden = false
        pictureLabel.hidden = false
        imageView.hidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
   
    
    func getInfo(studentName: String){
        let imageQuery = PFQuery(className: "validationImages")
        //var studentName: String = ""
        var helperName: String = ""
        var topicName: String = ""
        //var isHelper: Bool = false
        
        imageQuery.whereKey("Student", equalTo: studentName)
        imageQuery.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                for object in objects! {
                    let studyingPic = object["Image"] as! PFFile

                    helperName = object["helperName"] as! String
                    topicName = object["Topic"] as! String
                    self.isHelper = object["isHelper"] as! Bool
                    
                    studyingPic.getDataInBackgroundWithBlock {
                        (imageData: NSData?, error: NSError?) -> Void in
                        if error == nil {
                            self.image = UIImage(data:imageData!)
                            self.displayImage(self.image!, name: studentName, isHelper: self.isHelper, helperName: helperName, topic: topicName)
                            
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
        var helperText:String = ""
        
        //Image view
        imageView.image = image
        self.view.addSubview(imageView)
        
        //Name label
        let nameLabelText = "Name: " + name
        nameLabel.text = nameLabelText
        
        //Recieved Help from/Helped label
        if isHelper{
            helperText = "Helped: " + helperName
        }
        else{
            helperText = "Recieved help from: " + helperName
        }
        helperLabel.text = helperText
        
        
        //Topic label
        let topicLabelText = "Topic: " + topic
        topicLabel.text = topicLabelText
        
        //Picture label
        pictureLabel.text = "Picture:"

    }
   
    
    
}
