//
//  PageTutoVC.swift
//  WiSpy
//
//  Created by ingouackaz on 14/10/2015.
//
//

import UIKit

class PageTutoVC: UIViewController {

    @IBOutlet weak var goApplicationButton: UIButton!
    
    var pageIndex : Int = 0
    
    var _viewTuto : UIView?
    
    @IBOutlet weak var viewTuto: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        if let viewTuto = _viewTuto  {
            
            
            
            if(pageIndex == 3){
                let button : UIButton = UIButton(type: UIButtonType.System)
                button.frame = CGRect(x:(self.view.frame.width / 2 ) - 100, y:  self.view.frame.height - 80, width: 200, height: 40)
                button.setTitle("Enjoy !", forState: UIControlState.Normal)
                button.titleLabel!.font =  UIFont(name:"Copperplate-Bold", size: 15)

                button.tintColor = UIColor.whiteColor()
                button.backgroundColor = UIColor.clearColor()
                button.addTarget(self, action: "buttonPressed", forControlEvents: UIControlEvents.TouchUpInside)
                viewTuto.addSubview(button)

                

            }
            self.view = viewTuto

            
         
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
      
        print(_viewTuto)
        
        
  

    }
    
    func buttonPressed(){
    
        self.navigationController!.dismissViewControllerAnimated(true, completion: nil)

    }
    


}
