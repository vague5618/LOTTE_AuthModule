//
//  DBUtil.swift
//  LOTTE_AuthModule
//
//  Created by Kaeul Han on 2016. 1. 29..
//  Copyright © 2016년 Jay. All rights reserved.
//

import Foundation


class DBUtil{

    var dbPath = NSString()
    let FileManager = NSFileManager.defaultManager()
    let dirPaths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
    
    init()
    {

     let docsDir = dirPaths[0] as String
   
     dbPath = docsDir.stringByAppendingString("/test.db")
        
        if !FileManager.fileExistsAtPath(dbPath as String) {
            
            // FMDB 인스턴스를 이용하여 DB 체크
            let connectDB = FMDatabase(path:dbPath as String)
            if connectDB == nil {
                print("init_db Error : \(connectDB.lastErrorMessage())");
            }
            
            if connectDB.open(){
                
                let sql_stmt = "CREATE TABLE IF NOT EXISTS CONTACTS ( ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, ADDRESS TEXT, PHONE TEXT)"
                
                if !connectDB.executeStatements(sql_stmt) {
                    print("execute_stmt Error : \(connectDB.lastErrorMessage())")
                }
                
                connectDB.close()
            }
                
            else{
                print("open_db Error : \(connectDB.lastErrorMessage())")
            }
        }
    }
    
    func getConnection_DB() -> FMDatabase
    {
        let connectDB = FMDatabase(path: dbPath as String)
    
        return connectDB
    }
    
    
    func insertMember(inputUserName : NSString?, inputUserAddress : NSString?, inputUserPhone :NSString?)
    {
        let connectDB = getConnection_DB()
       
        
        let sql_stmt = "INSERT INTO CONTACTS (name, address, phone) VALUES ('\(inputUserName!)', '\(inputUserAddress)', '\(inputUserPhone!)')"

        
        let result = connectDB.executeUpdate(sql_stmt, withArgumentsInArray: nil)
        
        // insert 실패
        if !result{
            print("execute_stmt Error : \(connectDB.lastErrorMessage())")
        }
            
        // insert 성공
        else
        {
            
        }
        
    }
    
    
    func checkIdMember(inputUserName : NSString?)
    {
        let connectDB = getConnection_DB();
        var result_address : NSString?;
        var result_phone : NSString?;
        
        let sql_stmt = "SELECT address, phone FROM CONTACTS WHERE name = '\(inputUserName!)'"
        
        
        
        if connectDB.open() {
        
            let results:FMResultSet? = connectDB.executeQuery(sql_stmt, withArgumentsInArray: nil)
            
            //결과가 있다면
            
            if results?.next() == true {
                result_address = results?.stringForColumn("address")
                result_phone = results?.stringForColumn("phone")
            
                print("result_address = \(result_address)");
                print("result_phone = \(result_phone)");

            }
            
            //결과가 없다면
                
            else{
                
                
            }
            
            connectDB.close()
        }else{
            print("open_db Error : \(connectDB.lastErrorMessage())")
        }
    }
}