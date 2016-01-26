//
//  WebViewController.swift
//  LOTTE_AuthModule
//
//  Created by Kaeul Han on 2016. 1. 26..
//  Copyright © 2016년 Jay. All rights reserved.
//

import Foundation
import UIKit

class WebViewController: UIViewController {
    
    @IBOutlet var webview_default: UIWebView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let target_url = NSURL(string: "http://192.168.0.3:3000")//"http://192.168.0.3:3000/")
        let requestObj = NSURLRequest(URL: target_url!)
        webview_default.loadRequest(requestObj)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}