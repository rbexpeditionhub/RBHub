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

    
    @IBAction func acceptButton(sender: AnyObject) {
        print("Accepted")
    }
    
    @IBAction func denyButton(sender: AnyObject) {
        print("Denied")
    }
    
    var selectedIndex:Int = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        //student?.text = "\(selectedIndex)"
        //print(selectedIndex)
        //print("Hello")
        // add back button to the navigation bar.
        
        if splitViewController?.respondsToSelector("displayModeButtonItem") == true {
            navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem()
            navigationItem.leftItemsSupplementBackButton = true
        }
        print("Detail View Loaded-Image of:")
        self.getInfo("Harry Potter")
        print("Harold Potter")
        
        
       
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
   
    
    func getInfo(studentName: String){
        let imageQuery = PFQuery(className: "validationImages")
        imageQuery.whereKey("Student", equalTo: studentName)
        imageQuery.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                for object in objects! {
                    let studyingPic = object["Image"] as! PFFile
                    studyingPic.getDataInBackgroundWithBlock {
                        (imageData: NSData?, error: NSError?) -> Void in
                        if error == nil {
                            self.image = UIImage(data:imageData!)
                            self.displayImage(self.image!)
                            
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
    func displayImage(image: UIImage!){
        //Image Set
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let screenWidthMiddle = (screenSize.width)/2
        let screenHeightMiddle = (screenSize.height)/2
        
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: 0, y: 0, width: 720, height: 400)
        //view.addSubview(imageView)
        //Name label
        var nameLabel = UILabel(frame: CGRectMake(0, 0, 200, 200))
        nameLabel.center = CGPointMake(160, 284)
        nameLabel.textAlignment = NSTextAlignment.Center
        nameLabel.text = "Name: Harry Potter"
        self.view.addSubview(nameLabel)
    }
   
    
    
}
