//
//  TutoVC.swift
//  WiSpy
//
//  Created by ingouackaz on 14/10/2015.
//
//

import UIKit

class TutoVC: UIViewController, UIPageViewControllerDataSource {

    var pageViewController : UIPageViewController?
    var currentIndex : Int = 0
    var _views : [UIView] = []
    var _color : [UIColor] = [UIColor.redColor(),UIColor.yellowColor(),UIColor.purpleColor()]

    override func viewDidLoad() {
        super.viewDidLoad()

       _views = NSBundle.mainBundle().loadNibNamed("TutosView", owner: self, options: nil) as! [UIView]

      //  _views = [UIView(),UIView(),UIView() ]
        UIPageControl.appearance().numberOfPages = _views.count
        
        for (_, _) in _views.enumerate()
        {
            self.pageViewController = self.storyboard!.instantiateViewControllerWithIdentifier("PageViewController") as? UIPageViewController
            self.pageViewController!.dataSource = self

            
            let startingViewController: PageTutoVC = self.viewControllerAtIndex(0)!
            let viewControllers: NSArray = [startingViewController]
            
            self.pageViewController!.setViewControllers(viewControllers as? [UIViewController], direction: .Forward, animated: false, completion: nil)
            self.addChildViewController(self.pageViewController!)
            self.view.addSubview(self.pageViewController!.view)
            self.pageViewController!.didMoveToParentViewController(self)
            
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController?
    {
        var index = (viewController as! PageTutoVC).pageIndex
        
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        
        index--
        
        return viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController?
    {
        var index = (viewController as! PageTutoVC).pageIndex
        
        if index == NSNotFound {
            return nil
        }
        
        index++
        
        if (index == _views.count) {
            return nil
        }
        
        return viewControllerAtIndex(index)
    }
    
    func viewControllerAtIndex(index: Int) -> PageTutoVC?
    {
        if _views.count == 0 || index >= _views.count
        {
            return nil
        }
        
        // Create a new view controller and pass suitable data.
        let pageContentViewController : PageTutoVC = self.storyboard!.instantiateViewControllerWithIdentifier("pageTuto") as! PageTutoVC
        
        let view = NSBundle.mainBundle().loadNibNamed("TutosView", owner: self, options: nil)[index] as! UIView
        pageContentViewController._viewTuto = view
        
        pageContentViewController.pageIndex = index
        currentIndex = index
        
        return pageContentViewController
    }
    
  
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int
    {
        return _views.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int
    {
        return _views.count
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
