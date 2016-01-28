//
//  FingerAuthController.swift
//  LOTTE_AuthModule
//
//  Created by Kaeul Han on 2016. 1. 22..
//  Copyright © 2016년 Jay. All rights reserved.
//

import Foundation
import UIKit
import LocalAuthentication


class FingerAuthController: UIViewController {
    
    @IBOutlet weak var btn_back: UIButton!
    
    @IBOutlet weak var btn_authorizing: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func btnclick_back(sender: AnyObject) {
        
        self.presentingViewController?.dismissViewControllerAnimated(false, completion: nil)
        
    }
    
    @IBAction func btnclick_authorizing(sender: AnyObject) {
    
        fingerAuthorzing_process()
    
    }
    
    func fingerAuthorzing_process(){
        
        let myContext = LAContext()
        var authError : NSError?
        let localizedReasonText = "지문인증서비스"
        
        if myContext.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error:&authError)
        {
            myContext.evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, localizedReason: localizedReasonText, reply: {(success: Bool, error : NSError?)in
                
                if(success){
                    
                    NSLog("인증성공");
                    self.moveToWebview()
                    
                }
                else
                {
                    self.authorizing_fail(error!)
                }
            })
        }
        else
        {
            NSLog("Device is not supported fingerAuth")
            
            self.authorizing_fail(authError!)
        }
    }
    
    
    func authorizing_fail(error:NSError)
    {
        switch error.code{
          
        case LAError.UserFallback.rawValue:
            self.moveToLogin()
        default:
            print("another error")
        }
    }
    
  
    func moveToWebview(){
        
        let movePage_target = self.storyboard?.instantiateViewControllerWithIdentifier("WebView") as! WebViewController;
        
        // movePage_target.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
        
        self.presentViewController(movePage_target, animated: false, completion: nil)
    }
    
    
    func moveToLogin(){
        
        let movePage_target = self.storyboard?.instantiateViewControllerWithIdentifier("LoginAuth") as! LoginAuthController;
        
        // movePage_target.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
        
        self.presentViewController(movePage_target, animated: false, completion: nil)
    }
}