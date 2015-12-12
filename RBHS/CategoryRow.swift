//
//  CategoryRow.swift
//  River Bluff High School
//
//  Created by Emre Cakir on 12/1/15.
//  Copyright © 2015 Emre Cakir. All rights reserved.
// 

import UIKit

class CategoryRow : UITableViewCell {
    
    var categoryName:String? = nil
    
    var showDetailDelegate:ShowDetailDelegate? = nil
    
    @IBOutlet weak var collectionView: UICollectionView!

}

//Define the array data
let teachers = [["Mr. Mart in", "Ms. Debenport", "Mrs. Nelson", "Dr. Bart"], ["Mrs. Coleman", "Mrs. Collins", "Mrs. Coleman", "Mrs. Collins", "Mrs. Coleman", "Mrs. Collins", "Mrs. Coleman", "Mrs. Collins", "Mrs. Coleman", "Mrs. Collins", "Mrs. Coleman", "Mrs. Collins", "Mrs. Coleman", "Mrs. Collins"]]
let studySessions = ["APUSH Unit 4", "APUSH Unit 4", "APUSH Unit 4", "CLASS", "CLASS", "CLASS"]
let studentsSeekHelp = ["Enes Cakir", "Enes Cakir", "Enes Cakir", "Enes Cakir", "Enes Cakir", "Enes Cakir", "Enes Cakir", "Enes Cakir"]

var imageHeight:CGFloat = 98.0

extension CategoryRow : UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if categoryName == "Teachers on ILT"{
            return teachers[0].count
        }
        if categoryName == "Students Seeking Help" {
            return studentsSeekHelp.count
        }
        if categoryName == "Study Sessions"{
            return studySessions.count
        }
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("videoCell", forIndexPath: indexPath) as! VideoCell
        
        if categoryName == "Teachers on ILT"{
            cell.imageView.image = UIImage(named:"teacherScrollIcon")
            cell.labelView.text = teachers[0][indexPath.row]
        } else if categoryName == "Students Seeking Help" {
            cell.imageView.image = UIImage(named:"tabBarStudent")
            cell.labelView.text = studentsSeekHelp[indexPath.row]
        } else if categoryName == "Study Sessions"{
            cell.imageView.image = UIImage(named:"tabBarSchool")
            cell.labelView.text = studySessions[indexPath.row]
        }
        
        
        imageHeight = cell.imageView.frame.height
        print(imageHeight)
        cell.categoryName = categoryName
        return cell
    }
    
}

extension CategoryRow : UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let itemHeight:CGFloat = 130
        return CGSize(width: imageHeight+30, height: itemHeight)
    }
    
}

extension CategoryRow : UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if let selectedCell = collectionView.cellForItemAtIndexPath(indexPath) as? VideoCell {
            let displayText = "selected cell number: \(indexPath.row) from category: \(selectedCell.categoryName)"
            showDetailDelegate?.showDetail(displayText)
            //            print("selected cell from category: \(selectedCell.categoryName)")
        }
    }
    
}