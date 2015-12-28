//
//  SearchView.swift
//  RBHS
//
//  Created by Emre Cakir on 12/26/15.
//  Copyright © 2015 Coding Empire. All rights reserved.
//

import UIKit

class SearchView: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate {
    
    var data: [[String]] = [[], []]
    let sectionTitles = ["Students", "Teachers"]
    var dataRaw: [String: String] = NSDictionary() as! [String : String]
    override func viewDidLoad() {
        data[0] = []
        data[1] = []
        filtered[0] = []
        filtered[1] = []
        tableView.reloadData()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "getAllUsers:", name: "allILTUsers", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "getAllTeachers:", name: "allTeachers", object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        data[0] = []
        data[1] = []
        filtered[0] = []
        filtered[1] = []
        dataRaw.removeAll()
        tableView.reloadData()
    }
    
    func getAllUsers(notification: NSNotification) {
        data[0] = []
        let data1 = notification.userInfo!["iltUsers"]! as! [[String]]
        for var i = data1.count - 1; i >= 0; i = i - 1 {
            data[0].append(String(data1[i][0]))
            dataRaw[data1[i][0]] = data1[i][1]
        }
        tableView.reloadData()
    }
    
    func getAllTeachers(notification: NSNotification) {
        data[1] = []
        let data1 = notification.userInfo!["iltTeachers"]! as! [[String]]
        for var i = data1.count - 1; i >= 0; i = i - 1 {
            data[1].append(String(data1[i][0]))
            dataRaw[data1[i][0]] = data1[i][1]
        }
        tableView.reloadData()
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBAction func cancelBtn(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    var searchActive : Bool = false
    var filtered:[[String]] = [[],[]]

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
        let options:NSStringCompareOptions = [.AnchoredSearch, .CaseInsensitiveSearch]
        filtered[0] = data[0].filter({ (text) -> Bool in
            let tmp: NSString = text
            let range = tmp.rangeOfString(searchText, options: options)
            return range.location != NSNotFound
        })
        filtered[1] = data[1].filter({ (text) -> Bool in
            let tmp: NSString = text
            let range = tmp.rangeOfString(searchText, options: options)
            return range.location != NSNotFound
        })
        
        if searchText != ""{
            searchActive = true;
        }
        if searchText == "" {
            filtered[0] = []
            filtered[1] = []
            searchActive = false
        }
        self.tableView.reloadData()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive) {
            return filtered[section].count
        }
        return data[section].count;
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