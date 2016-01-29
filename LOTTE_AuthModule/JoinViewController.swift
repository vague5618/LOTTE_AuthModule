//
//  JoinViewController.swift
//  LOTTE_AuthModule
//
//  Created by Kaeul Han on 2016. 1. 29..
//  Copyright © 2016년 Jay. All rights reserved.
//


import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class JoinViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var inputText_userEmail: UITextField!
    @IBOutlet weak var inputText_userPasswd: UITextField!
    @IBOutlet weak var inputText_userRepeatPasswd: UITextField!
    @IBOutlet weak var btn_register: UIButton!
    @IBOutlet weak var btn_cancel: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        inputText_userEmail.resignFirstResponder()
        inputText_userPasswd.resignFirstResponder()
        inputText_userRepeatPasswd.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.view.endEditing(true);
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    @IBAction func btnclick_register(sender: AnyObject) {
        
        
        if(inputText_userPasswd.text==inputText_userRepeatPasswd.text
            && !((inputText_userEmail.text)=="")
            && !((inputText_userPasswd.text)=="")
            && !((inputText_userRepeatPasswd.text)==""))
        {
            NSLog("same");
            
            Alamofire.request(.POST, "http://192.168.0.2:4000/member", parameters: ["action_target" : "mobile_joinMember",
                "inputRegisterEmail" : "\(inputText_userEmail.text!)",
                "inputRegisterPassword" : "\(inputText_userPasswd.text!)"])
                .responseJSON{ (responseData) -> Void in
                    
                    let json_var = JSON(responseData.result.value!)
                    
                    let result : NSString = json_var["login_result"].stringValue
                    
                    if result.isEqualToString("true")
                    {
                        self.alertjoinSuccess();
                    }
                        
                    else
                    {
                        self.alertjoinFail()
                    }
            }
        }
        else
        {
            self.alertnotsameFail()
        }
    }
    
    @IBAction func btnclick_cancel(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    func alertjoinSuccess()
    {
        let alertView = UIAlertController(title: "회원가입성공", message: "축하합니다.", preferredStyle: .Alert)
        
        alertView.addAction(UIAlertAction(title: "확인", style: .Cancel, handler: nil))
        self.presentViewController(alertView, animated: true, completion: nil)
    }

    
    func alertjoinFail()
    {
        let alertView = UIAlertController(title: "회원가입 실패", message: "중복되는 아이디입니다.", preferredStyle: .Alert)
        
        alertView.addAction(UIAlertAction(title: "확인", style: .Cancel, handler: nil))
        self.presentViewController(alertView, animated: true, completion: nil)
    }
    
    func alertnotsameFail()
    {
        let alertView = UIAlertController(title: "회원가입 실패", message: "공백이나 비밀번호를 확인해주세요.", preferredStyle: .Alert)
        
        alertView.addAction(UIAlertAction(title: "확인", style: .Cancel, handler: nil))
        self.presentViewController(alertView, animated: true, completion: nil)
    }
    
}
