//
//  ThirdViewController.swift
//  River Bluff High School
//
//  Created by Emre Cakir on 11/20/15.
//  Copyright © 2015 Emre Cakir. All rights reserved.
//

import UIKit

class ILTSelectorVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var appointTableView: UITableView!
    
    var selectedCourseName:String = ""
    let teachersOnIlT = ["Test Teacher 1", "Test Teacher 2"]
    var appoint = ["Mihir Dutta:duttamihir@lexington1.net", "Emre Cakir:cakirmehmete@lexington1.net"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if(UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Phone) {
            self.navigationItem.title = ""
        }
        
        //NSNotificationCenter.defaultCenter().addObserver(self, selector: "refreshList:", name:"refreshMyTableView", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateILTView:", name: "ChangeILT", object: nil)
        
    }
    
    func updateILTView(notification: NSNotification) {
        /*ParseHelper().findPeeps("8")
        appoint = ParseHelper().commonPeeps
        print(appoint)*/
        self.appointTableView.reloadData()
        print("updating \(notification.userInfo!["class name"])")
    
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
            cell.textLabel?.text = teachersOnIlT[indexPath.row]
            return cell
        }
        
        let cellIdentifier = "appCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier,
            forIndexPath: indexPath)
        // Configure the cell...
        cell.textLabel?.text = appoint[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let appointWithTeacher = UITableViewRowAction(style: .Normal, title: "Meeting") { action, index in
            print("notfiyTeacher button tapped")
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
    
    
}
