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

class LoginAuthController: UIViewController {
    
    
    @IBOutlet weak var inputText_userEmail: UITextField!
    @IBOutlet weak var inputText_userPasswd: UITextField!
    @IBOutlet weak var btn_login: UIButton!
    @IBOutlet weak var btn_cancel: UIButton!
    
    var loginUrl = NSURL(string:"http://192.168.0.3:2000");
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    @IBAction func btnclick_login(sender: AnyObject) {
        
        
        Alamofire.request(.POST, "http://192.168.0.3:4000/member", parameters: ["action_target" : "mobile_loginMember",
            "inputMemberEmail" : "\(inputText_userEmail.text!)",
            "inputMemberPassword" : "\(inputText_userPasswd.text!)"])
            .responseJSON{ (responseData) -> Void in
                
                let json_var = JSON(responseData.result.value!)
                
                let result : NSString = json_var["login_result"].stringValue
                
                if result.isEqualToString("true")
                {

                }
                
                else
                {
                    
                }
        }
    }


    @IBAction func btnclick_cancel(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(false, completion: nil)
        
    }
    
}