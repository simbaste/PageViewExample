//
//  ViewController.swift
//  TestPageViewController
//
//  Created by Stephane Darcy SIMO MBA on 19/01/2018.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class PageViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextButton: UIButton!
    
    var pageViewController: UIPageViewController!
    var pageTitles = ["iPhone 8", "iPhone 8 Plus", "iPhone X"]
    var pageImages = [#imageLiteral(resourceName: "iPhone 8"), #imageLiteral(resourceName: "iPhone 8 Plus"), #imageLiteral(resourceName: "iPhone X")]
    var index: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        index = 0
        pageControl.numberOfPages = pageTitles.count

        pageViewController = self.storyboard?.instantiateViewController(withIdentifier: "PageViewController") as! UIPageViewController
        pageViewController.dataSource = self
        let startVC = viewControllerAtIndex(index: index) as ContentViewController
        let viewControllers = [startVC]
        pageViewController.setViewControllers(viewControllers, direction: .forward, animated: true, completion: nil)
        pageViewController.view.frame = CGRect(x: 0, y: 30, width: view.frame.width, height: view.frame.height - 80)
        
        self.addChildViewController(pageViewController)
        self.view.addSubview(pageViewController.view)
        pageViewController.didMove(toParentViewController: self)
    }
    
    private func viewControllerAtIndex(index: Int) -> ContentViewController {
        
        if (index >= pageTitles.count) {
            return ContentViewController()
        }
        
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "ContentViewController") as! ContentViewController
        VC.pageImage = pageImages[index]
        VC.titleText = pageTitles[index]
        VC.pageIndex = index

        return VC
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func skipAction(_ sender: Any) {
        let mainVC = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController")
        self.present(mainVC!, animated: true, completion: nil)
    }
    
    @IBAction func nextAction(_ sender: Any) {
        index = index + 1
        
        if index == pageTitles.count-1 {
            nextButton.setTitle("DONE", for: .normal)
        }
        
        if index == pageTitles.count {
            let mainVC = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController")
            self.present(mainVC!, animated: true, completion: nil)
            return
        }
        pageControl.currentPage = index
        
        let VC = viewControllerAtIndex(index: index) as ContentViewController
        let viewControllers = [VC]
        pageViewController.setViewControllers(viewControllers, direction: .forward, animated: true, completion: nil)
    }
    
    // MARK: - PageViewController DataSource
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pageTitles.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 1
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return nil
    }
    
    
}

