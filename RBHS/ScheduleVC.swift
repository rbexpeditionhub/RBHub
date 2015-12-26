//
//  SecondViewController.swift
//  River Bluff High School
//
//  Created by Emre Cakir on 11/20/15.
//  Copyright © 2015 Emre Cakir. All rights reserved.
// 

import UIKit

class ScheduleVC: UIViewController, UIScrollViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    var landscape = false
    

    @IBOutlet weak var iltViewContainer: UIView!
    @IBOutlet weak var iltTextLabel: UILabel!
    @IBOutlet weak var infiniteScrollingCollectionView: UICollectionView!
    var WIDTH:CGFloat = 512
    var HEIGHT:CGFloat = 560

    private let reuseIdentifier = "InfiniteScrollingCell"
    
    private var photosUrlArray = [String]()
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBAction func todayButton(sender: AnyObject) {
        changeViewToday()
        
    }
    
    
    var days:[String] = []
    var years:[String] = []
    var collectionCellCount = 0
    var todayDayCollection = "Monday"
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    var totalDates = 0
    
    var buttons:[UIButton] = []
    var weekViews:[UIView] = []
    var cellIndexPaths:[NSIndexPath] = []
    let dateFormatter = NSDateFormatter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        var dayName:[String] = []
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
                    dayName.append((dateButton.titleLabel?.text)!)
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
        
        self.automaticallyAdjustsScrollViewInsets = false
        photosUrlArray = dayArray
        print(photosUrlArray)
        infiniteScrollingCollectionView?.delegate = self
        infiniteScrollingCollectionView?.dataSource = self
        infiniteScrollingCollectionView.decelerationRate = UIScrollViewDecelerationRateFast
         
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "iltViewChange:", name: "iltViewChange", object: nil)
        initToday()
        
        //Find today and pass it to collection 
        dateFormatter.dateFormat = "EEEE"
        todayDayCollection = dateFormatter.stringFromDate(currentDate)
        loadSpecific = true
        if todayDayCollection == "Saturday" {
            todayDayCollection = "Friday"
        } else if todayDayCollection == "Sunday" {
            todayDayCollection = "Monday"
        }
        print(todayDayCollection)
        
    }

    func initToday() {
        let item = self.collectionView(self.infiniteScrollingCollectionView!, numberOfItemsInSection: 0) - 1
        let lastItemIndex = NSIndexPath(forItem: item, inSection: 0)
        self.infiniteScrollingCollectionView?.scrollToItemAtIndexPath(lastItemIndex, atScrollPosition: UICollectionViewScrollPosition.Top, animated: false)
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
            
            let nc = NSNotificationCenter.defaultCenter()
            nc.postNotificationName("reloadTable", object: nil) //NEED TO PASS INFO
            iltViewContainer.hidden = true
            iltTextLabel.hidden = true
            nc.postNotificationName("resetObjectIndex", object: nil)
        
        }
    }


