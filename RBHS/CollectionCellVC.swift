//
//  CollectionCellVC.swift
//  RBHS
//
//  Created by Emre Cakir on 12/24/15.
//  Copyright © 2015 Coding Empire. All rights reserved.
//

import UIKit

class InfiniteScrollingCell: UICollectionViewCell, UITableViewDataSource, UITableViewDelegate {
    
    var schedule:[String : [Int : String]] = [
        "Monday": [1: "", 2: "", 3: "", 4: "", 5: "", 6: "", 7: "", 8: "", 9: "", 10: "", 11: "", 12: "", 13: "", 14: "", 15: ""],
        "Tuesday": [1: "", 2: "", 3: "", 4: "", 5: "", 6: "", 7: "", 8: "", 9: "", 10: "", 11: "", 12: "", 13: "", 14: "", 15: ""],
        "Wednesday": [1: "", 2: "", 3: "", 4: "", 5: "", 6: "", 7: "", 8: "", 9: "", 10: "", 11: "", 12: "", 13: "", 14: "", 15: ""],
        "Thursday": [1: "", 2: "", 3: "", 4: "", 5: "", 6: "", 7: "", 8: "", 9: "", 10: "", 11: "", 12: "", 13: "", 14: "", 15: ""],
        "Friday": [1: "", 2: "", 3: "", 4: "", 5: "", 6: "", 7: "", 8: "", 9: "", 10: "", 11: "", 12: "", 13: "", 14: "", 15: ""]
    ]
    
    var ILTMods:[String : [Int]] = ["Monday": []]
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var scheduleTodayCells:[String] = []
    var scheduleTodayCellSizes:[Int] = []
    var scheduleTodayModList: [Int] = []
    // Set Day
    var classColor = [
        "Class 1": [0.10, 0.74, 0.61],
        "Class 2": [0.18, 0.80, 0.44],
        "Class 3": [0.20, 0.59, 0.86],
        "Class 4": [0.95, 0.77, 0.05],
        "Class 5": [0.90, 0.49, 0.13],
        "Class 6": [0.91, 0.30, 0.24],
        "ILT": [0.09, 0.63, 0.52],
        "Class 8": [0.20, 0.28, 0.37],
        "Class 9": [0.49, 0.55, 0.55],
        "Class 10": [0.61, 0.35, 0.71],
        "Class 11": [0.15, 0.69, 0.38],
        "Class 12": [0.16, 0.50, 0.73],
        "Class 13": [0.96, 0.61, 0.07],
        "Class 14": [0.75, 0.22, 0.17],
        "Class 15": [0.58, 0.65, 0.65],
    ]
    
    func cellCreator(day: String) {
        scheduleTodayCells = []
        scheduleTodayCellSizes = []
        scheduleTodayModList = []
        for var i = 1; i <= 15; i++ {
            
            let cellHeight = 70
            
            if scheduleTodayCells.count != 0 {
                
                if schedule[day]![i]! == scheduleTodayCells[scheduleTodayCells.count - 1] && schedule[day]![i] != "ILT"{
                    //extend existing class
                    scheduleTodayCellSizes[scheduleTodayCellSizes.count - 1] = scheduleTodayCellSizes[scheduleTodayCellSizes.count - 1] + cellHeight
                } else {
                    //add start of new class
                    scheduleTodayCells.append(schedule[day]![i]!)
                    scheduleTodayModList.append(scheduleTodayModList[scheduleTodayModList.count - 1] + scheduleTodayCellSizes[scheduleTodayCellSizes.count - 1]/cellHeight)
                    scheduleTodayCellSizes.append(cellHeight)
                }
                
                
            }else {
                //start today class list
                scheduleTodayCells.append(schedule[day]![i]!)
                scheduleTodayCellSizes.append(cellHeight)
                scheduleTodayModList.append(1)
                
            }
            
        }
        
    }
    
    let dateFormatter = NSDateFormatter()
    var dayString = "Monday"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let outData = NSUserDefaults.standardUserDefaults().dataForKey("schedule")
        schedule = NSKeyedUnarchiver.unarchiveObjectWithData(outData!)! as! [String : [Int : String]]
        
        let outDataILT = NSUserDefaults.standardUserDefaults().dataForKey("ILT")
        ILTMods = NSKeyedUnarchiver.unarchiveObjectWithData(outDataILT!)! as! [String : [Int]]
        
        //set colors
        var classNumber = 0
        for var g = 0; g < 5; g++ {
            
            switch g{
                
            case 0:
                for var m = 1; m <= 15; m++ {
                    if classColor[schedule["Monday"]![m]!] == nil {
                        classColor[schedule["Monday"]![m]!] = classColor["Class \(classNumber + 1)"]
                        classColor.removeValueForKey("Class \(classNumber + 1)")
                        classNumber++
                    }
                }
            case 1:
                for var m = 1; m <= 15; m++ {
                    if classColor[schedule["Tuesday"]![m]!] == nil {
                        classColor[schedule["Tuesday"]![m]!] = classColor["Class \(classNumber + 1)"]
                        classColor.removeValueForKey("Class \(classNumber + 1)")
                        classNumber++
                    }
                }
            case 2:
                for var m = 1; m <= 15; m++ {
                    if classColor[schedule["Wednesday"]![m]!] == nil {
                        classColor[schedule["Wednesday"]![m]!] = classColor["Class \(classNumber + 1)"]
                        classColor.removeValueForKey("Class \(classNumber + 1)")
                        classNumber++
                    }
                }
            case 3:
                for var m = 1; m <= 15; m++ {
                    if classColor[schedule["Thursday"]![m]!] == nil {
                        classColor[schedule["Thursday"]![m]!] = classColor["Class \(classNumber + 1)"]
                        classColor.removeValueForKey("Class \(classNumber + 1)")
                        classNumber++
                    }
                }
            case 4:
                for var m = 1; m <= 15; m++ {
                    if classColor[schedule["Friday"]![m]!] == nil {
                        classColor[schedule["Friday"]![m]!] = classColor["Class \(classNumber + 1)"]
                        classColor.removeValueForKey("Class \(classNumber + 1)")
                        classNumber++
                    }
                }
            default:
                print("oh no")
                
            }
            
        }
        
