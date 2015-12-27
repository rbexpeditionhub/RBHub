//
//  SearchView.swift
//  RBHS
//
//  Created by Emre Cakir on 12/26/15.
//  Copyright © 2015 Coding Empire. All rights reserved.
//

import UIKit

class SearchView: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate {
    
    var data: [[String]] = [["asd", "adasd"], ["adsasd", "adasdasd"]]
    let sectionTitles = ["Teachers", "Students"]
    
    override func viewDidLoad() {
        //data = []
        //NSNotificationCenter.defaultCenter().addObserver(self, selector: "getAllUsers:", name: "allILTUsers", object: nil)
        //NSNotificationCenter.defaultCenter().addObserver(self, selector: "getAllTeachers:", name: "allTeachers", object: nil)
    }
    
    func getAllUsers(notification: NSNotification) {
        let data1 = notification.userInfo!["iltUsers"]
        for var i = (data1?.count)! - 1; i >= 0; i = i - 1 {
            data[1].append(String(data1![i]))
        }
        tableView.reloadData()
    }
    
    func getAllTeachers(notification: NSNotification) {
        let data1 = notification.userInfo!["iltTeachers"]
        for var i = (data1?.count)! - 1; i >= 0; i = i - 1 {
            data[0].append(String(data1![i]))
        }
        tableView.reloadData()
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBAction func cancelBtn(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    var searchActive : Bool = false
    var filtered:[[String]] = []
    var filteredStudent:[String] = []
    var filteredTeacher:[String] = []

    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        let test = data[1]
        print(test)
        filteredTeacher = test.filter({ (text) -> Bool in
            let tmp: NSString = text
            let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.AnchoredSearch)
            return range.location != NSNotFound
        })
        let test1 = data[0]
        print(filteredTeacher)
        filteredStudent = test1.filter({ (text) -> Bool in
            let tmp: NSString = text
            let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.AnchoredSearch)
            return range.location != NSNotFound
        })
        if(filteredStudent.count == 0) && searchText != "" && (filteredTeacher.count == 0){
            searchActive = true;
        } else if searchText != ""{
            filtered.append(filteredStudent)
            filtered.append(filteredTeacher)
            searchActive = true;
        }
        if searchText == "" {
            filtered = []
            searchActive = false
        }
        print(filtered)
        self.tableView.reloadData()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive) {
            return filtered.count
        }
        return data.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")! as UITableViewCell;
        if(searchActive){
            cell.textLabel?.text = filtered[indexPath.section][indexPath.row]
        } else {
            cell.textLabel?.text = data[indexPath.section][indexPath.row];
        }
        
        return cell;
    }
    
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section < sectionTitles.count {
            return sectionTitles[section]
        }
        
        return nil
    }
    
}