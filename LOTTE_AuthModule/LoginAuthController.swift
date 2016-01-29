//
//  LoginAuthController.swift
//  LOTTE_AuthModule
//
//  Created by Kaeul Han on 2016. 1. 25..
//  Copyright © 2016년 Jay. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class LoginAuthController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var inputText_userEmail: UITextField!
    @IBOutlet weak var inputText_userPasswd: UITextField!
    @IBOutlet weak var btn_login: UIButton!
    @IBOutlet weak var btn_register: UIButton!
    @IBOutlet weak var btn_cancel: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {

        inputText_userEmail.resignFirstResponder()
        inputText_userPasswd.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    
        self.view.endEditing(true);
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    @IBAction func btnclick_login(sender: AnyObject) {
        
        
        Alamofire.request(.POST, "http://192.168.0.2:4000/member", parameters: ["action_target" : "mobile_loginMember",
            "inputMemberEmail" : "\(inputText_userEmail.text!)",
            "inputMemberPassword" : "\(inputText_userPasswd.text!)"])
            .responseJSON{ (responseData) -> Void in
                
                let json_var = JSON(responseData.result.value!)
                
                let result : NSString = json_var["login_result"].stringValue
                
                if result.isEqualToString("true")
                {
                    self.moveToWebview()
                    
                    self.dismissViewControllerAnimated(false, completion: nil)
                }
                
                else
                {
                   self.alertLoginFail()
                }
        }
    }


    @IBAction func btnclick_cancel(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(false, completion: nil)
        
    }
    
    
    @IBAction func btnclick_register(sender: AnyObject) {
        
        
        let movePage_target = self.storyboard?.instantiateViewControllerWithIdentifier("JoinView") as! JoinViewController;
        
        movePage_target.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
        
        self.presentViewController(movePage_target, animated: true, completion: nil)
        
    }
    
    func alertLoginFail()
    {
        let alertView = UIAlertController(title: "로그인 실패", message: "아이디와 패스워드를 확인 후 다시 시도해주세요.", preferredStyle: .Alert)
        
        alertView.addAction(UIAlertAction(title: "확인", style: .Cancel, handler: nil))
        self.presentViewController(alertView, animated: true, completion: nil)
    }
    
    
    func moveToWebview(){
        
        let movePage_target = self.storyboard?.instantiateViewControllerWithIdentifier("WebView") as! WebViewController;
        
        // movePage_target.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
        
        self.presentViewController(movePage_target, animated: false, completion: nil)
        
    }
    
}