//
//  PowerSchoolVC.swift
//  RBHS
//
//  Created by Emre Cakir on 12/5/15.
//  Copyright © 2015 Coding Empire. All rights reserved.
// 

import UIKit
import SafariServices

class PowerSchoolVC: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if NSUserDefaults.standardUserDefaults().objectForKey("teacher") != nil{
        // Do any additional setup after loading the view, typically from a nib.
            let url = NSURL (string: "https://powerschool.lexington1.net/teachers/pw.html")
            let requestObj = NSURLRequest(URL: url!);
            webView.loadRequest(requestObj);


        } else {
            //http://cakirsc.com/testing/ScheduleHTML.html
            let url = NSURL (string: "https://powerschool.lexington1.net/public/home.html")
            let requestObj = NSURLRequest(URL: url!);
            webView.loadRequest(requestObj);
        }

    }
    
    func webViewDidFinishLoad(webView: UIWebView){
        let result = webView.stringByEvaluatingJavaScriptFromString("document.body.innerHTML")
    
        if (result?.containsString("Grades and Attendance:")) == true {
            webView.hidden = true
            UIWebView.loadRequest(webView)(NSURLRequest(URL: NSURL(string: "https://powerschool.lexington1.net/guardian/attendance.html")!))
        }
        if (result?.containsString("Start Page")) == true {
            webView.hidden = true
            UIWebView.loadRequest(webView)(NSURLRequest(URL: NSURL(string: "https://powerschool.lexington1.net/teachers/schedulematrix.html")!))
        }
        
        
        if NSUserDefaults.standardUserDefaults().objectForKey("teacher") != nil{
            _ = NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: "loadDateTeacher", userInfo: nil, repeats: false)
        } else {
            _ = NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: "loadDate", userInfo: nil, repeats: false)
        }
    }
    var classInfo:[[String]] = []
    var courseInfo:[String: [String]] = ["Orchestra": ["Nelson, Rachel", "F205"]]
    var courseInfoTeacher:[String: String] = ["Orchestra": "F205"]
    var schedule:[String : [Int : String]] = [
        "Monday": [1: "", 2: "", 3: "", 4: "", 5: "", 6: "", 7: "", 8: "", 9: "", 10: "", 11: "", 12: "", 13: "", 14: "", 15: ""],
        "Tuesday": [1: "", 2: "", 3: "", 4: "", 5: "", 6: "", 7: "", 8: "", 9: "", 10: "", 11: "", 12: "", 13: "", 14: "", 15: ""],
        "Wednesday": [1: "", 2: "", 3: "", 4: "", 5: "", 6: "", 7: "", 8: "", 9: "", 10: "", 11: "", 12: "", 13: "", 14: "", 15: ""],
        "Thursday": [1: "", 2: "", 3: "", 4: "", 5: "", 6: "", 7: "", 8: "", 9: "", 10: "", 11: "", 12: "", 13: "", 14: "", 15: ""],
        "Friday": [1: "", 2: "", 3: "", 4: "", 5: "", 6: "", 7: "", 8: "", 9: "", 10: "", 11: "", 12: "", 13: "", 14: "", 15: ""]
    ]
    func loadDate() {
        let currentURL : NSString = (webView.request?.URL!.absoluteString)!
        
        if currentURL == "https://powerschool.lexington1.net/guardian/attendance.html"{
            let result = webView.stringByEvaluatingJavaScriptFromString("document.body.innerHTML")
            UIPasteboard.generalPasteboard().string = result
            //let searchCharacter = "<td a"
            
            func checkResults (){
                if result != nil {

                    var classNameNew = ""
                    var teacherNameNew = ""
                    var roomNew = ""
                    var timesNew = ""
                    //create array
                    var characters = result!.characters.map { String($0) }
                    //go through array
                    for var c = 0; c < characters.count; c++ {
                        //look for <
                        if let index = characters.indexOf("<") {
                            //remove objects before < and <
                            for var i = 0; i <= index; i++ {
                                characters.removeAtIndex(0)
                            }
                            //check to see if class name
                            if index + 4 <= characters.count{
                                if characters[0] == "t" && characters[1] == "d" && characters[2] == " "{
                                    
                                    for var i = 0; i <= 15; i++ {
                                        characters.removeAtIndex(0)
                                    }
                                    
                                    /*
                                    <br>E:&nbsp08/17/2015 L:&nbsp;06/08/2016</td><td>1-2(A)5-6(C)1-2(D)6(E)</td><td>&nbsp;
                                    */
                                    
                                    //start check for end of name
                                    var nameFound = false
                                    while nameFound == false {
                                        //look for < (end of the class name)
                                        if let index = characters.indexOf("<") {
                                            for var i = 0; i < index; i++ {
                                                //get characters for the name
                                                classNameNew = classNameNew + characters[0]
                                                characters.removeAtIndex(0)
                                            }
                                            nameFound = true
                                            }
                                    }
                                    //end class name find
                                    //remove char before teacher name
                                    for var i = 0; i < 4; i++ {
                                        characters.removeAtIndex(0)
                                    }
                                    //start check for teacher name
                                    var teacherFound = false
                                    while teacherFound == false {
                                        //look for < (end of the class name)
                                        if let index = characters.indexOf("&") {
                                            for var i = 0; i < index; i++ {
                                                //get characters for the name
                                                teacherNameNew = teacherNameNew + characters[0]
                                                characters.removeAtIndex(0)
                                            }
                                            teacherFound = true
                                        }
                                    }
                                    //end teacher name find
                                    //remove char before room
                                    for var i = 0; i < 8; i++ {
                                        characters.removeAtIndex(0)
                                    }
                                    //start room find
                                    var roomFound = false
                                    while roomFound == false {
                                        //look for < (end of the class name)
                                        if let index = characters.indexOf("<") {
                                            for var i = 0; i < index; i++ {
                                                //get characters for the name
                                                roomNew = roomNew + characters[0]
                                                characters.removeAtIndex(0)
                                            }
                                            roomFound = true
                                        }
                                    }
                                    //end room find
                                    //remove char before time
                                    for var i = 0; i < 51; i++ {
                                        characters.removeAtIndex(0)
                                    }
                                    //start time find
                                    var timeFound = false
                                    while timeFound == false {
                                        //look for < (end of the class name)
                                        if let index = characters.indexOf("<") {
                                            for var i = 0; i < index; i++ {
                                                //get characters for the name
                                                timesNew = timesNew + characters[0]
                                                characters.removeAtIndex(0)
                                            }
                                            timeFound = true
                                        }
                                    }
                                    //end time find
                                    
                                    //check to see if class already exists
                                    var exist = false
                                    for var i = 0; i < classInfo.count; i++ {
                                        if classInfo[i].contains(classNameNew){
                                            exist = true
                                        }
                                    }
                                    if exist == false{
                                        classInfo.append([])
                                        classInfo[classInfo.count - 1].append(classNameNew)
                                        classInfo[classInfo.count - 1].append(teacherNameNew)
                                        classInfo[classInfo.count - 1].append(roomNew)
                                        classInfo[classInfo.count - 1].append(timesNew)
                                    }
                                    classNameNew = ""
                                    teacherNameNew = ""
                                    roomNew = ""
                                    timesNew = ""
                                    courseInfoCreator()
                                    
                                }
                            }
                        }
                    }
                    
                    
                    
                }else {
                    checkResults()
                }
            }
            checkResults()
            UIApplication.sharedApplication().endIgnoringInteractionEvents()
            
        }
    
    }
    
    func loadDateTeacher() {
        let currentURL : NSString = (webView.request?.URL!.absoluteString)!
        if currentURL == "https://powerschool.lexington1.net/teachers/schedulematrix.html"{
            let result = webView.stringByEvaluatingJavaScriptFromString("document.body.innerHTML")
            UIPasteboard.generalPasteboard().string = result
            //let searchCharacter = "e-n"
            
            func checkResults (){
                if result != nil{
                    var classNameNew = ""
                    var roomNew = ""
                    var timesNew = ""
                    //create array
                    var characters = result!.characters.map { String($0) }
                    //go through array
                    for var c = 0; c < characters.count; c++ {
                        //look for e
                        if let index = characters.indexOf("e") {
                            //remove objects before e and e itself
                            for var i = 0; i <= index; i++ {
                                characters.removeAtIndex(0)
                            }
                            //check to see if class name
                            if index + 4 <= characters.count{
                                if characters[0] == "-" && characters[1] == "n"{
                                    for var i = 0; i <= 6; i++ {
                                        characters.removeAtIndex(0)
                                    }
                                    
                                    
                                    //start check for end of name
                                    var nameFound = false
                                    while nameFound == false {
                                        //look for < (end of the class name)
                                        if let index = characters.indexOf("<") {
                                            for var i = 0; i < index; i++ {
                                                //get characters for the name
                                                classNameNew = classNameNew + characters[0]
                                                characters.removeAtIndex(0)
                                            }
                                            nameFound = true
                                        }
                                    }
                                    //end class name find
                                    //</p><p class=\"sched-section-number\">327300AW.1</p><p class=\"sched-room\">Room: R C207</p><p class=\"sched-term\">2(B)&nbsp;3(B,E)&nbsp;4(E)&nbsp;5-6(A)&nbsp;7(D) 15-16<
                                    //CREATE ALGORITHM TO FIND ":" then remove that and 3 characters after
                                    if let index = characters.indexOf(":") {
                                        //remove objects before : and : itself
                                        for var i = 0; i <= index + 3; i++ {
                                            characters.removeAtIndex(0)
                                        }
                                    }
                                    //start room find
                                    var roomFound = false
                                    while roomFound == false {
                                        //look for < (end of the class name)
                                        if let index = characters.indexOf("<") {
                                            for var i = 0; i < index; i++ {
                                                //get characters for the name
                                                if characters[0] != ">" && characters[0] != "/" && characters[0] != "p"{
                                                    roomNew = roomNew + characters[0]
                                                } else {
                                                    roomNew = "No Room"
                                                }
                                                characters.removeAtIndex(0)
                                            }
                                            roomFound = true
                                        }
                                    }
                                    //end room find
                                    //</p><p class=\"sched-term\">2(B)&nbsp;3(B,E)&nbsp;4(E)&nbsp;5-6(A)&nbsp;7(D) 15-16<
                                    //remove char before time
                                    if let index = characters.indexOf("m") {
                                        //remove objects before m and m itself
                                        for var i = 0; i <= index + 2; i++ {
                                            characters.removeAtIndex(0)
                                        }
                                    }
                                    //start time find
                                    var timeFound = false
                                    while timeFound == false {
                                        //look for < (end of the class name)
                                        if let index = characters.indexOf("<") {
                                            for var i = 0; i < index; i++ {
                                                //get characters for the name
                                                if Int(characters[0]) != nil || characters[0] == "A" || characters[0] == "B" || characters[0] == "C" || characters[0] == "D" || characters[0] == "E" || characters[0] == "(" || characters[0] == ")" || characters[0] == " " || characters[0] == "-" {
                                                    if  characters[0] == " " && characters[1] == "1" && characters[2] == "5" && characters[3] == "-" && characters[4] == "1" && characters[5] == "6" {
                                                        characters.removeAtIndex(0)
                                                        characters.removeAtIndex(0)
                                                        characters.removeAtIndex(0)
                                                        characters.removeAtIndex(0)
                                                        characters.removeAtIndex(0)
                                                    } else {
                                                        timesNew = timesNew + characters[0]
                                                    }
                                                }
                                                characters.removeAtIndex(0)
                                            }
                                            timeFound = true
                                        }
                                    }
                                    //end time find
                                    
                                    //check to see if class already exists
                                    var exist = false
                                    for var i = 0; i < classInfo.count; i++ {
                                        if classInfo[i].contains(classNameNew){
                                            exist = true
                                        }
                                    }
                                    if exist == false{
                                        classInfo.append([])
                                        classInfo[classInfo.count - 1].append(classNameNew)
                                        classInfo[classInfo.count - 1].append(roomNew)
                                        classInfo[classInfo.count - 1].append(timesNew)
                                    }
                                    classNameNew = ""
                                    roomNew = ""
                                    timesNew = ""
                                }
                            }
                        }
                    }
                    //print(classInfo)
                    courseInfoCreatorTeacher()
                }else {
                    checkResults()
                }
            }
            checkResults()
            UIApplication.sharedApplication().endIgnoringInteractionEvents()
            
        }
        
    }
    
    func courseInfoCreator() {
        courseInfo.removeAll()
        for var i = 0; i < classInfo.count; i++ {
            
            courseInfo[classInfo[i][0]] = [classInfo[i][1], classInfo[i][2]]
            
            
            //get to this: 1-2
            let rawMods = classInfo[i][3]
            var rawModArray = rawMods.characters.map { String($0) }
            var intermedMods:[String] = []
            var tempArray:[String] = []
            var skip = false
            for r in rawModArray {
                //1-2(A)5-6(C)1-2(D)6(E)
                if Int(r) != nil {
                    
                    
                    //"10(E) 11(D-E) 12(A,D) 13(A)"
                    if Int(rawModArray[rawModArray.indexOf(r)! + 1]) == nil && skip == false{
                        intermedMods.append(r)
                    } else if Int(rawModArray[rawModArray.indexOf(r)! + 1]) != nil{
                        intermedMods.append(String(r) + String(rawModArray[rawModArray.indexOf(r)! + 1]))
                        skip = true
                    } else if skip == true{
                        skip = false
                    }
                    
                    
                    
                }
                if Character(r) == "A"{
                    tempArray.append("Monday")
                }
                if Character(r) == "B"{
                    tempArray.append("Tuesday")
                }
                if Character(r) == "C"{
                    tempArray.append("Wednesday")
                }
                if Character(r) == "D"{
                    tempArray.append("Thursday")
                }
                if Character(r) == "E"{
                    tempArray.append("Friday")
                }
                if Character(r) == ")" {
                    for w in tempArray {
                        
                        for var l:Int = Int(intermedMods[0])!; l <= Int(intermedMods[intermedMods.count - 1])!; l++ {
                            schedule[String(w)]![l]! = classInfo[i][0]
                        }
                    }
                    intermedMods.removeAll()
                    tempArray.removeAll()
                }
                
                rawModArray.removeAtIndex(0)
            }
            
            for var g = 0; g < 5; g++ {
                
                switch g{
                    
                case 0:
                    for var m = 1; m <= 15; m++ {
                        if schedule["Monday"]![m] == "" {
                            
                            schedule["Monday"]![m] = "ILT"
                            
                        }
                    }
                case 1:
                    for var m = 1; m <= 15; m++ {
                        if schedule["Tuesday"]![m] == "" {
                            
                            schedule["Tuesday"]![m] = "ILT"
                            
                        }
                    }
                case 2:
                    for var m = 1; m <= 15; m++ {
                        if schedule["Wednesday"]![m] == "" {
                            schedule["Wednesday"]![m] = "ILT"
                            
                        }
                    }
                case 3:
                    for var m = 1; m <= 15; m++ {
                        if schedule["Thursday"]![m] == "" {
                            schedule["Thursday"]![m] = "ILT"
                            
                        }
                    }
                case 4:
                    for var m = 1; m <= 15; m++ {
                        if schedule["Friday"]![m] == "" {
                            schedule["Friday"]![m] = "ILT"
                            
                        }
                    }
                default:
                    print("oh no")
                    
                }
                
            }
            
        }
        let data = NSKeyedArchiver.archivedDataWithRootObject(schedule)
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: "schedule")
        self.performSegueWithIdentifier("testingSeg", sender: self)
    }
    
    func courseInfoCreatorTeacher() {
        courseInfoTeacher.removeAll()
        for var i = 0; i < classInfo.count; i++ {
            
            courseInfoTeacher[classInfo[i][0]] = classInfo[i][1]
            
            
            //get to this: 1-2
            let rawMods = classInfo[i][2]
            var rawModArray = rawMods.characters.map { String($0) }
            var intermedMods:[String] = []
            var tempArray:[String] = []
            var skip = false
            for r in rawModArray {
                //1-2(A)5-6(C)1-2(D)6(E)
                if Int(r) != nil {
                    
                    
                    //"10(E) 11(D-E) 12(A,D) 13(A)"
                    if Int(rawModArray[rawModArray.indexOf(r)! + 1]) == nil && skip == false{
                        intermedMods.append(r)
                    } else if Int(rawModArray[rawModArray.indexOf(r)! + 1]) != nil{
                        intermedMods.append(String(r) + String(rawModArray[rawModArray.indexOf(r)! + 1]))
                        skip = true
                    } else if skip == true{
                        skip = false
                    }
                    
                    
                    
                }
                if Character(r) == "A"{
                    tempArray.append("Monday")
                }
                if Character(r) == "B"{
                    tempArray.append("Tuesday")
                }
                if Character(r) == "C"{
                    tempArray.append("Wednesday")
                }
                if Character(r) == "D"{
                    tempArray.append("Thursday")
                }
                if Character(r) == "E"{
                    tempArray.append("Friday")
                }
                if Character(r) == ")" {
                    for w in tempArray {
                        
                        for var l:Int = Int(intermedMods[0])!; l <= Int(intermedMods[intermedMods.count - 1])!; l++ {
                            schedule[String(w)]![l]! = classInfo[i][0]
                        }
                    }
                    intermedMods.removeAll()
                    tempArray.removeAll()
                }
                
                rawModArray.removeAtIndex(0)
            }
            var ILTMods: [String : [Int : String]] = 
            for var g = 0; g < 5; g++ {
                
                switch g{
                    
                case 0:
                    for var m = 1; m <= 15; m++ {
                        if schedule["Monday"]![m] == "" {
                            
                            schedule["Monday"]![m] = "ILT"
                            
                        }
                    }
                case 1:
                    for var m = 1; m <= 15; m++ {
                        if schedule["Tuesday"]![m] == "" {
                            
                            schedule["Tuesday"]![m] = "ILT"
                            
                        }
                    }
                case 2:
                    for var m = 1; m <= 15; m++ {
                        if schedule["Wednesday"]![m] == "" {
                            schedule["Wednesday"]![m] = "ILT"
                            
                        }
                    }
                case 3:
                    for var m = 1; m <= 15; m++ {
                        if schedule["Thursday"]![m] == "" {
                            schedule["Thursday"]![m] = "ILT"
                            
                        }
                    }
                case 4:
                    for var m = 1; m <= 15; m++ {
                        if schedule["Friday"]![m] == "" {
                            schedule["Friday"]![m] = "ILT"
                            
                        }
                    }
                default:
                    print("oh no")
                    
                }
                
            }
            
        }
        let data = NSKeyedArchiver.archivedDataWithRootObject(schedule)
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: "schedule")
        self.performSegueWithIdentifier("testingSeg", sender: self)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
