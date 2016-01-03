//
//  currentMod.swift
//  RBHS
//
//  Created by Mihir Dutta on 12/30/15.
//  Copyright © 2015 Coding Empire. All rights reserved.
//

import Foundation
import UIKit

class CurrentMod {
    
    let testTimeArray = ["8:15 AM", "8:40 AM", "9:10 AM", "9:40 AM", "10:10 AM", "10:40 AM", "11:10 AM", "11:40 AM", "12:10 PM", "12:40 PM", "1:10 PM", "1:40 PM", "2:10 PM", "2:40 PM", "3:10 PM", "3:40 PM"]
    
    func getCurrentTime() -> Int{
        let Date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Hour, .Minute], fromDate: Date)
        
        let hour = Int(components.hour) * 100
        let minute = Int(components.minute)
        let Time = hour + minute
        return Time
        
    }
    
    
    
    func convertToDate(rawDate: String) -> Int{
        //let string1 = "8:15 AM"
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        let date = dateFormatter.dateFromString(rawDate)
        let calendar = NSCalendar.currentCalendar()
        let comp = calendar.components([.Hour, .Minute], fromDate: date!)
        let hour = Int(comp.hour)*100
        let minute = Int(comp.minute)
        let time = hour+minute
        return time
    }
    
    func todayDate() ->String {
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Day , .Month , .Year], fromDate: date)
        
        let year =  String(components.year)
        let month = String(components.month)
        let day = String(components.day)
        let dash = "-"
        let Date = month + dash + day + dash + year
        print(Date)
        return Date
    }
    
    func findCurrentMod() -> Int{
        var currentTime = getCurrentTime()
        var index = 0
        var startTime = String()
        var endTime = String()
        var currentMod = Int()
        
        if currentTime <= 1540{
            for testTime in testTimeArray{
                if index < 15{
                    startTime = testTimeArray[index]
                    endTime = testTimeArray[index + 1]
                    let intStartTime = convertToDate(startTime)
                    let intEndTime = convertToDate(endTime)
                    if currentTime <= intEndTime && currentTime > intStartTime{
                        currentMod = index+1
                    }
                    
                    index += 1
                }
            }
        }
        else{
            currentMod = 16
        }
        return currentMod
    }
    

}