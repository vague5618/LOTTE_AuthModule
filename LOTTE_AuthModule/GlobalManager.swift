//
//  GlobalManager.swift
//  LOTTE_AuthModule
//
//  Created by Kaeul Han on 2016. 1. 28..
//  Copyright © 2016년 Jay. All rights reserved.
//

import Foundation


@objc class GlobalManager :NSObject{
    
    static var global_dict :NSString = "";
    
    static func get_dict() -> NSString
    {
        return global_dict
    }
    
    static func set_dict(source:NSString)
    {
        NSLog("setting");
        global_dict = source;
    }
}
