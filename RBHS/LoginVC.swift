//
//  LoginVC.swift
//  RBHS
//
//  Created by Emre Cakir on 12/8/15.
//  Copyright © 2015 Coding Empire. All rights reserved.
// 

import UIKit

class LoginVC: UIViewController, GIDSignInUIDelegate {
    
    
    @IBOutlet weak var teacherCodeInput: UITextField!
    @IBOutlet weak var signInButton: GIDSignInButton!
    @IBOutlet weak var powerSchoolBtn: UIButton!
    @IBOutlet weak var lexingtonLabel: UILabel!
    @IBAction func signOut(sender: AnyObject) {
            GIDSignIn.sharedInstance().signOut()
        toggleAuthUI()
    }
    @IBAction func signInBtn(sender: AnyObject) {
        toggleAuthUI()
    }
    @IBAction func powerSchoolBtn(sender: AnyObject) {
        if teacherCodeInput.text == "teacher" {
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "teacher")
        } else {
            NSUserDefaults.standardUserDefaults().removeObjectForKey("teacher")
        }
        _ = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "nextView", userInfo: nil, repeats: false)
    }
    
    func nextView() {
        self.performSegueWithIdentifier("showPowerSchool", sender: self)
    }
    
    
    var isLexington = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
       if NSUserDefaults.standardUserDefaults().objectForKey("teacher") != nil{
            teacherCodeInput.text = "teacher"
        }
        
        // Do any additional setup after loading the view, typically from a nib.
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
      toggleAuthUI()
        
        let nc = NSNotificationCenter.defaultCenter()
        nc.addObserver(self, selector: "toggleAuthUI", name: "UserLoggedIn", object: nil)
    }
    
    func toggleAuthUI() {
        if (GIDSignIn.sharedInstance().hasAuthInKeychain()){
            // Signed in
            signInButton.hidden = true
            
            let email = NSUserDefaults.standardUserDefaults().stringForKey("email")
            if email!.rangeOfString("@lexington1.net") != nil{
                //print("IsLexington1")
                lexingtonLabel.text = "Is Lexington"
                powerSchoolBtn.hidden = false
            } else {
                lexingtonLabel.text = "Not Lexington"
            }
            
        } else {
            lexingtonLabel.text = "Not Logged In"
            signInButton.hidden = false
            powerSchoolBtn.hidden = true
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    
}