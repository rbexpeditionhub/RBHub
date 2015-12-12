//
//  HelpNavbar.swift
//  River Bluff High School
//
//  Created by Emre Cakir on 12/2/15.
//  Copyright © 2015 Emre Cakir. All rights reserved.
// 

import UIKit

class HelpNavbar: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        let attributes = [
            NSForegroundColorAttributeName: UIColor.whiteColor(),
            NSFontAttributeName: UIFont.systemFontOfSize(20.0, weight: UIFontWeightMedium)
        ]
        
        self.navigationBar.titleTextAttributes = attributes

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
