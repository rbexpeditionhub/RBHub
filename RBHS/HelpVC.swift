//
//  River Bluff High School
//
//  Created by Emre Cakir on 11/20/15.
//  Copyright © 2015 Emre Cakir. All rights reserved.
// 

import UIKit

protocol ShowDetailDelegate {
    func showDetail(displayText:String)
}


class HelpVC: UIViewController{
    let categories = ["Teachers on ILT", "Students Seeking Help", "Study Sessions"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if(UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Phone) {
            self.navigationItem.title = ""
        }

    }
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let detailPage = segue.destinationViewController as? DetailPage,
            let displayString = sender as? String {
                detailPage.displayString = displayString
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension HelpVC : UITableViewDelegate {
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCellWithIdentifier("header") as! HeaderCell
        cell.name = categories[section]
        // add a tap gesture to the section header.
        // this should be done inside the HeaderCell class,
        // but it's more convenient to have the target action in the table view
        // so you can convert the tap coordinates to a table secion.
        let tapHeader = UITapGestureRecognizer(target: self, action: "tappedOnHeader:")
        tapHeader.delegate = self
        tapHeader.numberOfTapsRequired = 1
        tapHeader.numberOfTouchesRequired = 1
        cell.contentView.addGestureRecognizer(tapHeader)
        if cell.name == "Teachers on ILT" || cell.name == "Students Seeking Help" {
            cell.addButton.hidden = true
        }
        return cell
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CGFloat(130)
    }
    
    func tappedOnHeader(gesture:UIGestureRecognizer){
        // the view that the gesture recognizer grabbed onto
        if let cellContentView = gesture.view {
            // convert tap coordinates from the section header space to the table view space
            let tappedPoint = cellContentView.convertPoint(cellContentView.bounds.origin, toView: tableView)
            // tableView.indexPathForRowAtPoint is a great method.
            // unfortunately, it does not work on section headers!
            // sadly, if you use this, it will work on every section EXCEPT for section 0 ("Action")
            //
            // one way to get around this is to brute-force it:
            // get the rectangular area of each table section header,
            // and then see if the tapped point fits inside.
            for i in 0..<tableView.numberOfSections {
                let sectionHeaderArea = tableView.rectForHeaderInSection(i)
                if CGRectContainsPoint(sectionHeaderArea, tappedPoint) {
                    print("tapped on category:: \(categories[i])")
                }
            }
        }
    }
    
}

extension HelpVC : UITableViewDataSource {
    
    //    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    //        return categories[section]
    //    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return categories.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! CategoryRow
        cell.categoryName = categories[indexPath.section]
        cell.showDetailDelegate = self
        return cell
    }
    
}

// Had to add this, even though it doesn't do anything.
extension HelpVC : UIGestureRecognizerDelegate { }

extension HelpVC : ShowDetailDelegate {
    func showDetail(displayText:String){
        performSegueWithIdentifier("ShowDetail", sender: displayText)
    }
}
    
    
    
    
    
    /* OLD Method
    
    @IBOutlet weak var iPadTeacherTableView: UITableView!
    @IBOutlet weak var iPadStudentTableView: UITableView!
    @IBOutlet weak var iPadStudySessionTableView: UITableView!
    @IBOutlet weak var iPhoneTableView: UITableView!
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if (tableView == self.iPadTeacherTableView){
            return teachers.count
        }
        if (tableView == self.iPadStudentTableView) {
            return 1
        }
        if (tableView == self.iPadStudySessionTableView){
            return 1
        }else {
            //iPhone
            return 1
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (tableView == self.iPadTeacherTableView){
            return teachers[section].count
        }
        if (tableView == self.iPadStudentTableView) {
            return studentsSeekHelp.count
        }
        if (tableView == self.iPadStudySessionTableView){
            return studySessions.count
        } else {
            //iPhone
            return 0
        }
        
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (tableView == self.iPadTeacherTableView){
            switch section{
            case 0:
                return "Your Teachers on ILT"
            case 1:
                return "All Teachers on ILT"
            default:
                return "Section"
            }
        }
        if (tableView == self.iPadStudentTableView) {
            return nil
        }
        if (tableView == self.iPadStudySessionTableView){
            return nil
        } else {
            //iPhone
            return nil
        }
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        
        switch tableView.tag{
        
        case 0:
            
            // Configure the cell...
            cell.textLabel?.text = teachers[indexPath.section][indexPath.row]
        case 1:
            // Configure the cell...
            cell.textLabel?.text = studentsSeekHelp[indexPath.row]
        case 2:
            // Configure the cell...
            cell.textLabel?.text = studySessions[indexPath.row]
        case 3:
            // Configure the cell... iPhone
            cell.textLabel?.text = "iPhone"
        default:
            cell.textLabel?.text = "default"
        }
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (tableView == self.iPadTeacherTableView){
            return CGFloat(60)
        }
        if (tableView == self.iPadStudentTableView) {
            return CGFloat(50)
        }
        if (tableView == self.iPadStudySessionTableView){
            return CGFloat(50)
        } else {
            return CGFloat(50)
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (tableView == self.iPadTeacherTableView || tableView == self.iPadStudentTableView){
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let notifyTeacher = UITableViewRowAction(style: .Normal, title: "Notify") { action, index in
            print("notfiyTeacher button tapped")
        }
        notifyTeacher.backgroundColor = UIColor(red:0.16, green:0.48, blue:0.27, alpha:1.0)
        let notifyStudent = UITableViewRowAction(style: .Normal, title: "Help") { action, index in
            print("notifyStudent button tapped")
        }
        notifyStudent.backgroundColor = UIColor(red:0.16, green:0.48, blue:0.27, alpha:1.0)
        if (tableView == self.iPadTeacherTableView){
            return [notifyTeacher]
        }
        if (tableView == self.iPadStudentTableView){
            return [notifyStudent]
        }
        return nil
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // the cells you would like the actions to appear needs to be editable
        if (tableView == self.iPadTeacherTableView){
            return true
        }
        if (tableView == self.iPadStudentTableView) {
            return true
        }
        if (tableView == self.iPadStudySessionTableView){
            return false
        } else {
            return false
        }
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        // you need to implement this method too or you can't swipe to display the actions
    }
    
    */

