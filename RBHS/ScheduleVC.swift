//
//  SecondViewController.swift
//  River Bluff High School
//
//  Created by Emre Cakir on 11/20/15.
//  Copyright © 2015 Emre Cakir. All rights reserved.
// 

import UIKit

class ScheduleVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    
    var landscape = false
    
    var schedule:[String : [Int : String]] = [
        "Monday": [1: "", 2: "", 3: "", 4: "", 5: "", 6: "", 7: "", 8: "", 9: "", 10: "", 11: "", 12: "", 13: "", 14: "", 15: ""],
        "Tuesday": [1: "", 2: "", 3: "", 4: "", 5: "", 6: "", 7: "", 8: "", 9: "", 10: "", 11: "", 12: "", 13: "", 14: "", 15: ""],
        "Wednesday": [1: "", 2: "", 3: "", 4: "", 5: "", 6: "", 7: "", 8: "", 9: "", 10: "", 11: "", 12: "", 13: "", 14: "", 15: ""],
        "Thursday": [1: "", 2: "", 3: "", 4: "", 5: "", 6: "", 7: "", 8: "", 9: "", 10: "", 11: "", 12: "", 13: "", 14: "", 15: ""],
        "Friday": [1: "", 2: "", 3: "", 4: "", 5: "", 6: "", 7: "", 8: "", 9: "", 10: "", 11: "", 12: "", 13: "", 14: "", 15: ""]
    ]
    
    var ILTMods:[String : [Int]] = ["Monday": []]

    
    
    var scheduleTodayCells:[String] = []
    var scheduleTodayCellSizes:[Int] = []
    // Set Day
    var classColor = [
        "Class 1": [0.10, 0.74, 0.61],
        "Class 2": [0.18, 0.80, 0.44],
        "Class 3": [0.20, 0.59, 0.86],
        "Class 4": [0.95, 0.77, 0.05],
        "Class 5": [0.90, 0.49, 0.13],
        "Class 6": [0.91, 0.30, 0.24],
        "ILT": [0.61, 0.35, 0.71],
        "Class 8": [0.20, 0.28, 0.37],
        "Class 9": [0.49, 0.55, 0.55],
        "Class 10": [0.09, 0.63, 0.52],
        "Class 11": [0.15, 0.69, 0.38],
        "Class 12": [0.16, 0.50, 0.73],
        "Class 13": [0.96, 0.61, 0.07],
        "Class 14": [0.75, 0.22, 0.17],
        "Class 15": [0.58, 0.65, 0.65],
    ]
    
    
    func cellCreator(day: String) {
        scheduleTodayCells = []
        scheduleTodayCellSizes = []
        for var i = 1; i <= 15; i++ {
            
            
            if scheduleTodayCells.count != 0 {
                
                if schedule[day]![i]! == scheduleTodayCells[scheduleTodayCells.count - 1] {
                    scheduleTodayCellSizes[scheduleTodayCellSizes.count - 1] = scheduleTodayCellSizes[scheduleTodayCellSizes.count - 1] + 50
                    
                } else {
                    
                    scheduleTodayCells.append(schedule[day]![i]!)
                    scheduleTodayCellSizes.append(50)
                }
                
                
            }else {
                
                scheduleTodayCells.append(schedule[day]![i]!)
                scheduleTodayCellSizes.append(50)
                
            }
            
        }
        
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBAction func todayButton(sender: AnyObject) {
        changeViewToday()
        
    }
    
    
    var days:[String] = []
    var years:[String] = []
    
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    
    var totalDates = 0
    
    var buttons:[UIButton] = []
    var weekViews:[UIView] = []
    
    let dateFormatter = NSDateFormatter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let outData = NSUserDefaults.standardUserDefaults().dataForKey("schedule")
        schedule = NSKeyedUnarchiver.unarchiveObjectWithData(outData!)! as! [String : [Int : String]]
        print(schedule)
        
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
        
        // Do any additional setup after loading the view, typically from a nib.
        
        if(UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Phone) {
            self.navigationItem.title = ""
        }
        
        self.addRightNavItemOnView()
        
        // Start NSDate
        let currentDate = NSDate()
        //Start Formater
        //Start Date Modif
        let newDateComponents = NSDateComponents()
        let calendar = NSCalendar.currentCalendar()
        
        
        dateFormatter.dateFormat = "EEEE"
        let dayString = dateFormatter.stringFromDate(currentDate)
        if dayString == "Saturday" || dayString == "Sunday"{
            //Add code for weekends here
            cellCreator("Monday")
        }else {
            
            cellCreator(dayString)
            self.tableView.reloadData()
            
        }
        
        // Going to the future and past
        let monthsToAdd = 0
        let daysToAdd = -69
        
        newDateComponents.month = monthsToAdd
        newDateComponents.day = daysToAdd
        
        let currentDateComponents = calendar.components([.YearForWeekOfYear, .WeekOfYear ], fromDate: currentDate)
        let startOfWeek = calendar.dateFromComponents(currentDateComponents)
        let startDate = NSCalendar.currentCalendar().dateByAddingComponents(newDateComponents, toDate: startOfWeek!, options: NSCalendarOptions.init(rawValue: 0))
        
        for var i = 0; i <= 140; i++ {
            
            let monthsToAdd = 0
            let daysToAdd = i
            
            newDateComponents.month = monthsToAdd
            newDateComponents.day = daysToAdd
            
            let workDate = NSCalendar.currentCalendar().dateByAddingComponents(newDateComponents, toDate: startDate!, options: NSCalendarOptions.init(rawValue: 0))
            
            dateFormatter.dateFormat = "yy-MM-dd"
            let dateString = dateFormatter.stringFromDate(workDate!)
            
            days.append(dateString)
            
            
        }
        
        // Scroll View
        self.scrollView.pagingEnabled = true
        //Create MultipleViews
        
        for var i = 0; i < days.count/7; i++ {
            
            let weekView=UIView(frame: CGRectMake(self.view.frame.width * CGFloat(i),0, self.view.frame.width, 48))
            //print("Origin \(weekView.frame.origin.x)")
            weekView.layer.borderWidth = 0
            weekViews.append(weekView)
            
            //Populate WeekView with day Buttons
            for var c = 0; c < 5; c++ {
                
                let xValue = Int(self.view.frame.width)/5 * (c)
                let width = Int(self.view.frame.width)/5
                //Format
                dateFormatter.dateFormat = "yy-MM-dd HH:mm:ss Z"
                let dayArray = dateFormatter.dateFromString("\(days[c + (7 * i)]) 12:00:00 +0000")
                dateFormatter.dateFormat = "EEEE"
                var day = dateFormatter.stringFromDate(dayArray!)
                dateFormatter.dateFormat = "dd"
                var dayNumber = dateFormatter.stringFromDate(dayArray!)
                if Int(dayNumber) < 10 {
                    dateFormatter.dateFormat = "d"
                    dayNumber = dateFormatter.stringFromDate(dayArray!)
                }
                /* MONTH AND YEAR FORMAT
                dateFormatter.dateFormat = "MMMM"
                let month = dateFormatter.stringFromDate(dayArray)
                dateFormatter.dateFormat = "yyyy"
                let year = dateFormatter.stringFromDate(dayArray)
                */
                while day.characters.count > 3 {
                    
                    day.removeAtIndex(day.endIndex.predecessor())
                    
                }
                
                
                let dateButton = UIButton()
                
                if(UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad) {
                    //iPad
                    dateButton.setTitle(day + " " + dayNumber, forState: .Normal)
                }
                else {
                    //iPhone
                    dateButton.setTitle(dayNumber, forState: .Normal)
                }
                
                
                dateButton.frame = CGRectMake(CGFloat(xValue), 9, CGFloat(width), 30)
                dateButton.addTarget(self, action: "pressed:", forControlEvents: .TouchUpInside)
                dateButton.layer.cornerRadius=10
                dateButton.layer.borderWidth = 0
                dateButton.tag = c + (7 * i)
                buttons.append(dateButton)
                weekView.addSubview(dateButton)
                totalDates += 1
                
            }
            let placeholder = UIButton()
            buttons.append(placeholder)
            buttons.append(placeholder)
            self.scrollView.addSubview(weekView)
        }
        self.scrollView.contentSize = CGSizeMake(CGFloat(Int(self.view.frame.width) * (days.count/7)), 48)
        self.scrollView.backgroundColor = UIColor(red:0.16, green:0.48, blue:0.27, alpha:1.0)
        changeViewToday()
    }
    
    var selectedButton = UIButton()
    
    func pressed(sender: UIButton!) {
        
        if sender != selectedButton {
            sender.backgroundColor = UIColor(red:0.28, green:0.85, blue:0.48, alpha:1.0)
            selectedButton.backgroundColor = UIColor(red:0.28, green:0.85, blue:0.48, alpha: 0)
        }
        selectedButton = sender
        //print("Button ID: \(sender.tag)")
        dateFormatter.dateFormat = "yy-MM-dd HH:mm:ss Z"
        let dayArray = dateFormatter.dateFromString("\(days[sender.tag]) 12:39:18 +0000")
        
        dateFormatter.dateFormat = "MMMM"
        let month = dateFormatter.stringFromDate(dayArray!)
        dateFormatter.dateFormat = "yyyy"
        let year = dateFormatter.stringFromDate(dayArray!)
        
        monthLabel.text = month
        monthLabel.setSizeFont(24.00)
        yearLabel.text = year
        yearLabel.setSizeFont(24.00)
        
        dateFormatter.dateFormat = "EEEE"
        let dayString = dateFormatter.stringFromDate(dayArray!)
        if dayString == "Saturday" || dayString == "Sunday"{
        }else {
            
            cellCreator(dayString)
            self.tableView.reloadData()
        
        }
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scheduleTodayCells.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier,
            forIndexPath: indexPath)
        // Configure the cell...
        cell.textLabel?.text = scheduleTodayCells[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        let redU = classColor[scheduleTodayCells[indexPath.row]]![0]
        let greenU = classColor[scheduleTodayCells[indexPath.row]]![1]
        let blueU = classColor[scheduleTodayCells[indexPath.row]]![2]
        cell.backgroundColor = UIColor(red:CGFloat(redU), green:CGFloat(greenU), blue:CGFloat(blueU), alpha:1)
        
    }
    
    func tableView(tableView: UITableView,
        heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
            let size = CGFloat(scheduleTodayCellSizes[indexPath.row])
            return size
    }
    
    var page = 0
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView){
        
        page = Int((scrollView.contentOffset.x+(0.5*scrollView.frame.size.width))/scrollView.frame.width) * 7 + (selectedButton.tag%7)
        
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if scrollView.tag == 1{
        let newPage = Int((scrollView.contentOffset.x+(0.5*scrollView.frame.size.width))/scrollView.frame.width) * 7 + (selectedButton.tag%7)
        if newPage != page{
            selectDate(newPage)
        }
        }
    }
    /*
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.tag == 1 {
            let newPage = Int((scrollView.contentOffset.x+(0.5*scrollView.frame.size.width))/scrollView.frame.width) * 7 + (selectedButton.tag%7)
            print("HA \(newPage)")
            if newPage != page{
                selectDate(newPage)
            }
        }
        
    }
        */
    
    func selectDate(tag:Int) {
        dateFormatter.dateFormat = "yy-MM-dd HH:mm:ss Z"
        let dayArray = dateFormatter.dateFromString("\(days[tag]) 12:39:18 +0000")
        dateFormatter.dateFormat = "MMMM"
        let month = dateFormatter.stringFromDate(dayArray!)
        dateFormatter.dateFormat = "yyyy"
        let year = dateFormatter.stringFromDate(dayArray!)
        
        monthLabel.text = month
        monthLabel.setSizeFont(24.00)
        yearLabel.text = year
        yearLabel.setSizeFont(24.00)
        
        selectedButton.backgroundColor = UIColor(red:0.28, green:0.85, blue:0.48, alpha: 0)
        //print(tag)
        buttons[tag].backgroundColor = UIColor(red:0.28, green:0.85, blue:0.48, alpha: 1.0)
        selectedButton = buttons[tag]
        
        dateFormatter.dateFormat = "EEEE"
        let dayString = dateFormatter.stringFromDate(dayArray!)
        if dayString == "Saturday" || dayString == "Sunday"{
            //print("here")
        }else {
            
            cellCreator(dayString)
            self.tableView.reloadData()
            
        }
        
    }
    
    func changeViewToday() {
        scrollView.setContentOffset(CGPoint(x: self.scrollView.contentSize.width/2, y: 0), animated: true)
        //print(self.scrollView.frame.width/2)
        
        let currentDate = NSDate()
        
        dateFormatter.dateFormat = "yy-MM-dd"
        let dateString = dateFormatter.stringFromDate(currentDate)
        let indexOfToday = days.indexOf(dateString)
        selectDate(indexOfToday!)
        
    }
    let monthLabel = UILabel()
    let yearLabel = UILabel()
    func addRightNavItemOnView() {
        

        monthLabel.frame = CGRectMake(0, 0, 140, 30)
        monthLabel.text = "November"
        monthLabel.font = UIFont.systemFontOfSize(24.00, weight: UIFontWeightMedium)
        yearLabel.setSizeFont(24.00)
        monthLabel.textColor = UIColor.whiteColor()
        let rightBarButtonItemEdit = UIBarButtonItem(customView: monthLabel)
        yearLabel.frame = CGRectMake(0, 0, 140, 30)
        yearLabel.text = "2015"
        yearLabel.font = UIFont.systemFontOfSize(24.00, weight: UIFontWeightThin)
        yearLabel.setSizeFont(24.00)
        yearLabel.textColor = UIColor.whiteColor()
        
        let rightBarButtonItemDelete = UIBarButtonItem(customView: yearLabel)
        // add multiple right bar button items
        self.navigationItem.setLeftBarButtonItems([rightBarButtonItemEdit, rightBarButtonItemDelete], animated: true)
        //self.navigationItem.setLeftBarButtonItem(rightBarButtonItemEdit, animated: true)
        
    }
    
    func reSizeScrollViewBtns() {
        for var i = 0; i < days.count/7; i++ {
            
            let weekView = weekViews[i]
            weekView.frame = CGRectMake(self.view.frame.width * CGFloat(i),0, self.view.frame.width, 48)
            for var c = 0; c < 5; c++ {
                
                let xValue = Int(self.view.frame.width)/5 * (c)
                let width = Int(self.view.frame.width)/5
                
                let dateButton = buttons[c + (7 * i)]
                
                
                dateButton.frame = CGRectMake(CGFloat(xValue), 9, CGFloat(width), 30)
                
            }
        }
        scrollView.contentSize = CGSizeMake(CGFloat(Int(self.view.frame.width) * (days.count/7)), 48)
        scrollView.setContentOffset(CGPoint(x: scrollView.frame.width * CGFloat(round(Double(selectedButton.tag/7))), y: 0), animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // Update scroll Views
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        coordinator.animateAlongsideTransition(nil, completion: {context in
            self.reSizeScrollViewBtns()
        })
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.tag == 1{
            self.scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, 0)
        }
    }
    
    
}

extension UILabel {
    func setSizeFont (sizeFont: CGFloat) {
        self.font =  UIFont(name: self.font.fontName, size: sizeFont)!
        self.sizeToFit()
    }
}
