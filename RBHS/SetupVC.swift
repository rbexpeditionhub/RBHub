//
//  SetupVC.swift
//  RBHS
//
//  Created by Emre Cakir on 12/23/15.
//  Copyright © 2015 Coding Empire. All rights reserved.
//

class SetupVC: UIViewController, UIPageViewControllerDataSource {
    
    // MARK: - Variables
    private var pageViewController: UIPageViewController?
    
    // Initialize it right away here
    private let contentImages = ["nature_pic_1.png",
        "nature_pic_2.png",
        "nature_pic_3.png"]
    private let contentTitles = ["River Bluff's High School Hub", "Electronic Schedule", "Collaborate With Others During ILT"]
    private let contentBullets = ["• School Information\n• Scan in your Schedule\n• ILT Manager\n• Collaboration and Relationships",
        "• Get notifications when its time to go to class or meet with a teacher\n• Use your ILT wisely by creating goals to accomplish every mod\n• Find your teachers’ schedules quickly and easily",
        "• Ask for help during ILT from peers\n• Earn points for helping peers during ILT\n• Form new friendships\n• Compete with others to have the highest “collaboration” score\n• Earn achievements by helping others"]
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        createPageViewController()
        setupPageControl()
    }
    
    private func createPageViewController() {
        
        let pageController = self.storyboard!.instantiateViewControllerWithIdentifier("PageController") as! UIPageViewController
        pageController.dataSource = self
        
        
        if contentImages.count > 0 {
            let firstController = getItemController(0)!
            let startingViewControllers: NSArray = [firstController]
            pageController.setViewControllers(startingViewControllers as? [UIViewController], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
        }
        
        pageViewController = pageController
        addChildViewController(pageViewController!)
        self.view.addSubview(pageViewController!.view)
        pageViewController!.didMoveToParentViewController(self)
    }
    
    private func setupPageControl() {
        let appearance = UIPageControl.appearance()
        appearance.pageIndicatorTintColor = UIColor.grayColor()
        appearance.currentPageIndicatorTintColor = UIColor.blackColor()
        appearance.backgroundColor = UIColor.whiteColor()
    }
    
    // MARK: - UIPageViewControllerDataSource
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        let itemController = viewController as! PageItemController
        
        if itemController.itemIndex > 0 {
            return getItemController(itemController.itemIndex-1)
        }
        if itemController.itemIndex == 0 {
            self.view.backgroundColor = UIColor(red:0.16, green:0.48, blue:0.27, alpha:1.0)
        } else if itemController.itemIndex == 1 {
            self.view.backgroundColor = UIColor(red:0.34, green:0.69, blue:0.78, alpha:1.0)
        } else if itemController.itemIndex == 2 {
            self.view.backgroundColor = UIColor(red:0.73, green:0.24, blue:0.46, alpha:1.0)
        }
        
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        let itemController = viewController as! PageItemController
        
        if itemController.itemIndex+1 < contentImages.count {
            return getItemController(itemController.itemIndex+1)
        }
        
        return nil
    }
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if (!completed)
        {
            return
        }
        print(pageViewController.viewControllers!.first!.view.tag)
        if pageViewController.viewControllers!.first!.view.tag == 0 {
            print("1")
        } else if pageViewController.viewControllers!.first!.view.tag == 1 {
        
        } else if pageViewController.viewControllers!.first!.view.tag == 2 {
            
        }
    }

    
    private func getItemController(itemIndex: Int) -> PageItemController? {
        print(itemIndex)
        if itemIndex < contentImages.count {
            let pageItemController = self.storyboard!.instantiateViewControllerWithIdentifier("ItemController") as! PageItemController
            pageItemController.itemIndex = itemIndex
            pageItemController.imageName = contentImages[itemIndex]
            pageItemController.titleLabel = contentTitles[itemIndex]
            pageItemController.descripLabel = contentBullets[itemIndex]
            return pageItemController
        }
        
        return nil
    }
    
    // MARK: - Page Indicator
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return contentImages.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
}
