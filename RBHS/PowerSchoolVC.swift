//
//  PowerSchoolVC.swift
//  RBHS
//
//  Created by Emre Cakir on 12/5/15.
//  Copyright © 2015 Coding Empire. All rights reserved.
// 

import UIKit
import SafariServices
import Parse

class PowerSchoolVC: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var webView: UIWebView!
    
    let mondaySchedule = PFObject(className: "mondaySchedule")
    let tuesdaySchedule = PFObject(className: "tuesdaySchedule")
    let wednesdaySchedule = PFObject(className: "wednesdaySchedule")
    let thursdaySchedule = PFObject(className: "thursdaySchedule")
    let fridaySchedule = PFObject(className: "fridaySchedule")
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
let email = NSUserDefaults.standardUserDefaults().stringForKey("email")
let name = NSUserDefaults.standardUserDefaults().stringForKey("name")
        
        let query = PFQuery(className:"mondaySchedule")
        query.whereKey("email", equalTo: email!)
        print(email!)
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                for object in objects! {
                    print(object)
                    object.deleteInBackground()
                }
            } else {
                // Log details of the failure
                print("New User")
            }
        }

        let query1 = PFQuery(className:"tuesdaySchedule")
        query1.whereKey("email", equalTo: email!)
        query1.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                for object in objects! {
                    object.deleteInBackground()
                }
            } else {
                // Log details of the failure
                print("New User")
            }
        }

        let query2 = PFQuery(className:"wednesdaySchedule")
        query2.whereKey("email", equalTo: email!)
        query2.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                for object in objects! {
                    object.deleteInBackground()
                }
            } else {
                // Log details of the failure
                print("New User")
            }
        }

        let query3 = PFQuery(className:"thursdaySchedule")
        query3.whereKey("email", equalTo: email!)
        query3.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                for object in objects! {
                    object.deleteInBackground()
                }
            } else {
                // Log details of the failure
                print("New User")
            }
        }

        let query4 = PFQuery(className:"fridaySchedule")
        query4.whereKey("email", equalTo: email!)
        query4.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                for object in objects! {
                    object.deleteInBackground()
                }
            } else {
                // Log details of the failure
                print("New User")
            }
        }

            mondaySchedule.setObject(name!, forKey: "Name")
            tuesdaySchedule.setObject(name!, forKey: "Name")
            wednesdaySchedule.setObject(name!, forKey: "Name")
            thursdaySchedule.setObject(name!, forKey: "Name")
            fridaySchedule.setObject(name!, forKey: "Name")
        
        mondaySchedule.setObject(email!, forKey: "email")
        tuesdaySchedule.setObject(email!, forKey: "email")
        wednesdaySchedule.setObject(email!, forKey: "email")
        thursdaySchedule.setObject(email!, forKey: "email")
        fridaySchedule.setObject(email!, forKey: "email")
        
        if NSUserDefaults.standardUserDefaults().objectForKey("teacher") != nil{
        // Do any additional setup after loading the view, typically from a nib.
            let url = NSURL (string: "https://powerschool.lexington1.net/teachers/pw.html")
            let requestObj = NSURLRequest(URL: url!);
            webView.loadRequest(requestObj);


        } else {
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
        
        func loadDateFunctions() {
        
            if let currentURL = (webView.request?.URL!.absoluteString) {
                if currentURL == "https://powerschool.lexington1.net/guardian/attendance.html" || currentURL == "https://powerschool.lexington1.net/teachers/schedulematrix.html"{
                    if NSUserDefaults.standardUserDefaults().objectForKey("teacher") != nil{
                        _ = NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: "loadDateTeacher", userInfo: nil, repeats: false)
                    } else {
                        _ = NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: "loadDate", userInfo: nil, repeats: false)
                    }
                }
            } else {
                loadDateFunctions()
                print("try again")
            }
        }
        
        loadDateFunctions()
        
        

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
    var ILTMods: [String : [Int]] = ["Monday":[], "Tuesday": [], "Wednesday": [], "Thursday": [], "Friday": []]
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
                    
                    print(classInfo)
                    
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
                    var courseIDNew = ""
                    var currentMod = 1
                    var day = ""
                    var characterFoundNumber = 0
                    //create array
                    var characters = result!.characters.map { String($0) }
                    //go through array
                    while characters.count > 0 {
                        //;&
                        //look for rowspan="2"
                        if characters[0] == "r" {
                            
                            let index = characters.indexOf("r")!
                            
                            //check to see if class name
                            if index + 13 <= characters.count {
                                if characters[index + 13] == "<"{
                                    if characters[index + 12] == "A" || characters[index + 12] == "B" || characters[index + 12] == "C" || characters[index + 12] == "D" || characters[index + 12] == "E"{
                                        currentMod = 1
                                        day = characters[index + 12]
                                        print(day)
                                    }
                                }
                                
                            }
                            if index + 32 <= characters.count && characters[index + 1] == "o" && characters[index + 2] == "w"{
                                
                                if characters[index + 31] == "m" || characters[index + 19] == "m"{
                                    for var i = 0; i <= index; i++ {
                                        characters.removeAtIndex(0)
                                    }
                                    for var i = 0; i < 20; i++ {
                                        characters.removeAtIndex(0)
                                    }
                                    
                                    //2\" colspan=\"2\" class=\"matrix_1\"><p class=\"sched-course-name\">Prof Learning</p>
                                    //OUTPUT: 1-2(B)
                                    //start time find
                                    var endMod = currentMod
                                    if characters[4] == "l"{
                                        endMod = currentMod + Int(characters[0])! - 1
                                    }else {
                                        endMod = currentMod
                                    }
                                    
                                    if currentMod != endMod{
                                        timesNew = String(currentMod) + "-" + String(endMod) + "(" + day + ")"
                                    } else if currentMod == endMod{
                                        timesNew = String(endMod) + "(" + day + ")"
                                    }
                                    currentMod = endMod + 1
                                    //end time find
                                    
                                    // go to -
                                    if let index = characters.indexOf("-") {
                                        //remove objects before : and : itself
                                        for var i = 0; i <= index + 13; i++ {
                                            characters.removeAtIndex(0)
                                        }
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
                                    
                                    //Look for " "> " then go to <
                                    for var i = 0; i < 36; i++ {
                                        characters.removeAtIndex(0)
                                    }
                                    //327300AW.1<
                                    var idFound = false
                                    while idFound == false {
                                        //look for < (end of the class name)
                                        if let index = characters.indexOf("<") {
                                            for var i = 0; i < index; i++ {
                                                //get characters for the name
                                                courseIDNew = courseIDNew + characters[0]
                                                characters.removeAtIndex(0)
                                            }
                                            idFound = true
                                        }
                                    }
                                    
                                    //CREATE ALGORITHM TO FIND ":" then remove that and 3 characters after
                                    if let index = characters.indexOf(":") {
                                        //remove objects before : and : itself
                                        for var i = 0; i <= index + 1; i++ {
                                            characters.removeAtIndex(0)
                                        }
                                    }
                                    
                                    //start room find
                                    var roomFound = false
                                    while roomFound == false {
                                        //look for < (end of the class name)
                                        if let index = characters.indexOf("<") {
                                            //get characters for the name
                                            if characters[0] == "R"{
                                                for var i = 0; i <= index; i++ {
                                                    if characters[0] != ">" && characters[0] != "/" && characters[0] != "p" && characters[0] != "<" && characters[0] != "R" && characters[0] != " " {
                                                        roomNew = roomNew + characters[0]
                                                    }
                                                    characters.removeAtIndex(0)
                                                }
                                                roomFound = true
                                            } else {
                                                roomNew = "No Room"
                                                roomFound = true
                                            }
                                            
                                            
                                        }
                                    }
                                    
                                    //end room find
                                    //check to see if class already exists
                                    var exist = false
                                    for var i = 0; i < classInfo.count; i++ {
                                        if classInfo[i].contains(courseIDNew){
                                            classInfo[i][2] = classInfo[i][2] + timesNew
                                            exist = true
                                        }
                                        let editName = String(courseIDNew.characters.dropLast())
                                        editName.characters.dropLast()
                                        let classInfoEdit = String(String(classInfo[i][3]).characters.dropLast())
                                        classInfoEdit.characters.dropLast()
                                        if classInfoEdit == editName && exist == false{
                                            if classInfo[i][0].characters.last != ")" {
                                                let sectionNumber = String(classInfo[i][3]).characters.last!
                                                classInfo[i][0] = classInfo[i][0] + " (Section " + String(sectionNumber) + ")"
                                                
                                            }
                                            if classNameNew.characters.last != ")"{
                                                classNameNew = classNameNew + " (Section " + String(courseIDNew.characters.last!) + ")"
                                            }
                                        }
                                    }
                                    
                                    if exist == false{
                                        classInfo.append([])
                                        classInfo[classInfo.count - 1].append(classNameNew)
                                        classInfo[classInfo.count - 1].append(roomNew)
                                        classInfo[classInfo.count - 1].append(timesNew)
                                        classInfo[classInfo.count - 1].append(courseIDNew)
                                    }
                                    
                                    classNameNew = ""
                                    roomNew = ""
                                    timesNew = ""
                                    courseIDNew = ""
                                    
                                }
                            }
                        } else {
                            if let index = characters.indexOf("r"){
                                if characters.indexOf(";") < characters.indexOf("r") {
                                    if let index1 = characters.indexOf(";"){
                                        if characters[(index1 + 1)] == "&" && characterFoundNumber < 15{
                                            characterFoundNumber = characterFoundNumber + 1
                                        }
                                        if characterFoundNumber == 15{
                                            print("ILT")
                                            currentMod++
                                            characterFoundNumber = 0
                                            print(currentMod)
                                        }
                                        for var i = 0; i <= index1; i++ {
                                            characters.removeAtIndex(0)
                                        }
                                    }
                                }
                            }
                        }
                        characters.removeAtIndex(0)
                    }
                    
                    print(classInfo)
                    courseInfoCreatorTeacher()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()

                    
                }else {
                    checkResults()
                }
        }
            checkResults()
            
        
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
                            if w == "Monday"{
                                mondaySchedule.setObject(classInfo[i][0], forKey: "g" + String(l))
                                print(mondaySchedule)
                            } else if w == "Tuesday"{
                                tuesdaySchedule.setObject(classInfo[i][0], forKey: "g" + String(l))
                            } else if w == "Wednesday"{
                                wednesdaySchedule.setObject(classInfo[i][0], forKey: "g" + String(l))
                            } else if w == "Thursday"{
                                thursdaySchedule.setObject(classInfo[i][0], forKey: "g" + String(l))
                            } else if w == "Friday"{
                                fridaySchedule.setObject(classInfo[i][0], forKey: "g" + String(l))
                            }
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
                            ILTMods["Monday"]!.append(m)
                            mondaySchedule.setObject("ILT", forKey: "g" + String(m))
                            
                            
                        }
                    }
                case 1:
                    for var m = 1; m <= 15; m++ {
                        if schedule["Tuesday"]![m] == "" {
                            
                            schedule["Tuesday"]![m] = "ILT"
                            ILTMods["Tuesday"]!.append(m)
                            tuesdaySchedule.setObject("ILT", forKey: "g" + String(m))
                            
                        }
                    }
                case 2:
                    for var m = 1; m <= 15; m++ {
                        if schedule["Wednesday"]![m] == "" {
                            schedule["Wednesday"]![m] = "ILT"
                            ILTMods["Wednesday"]!.append(m)
                            wednesdaySchedule.setObject("ILT", forKey: "g" + String(m))
                            
                        }
                    }
                case 3:
                    for var m = 1; m <= 15; m++ {
                        if schedule["Thursday"]![m] == "" {
                            schedule["Thursday"]![m] = "ILT"
                            ILTMods["Thursday"]!.append(m)
                            thursdaySchedule.setObject("ILT", forKey: "g" + String(m))
                            
                        }
                    }
                case 4:
                    for var m = 1; m <= 15; m++ {
                        if schedule["Friday"]![m] == "" {
                            schedule["Friday"]![m] = "ILT"
                            ILTMods["Friday"]!.append(m)
                            fridaySchedule.setObject("ILT", forKey: "g" + String(m))
                            
                        }
                    }
                default:
                    print("oh no")
                    
                }
                
            }
        }
        
        print(mondaySchedule)
        mondaySchedule.saveInBackgroundWithBlock { (succeeded, error) -> Void in
            if succeeded {
                print("Object Uploaded")
            } else {
                print("Error: \(error) \(error!.userInfo)")
            }
        }
        tuesdaySchedule.saveInBackgroundWithBlock { (succeeded, error) -> Void in
            if succeeded {
                print("Object Uploaded")
            } else {
                print("Error: \(error) \(error!.userInfo)")
            }
        }
        wednesdaySchedule.saveInBackgroundWithBlock { (succeeded, error) -> Void in
            if succeeded {
                print("Object Uploaded")
            } else {
                print("Error: \(error) \(error!.userInfo)")
            }
        }
        thursdaySchedule.saveInBackgroundWithBlock { (succeeded, error) -> Void in
            if succeeded {
                print("Object Uploaded")
            } else {
                print("Error: \(error) \(error!.userInfo)")
            }
        }
        fridaySchedule.saveInBackgroundWithBlock { (succeeded, error) -> Void in
            if succeeded {
                print("Object Uploaded")
            } else {
                print("Error: \(error) \(error!.userInfo)")
            }
        }
        
        let data = NSKeyedArchiver.archivedDataWithRootObject(schedule)
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: "schedule")
        let dataILT = NSKeyedArchiver.archivedDataWithRootObject(ILTMods)
        NSUserDefaults.standardUserDefaults().setObject(dataILT, forKey: "ILT")
        
        _ = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: "nextView", userInfo: nil, repeats: false)
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
            
            for var g = 0; g < 5; g++ {
                
                switch g{
                    
                case 0:
                    for var m = 1; m <= 15; m++ {
                        if schedule["Monday"]![m] == "" {
                            
                            schedule["Monday"]![m] = "ILT"
                            ILTMods["Monday"]!.append(m)
                            
                        }
                    }
                case 1:
                    for var m = 1; m <= 15; m++ {
                        if schedule["Tuesday"]![m] == "" {
                            
                            schedule["Tuesday"]![m] = "ILT"
                            ILTMods["Tuesday"]!.append(m)

                        }
                    }
                case 2:
                    for var m = 1; m <= 15; m++ {
                        if schedule["Wednesday"]![m] == "" {
                            schedule["Wednesday"]![m] = "ILT"
                            ILTMods["Wednesday"]!.append(m)

                        }
                    }
                case 3:
                    for var m = 1; m <= 15; m++ {
                        if schedule["Thursday"]![m] == "" {
                            schedule["Thursday"]![m] = "ILT"
                            ILTMods["Thursday"]!.append(m)

                        }
                    }
                case 4:
                    for var m = 1; m <= 15; m++ {
                        if schedule["Friday"]![m] == "" {
                            schedule["Friday"]![m] = "ILT"
                            ILTMods["Friday"]!.append(m)

                        }
                    }
                default:
                    print("oh no")
                    
                }
                
            }
            
        }
        let data = NSKeyedArchiver.archivedDataWithRootObject(schedule)
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: "schedule")
        let dataILT = NSKeyedArchiver.archivedDataWithRootObject(ILTMods)
        NSUserDefaults.standardUserDefaults().setObject(dataILT, forKey: "ILT")

        _ = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: "nextView", userInfo: nil, repeats: false)
    }

    func nextView() {
        self.performSegueWithIdentifier("testingSeg", sender: self)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
