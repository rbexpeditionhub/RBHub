//
//  GetHelpVC>swift
//  RBHS
//
//  Created by Mihir Dutta on 12/30/15.
//  Copyright © 2015 Coding Empire. All rights reserved.
//

import UIKit
import Parse

class GetHelpVC: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet var nameField: UITextField!
    @IBOutlet var topicField: UITextView!
    @IBOutlet var locationField: UITextField!
    @IBOutlet var requestButton: UIBarButtonItem!
    
    @IBAction func cancelBtn(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func requestHelpBtn(sender: AnyObject) {
        print("Requesting")
        print(nameField.text!)
        print(topicField.text)
        print(locationField.text!)
        self.dismissViewControllerAnimated(true, completion: nil)
        //saving to Parse
        let seekingHelp = PFObject(className: "seekingHelp")
        seekingHelp.setObject(nameField.text!, forKey: "Student")
        seekingHelp.setObject(topicField.text, forKey: "Topic")
        seekingHelp.setObject(locationField.text!, forKey: "Topic")
        seekingHelp.saveInBackgroundWithBlock { (succeeded, error) -> Void in
            if succeeded {
                print("Object Uploaded")
            } else {
                print("Error: \(error) \(error!.userInfo)")
            }
        } //Ends Here
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameField.delegate = self
        topicField.delegate = self
        locationField.delegate = self
        
        requestButton.enabled = false
        
    }
    
   
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool
    {
        if nameField.text != "" && topicField.text != "" && locationField.text != "" {
            requestButton.enabled = true
        }
        else {
            requestButton.enabled = false
        }
        return true
    }

}
