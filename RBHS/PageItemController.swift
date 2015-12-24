//
//  PageItemController.swift
//  RBHS
//
//  Created by Emre Cakir on 12/23/15.
//  Copyright © 2015 Coding Empire. All rights reserved.
//

import UIKit

class PageItemController: UIViewController {
    
    // MARK: - Variables
    var itemIndex: Int = 0
    var imageName: String = "" {
        
        didSet {
            
            if let imageView = contentImageView {
                imageView.image = UIImage(named: imageName)
            }
            
        }
    }
    var titleLabel: String = ""
    var descripLabel: String = ""
    
    @IBOutlet var contentImageView: UIImageView?
    @IBOutlet weak var contentTitleLabel: UILabel!
    @IBOutlet weak var contentDescription: UILabel!
    @IBOutlet weak var setupBtn: UIButton!
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if itemIndex == 0 {
            self.view.backgroundColor = UIColor(red:0.16, green:0.48, blue:0.27, alpha:1.0)
            setupBtn.hidden = true
        } else if itemIndex == 1 {
            self.view.backgroundColor = UIColor(red:0.34, green:0.69, blue:0.78, alpha:1.0)
            setupBtn.hidden = true
        } else {
            self.view.backgroundColor = UIColor(red:0.73, green:0.24, blue:0.46, alpha:1.0)
            setupBtn.hidden = false
        }
        contentImageView!.image = UIImage(named: imageName)
        contentTitleLabel.text = titleLabel
        contentDescription.text = descripLabel
    }
}