func updateILTView(notification: NSNotification) {

    print("updating \(notification.userInfo!["class name"])")
    
}

    func iltViewChange(notification: NSNotification){
        if String(notification.userInfo!["hiddenState"]) == "tru" {
            iltViewContainer.hidden = true
            iltTextLabel.hidden = true
        } else {
            iltViewContainer.hidden = false
            iltTextLabel.hidden = false
        }

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
        } else if scrollView.tag == 5 {
            // Calculate where the collection view should be at the right-hand end item
            let fullyScrolledContentOffset:CGFloat = infiniteScrollingCollectionView.frame.size.width * CGFloat(photosUrlArray.count - 1)
            if (scrollView.contentOffset.x >= fullyScrolledContentOffset) {
                
                // user is scrolling to the right from the last item to the 'fake' item 1.
                // reposition offset to show the 'real' item 1 at the left-hand end of the collection view
                if photosUrlArray.count>2{
                    reversePhotoArray(photosUrlArray, startIndex: 0, endIndex: photosUrlArray.count - 1)
                    reversePhotoArray(photosUrlArray, startIndex: 0, endIndex: 1)
                    reversePhotoArray(photosUrlArray, startIndex: 2, endIndex: photosUrlArray.count - 1)
                    let indexPath : NSIndexPath = NSIndexPath(forRow: 1, inSection: 0)
                    infiniteScrollingCollectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .Left, animated: false)
                }
            }
            else if (scrollView.contentOffset.x == 0){
                
                if photosUrlArray.count>2{
                    reversePhotoArray(photosUrlArray, startIndex: 0, endIndex: photosUrlArray.count - 1)
                    reversePhotoArray(photosUrlArray, startIndex: 0, endIndex: photosUrlArray.count - 3)
                    reversePhotoArray(photosUrlArray, startIndex: photosUrlArray.count - 2, endIndex: photosUrlArray.count - 1)
                    let indexPath : NSIndexPath = NSIndexPath(forRow: photosUrlArray.count - 2, inSection: 0)
                    infiniteScrollingCollectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .Left, animated: false)
                }
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
    
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if scrollView.tag == 5{
        scrollView.decelerationRate = UIScrollViewDecelerationRateFast
        let pageWidth:CGFloat = infiniteScrollingCollectionView.frame.width + 10 //160 plus the 10x on each side.
        let val:CGFloat = scrollView.contentOffset.x / pageWidth
        var newPage = NSInteger(val)
        
        if (velocity.x == 0)
        {
            newPage = Int(floor((targetContentOffset.memory.x - pageWidth / 2) / pageWidth) + 1)
        } else {
            if(velocity.x < 0)
            {
                let diff:CGFloat = val - CGFloat(newPage)
                if(diff > 0.6){
                    newPage++
                }
            }
            newPage = velocity.x > 0 ? newPage + 1 : newPage - 1
            
            //Velocity adjustments.
            if velocity.x > 2.7 {
                newPage += 2
            } else if velocity.x > 2.2 {
                newPage++
            }
            if velocity.x < -2.7 {
                newPage -= 2
            } else if velocity.x < -2.2 {
                newPage--
            }
            
            if (newPage < 0){
                newPage = 0
            }
            if (newPage > NSInteger(scrollView.contentSize.width / pageWidth)){
                newPage = NSInteger(ceil(scrollView.contentSize.width / pageWidth) - 1.0)
            }
        }
        targetContentOffset.memory.x = CGFloat(newPage) * pageWidth
        }
    }
    
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
            let nc = NSNotificationCenter.defaultCenter()
            nc.postNotificationName("reloadTable", object: nil) // NEED TO SEND INFO
            
        }
        
    }
    
    func changeViewToday() {
        scrollView.setContentOffset(CGPoint(x: self.scrollView.contentSize.width/2, y: 0), animated: true)
        print(cellIndexPaths.count/2)
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
    
    func photoForIndexPath(indexPath: NSIndexPath) -> String {
        return photosUrlArray[indexPath.row]
    }
    
    
    func reversePhotoArray(photoArray:[String], startIndex:Int, endIndex:Int){
        if startIndex >= endIndex{
            return
        }
        swap(&photosUrlArray[startIndex], &photosUrlArray[endIndex])
        
        reversePhotoArray(photosUrlArray, startIndex: startIndex + 1, endIndex: endIndex - 1)
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dayArray.count
    }
    
    var oldIndexPath = -1
    var loadSpecific = true
    let dayArray = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
    var loadedDay = "Monday"
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! InfiniteScrollingCell
        if loadSpecific == false {
            //Do code to detect if cell loading is in front or behind
            if indexPath.row > oldIndexPath {
                //load day in front of the loaded one
                var nextIndex = dayArray.indexOf(todayDayCollection)! + 1
                if nextIndex > 4 {
                    nextIndex = 0
                }
                todayDayCollection = dayArray[nextIndex]
                cell.configureCell(todayDayCollection)
            } else {
                //load day behind loaded one
                var nextIndex = dayArray.indexOf(todayDayCollection)! - 1
                if nextIndex < 0 {
                    nextIndex = 4
                }
                todayDayCollection = dayArray[nextIndex]
                cell.configureCell(todayDayCollection)
            }
        } else {
            print(todayDayCollection)
            cell.configureCell(todayDayCollection)
            loadSpecific = false
        }
        oldIndexPath = indexPath.row
        loadedDay = todayDayCollection
        print(todayDayCollection)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
            let size:CGSize = CGSizeMake(WIDTH, HEIGHT)
            return size
            
    }
    
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAtIndex section: Int) -> UIEdgeInsets {
            return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    
}

extension UILabel {
    func setSizeFont (sizeFont: CGFloat) {
        self.font =  UIFont(name: self.font.fontName, size: sizeFont)!
        self.sizeToFit()
    }
}

