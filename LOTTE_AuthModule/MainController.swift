//
//  ViewController.swift
//  LOTTE_AuthModule
//
//  Created by Kaeul Han on 2016. 1. 22..
//  Copyright © 2016년 Jay. All rights reserved.
//

import UIKit

class MainController: UIViewController {

    @IBOutlet weak var btn_speechAuth: UIButton!
    
    @IBOutlet weak var btn_fingerAuth: UIButton!
    
    @IBOutlet weak var btn_loginAuth: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    @IBAction func btnclick_speechAuth(sender: AnyObject) {
    
        let movePage_target = self.storyboard?.instantiateViewControllerWithIdentifier("SpeechAuth") as! SpeechAuthController;
        
        movePage_target.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
        
        self.presentViewController(movePage_target, animated: true, completion: nil)
    
    }

    @IBAction func btnclick_fingerAuth(sender: AnyObject) {
        
        let movePage_target = self.storyboard?.instantiateViewControllerWithIdentifier("FingerAuth") as! FingerAuthController;
        
        movePage_target.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
        
        self.presentViewController(movePage_target, animated: true, completion: nil)
        
    }
    
    @IBAction func btnclick_loginAuth(sender: AnyObject) {
        
        let movePage_target = self.storyboard?.instantiateViewControllerWithIdentifier("LoginAuth") as! LoginAuthController;
        
       // movePage_target.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
        
        self.presentViewController(movePage_target, animated: false, completion: nil)
        
    }
}