        let nc = NSNotificationCenter.defaultCenter()
        nc.addObserver(self, selector: "reloadTable", name: "reloadTable", object: nil)
        nc.addObserver(self, selector: "resetObjectID", name: "resetObjectIndex", object: nil)


        
    }
    
    func scheduleTable(day:String) {
        
        if day == "Saturday" || day == "Sunday"{
            //Add code for weekends here
            cellCreator("Friday")
        }else {
            cellCreator(day)
            self.tableView.reloadData()
        }
        

    }
    
    func refreshList(notification: NSNotification) {
        
        if let myDict = notification.object as? [String:AnyObject] {
            scheduleTodayCells = (myDict["scheduleTodayCells"] as? [String])!
            scheduleTodayModList = (myDict["scheduleTodayModList"] as? [Int])!
            scheduleTodayCellSizes = (myDict["scheduleTodayCellSizes"] as? [Int])!
            classColor = (myDict["classColor"] as? [String: Array<Double>])!
        }
    }
    
    
    let basicCellIdentifier = "Cell"
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scheduleTodayCells.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return basicCellAtIndexPath(indexPath)
    }
    
    func basicCellAtIndexPath(indexPath:NSIndexPath) -> scheduleModViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(basicCellIdentifier) as! scheduleModViewCell
        setTitleForCell(cell, indexPath: indexPath)
        setSubtitleForCell(cell, indexPath: indexPath)
        return cell
    }
    
    func setTitleForCell(cell:scheduleModViewCell, indexPath:NSIndexPath) {
        cell.titleLabel.text = scheduleTodayCells[indexPath.row]
    }
    
    func setSubtitleForCell(cell:scheduleModViewCell, indexPath:NSIndexPath) {
        cell.timeLabel.text = "Mod " + String(scheduleTodayModList[indexPath.row])
        
    }
    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        if scheduleTodayCells[indexPath.row] == "ILT" {
            return indexPath
        } else {
            return nil
        }
    }
    
    func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if scheduleTodayCells[indexPath.row] == "ILT" {
            return true
        } else {
            return false
        }
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        let redU = classColor[scheduleTodayCells[indexPath.row]]![0]
        let greenU = classColor[scheduleTodayCells[indexPath.row]]![1]
        let blueU = classColor[scheduleTodayCells[indexPath.row]]![2]
        cell.backgroundColor = UIColor(red:CGFloat(redU), green:CGFloat(greenU), blue:CGFloat(blueU), alpha:1)
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor(red:0.37, green:0.37, blue:0.37, alpha:0.5)
        cell.selectedBackgroundView = bgColorView
        
    }
    
    func tableView(tableView: UITableView,
        heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
            let size = CGFloat(scheduleTodayCellSizes[indexPath.row])
            return size
    }
    
    var oldSelectedRow:NSIndexPath = NSIndexPath(index: 400)
    
    func resetObjectID() {
        oldSelectedRow = NSIndexPath(index: 400)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if oldSelectedRow == indexPath {
            //deselect the item
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            oldSelectedRow = NSIndexPath(index: 400)
            NSNotificationCenter.defaultCenter().postNotificationName("iltViewChange", object: nil, userInfo: ["hiddenState": "tru"])
        } else {
            oldSelectedRow = indexPath
            print("You selected cell number: \(indexPath.row)!")
            
            NSNotificationCenter.defaultCenter().postNotificationName(
                "ChangeILT",
                object: nil,
                userInfo: ["class name": scheduleTodayCells[indexPath.row]])
            NSNotificationCenter.defaultCenter().postNotificationName("iltViewChange", object: nil, userInfo: ["hiddenState": "fals"])
        }
        
    }
    
    func configureCell(photoName:String){
        //print(photoName)
        dayString = photoName
        let rangeOfTLD = Range(start: dayString.startIndex,
            end: dayString.startIndex.advancedBy(3))
        let tld = dayString[rangeOfTLD] // "com"
        
        if tld == "Mon" {
            dayString =  "Monday"
        } else if tld == "Tue"{
            dayString =  "Tuesday"
        } else if tld == "Wed" {
            dayString =  "Wednesday"
        } else if tld == "Thu" {
            dayString =  "Thursday"
        } else if tld == "Fri" {
            dayString =  "Friday"
        } else if tld == "Sat" {
            dayString =  "Saturday"
        } else if tld == "Sun" {
            dayString =  "Sunday"
        }
        scheduleTable(dayString)
    }
    
}
