//
//  countofUsers.swift
//  dbtestswift
//
//  Created by macbook on 16/3/19.
//  Copyright © 2019 macbook. All rights reserved.
//


import Foundation
import Firebase

struct listOfUsers{

    
    //This is the basic Audit Settings
    let userURL: String
    let collabRef:String
    let AuditRef: String
    
    //---------
    

    
    
    init(userURL: String,
        collabRef:String,
         AuditRef:String
    )
    
    
    {
        self.userURL = userURL
        self.collabRef = collabRef
        self.AuditRef = AuditRef
       
        
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let userURL = value["userURL"] as? String,
            let collabRef = value["collabRef"] as? String,
            let AuditRef = value["AuditRef"] as? String
        else {
                return nil
        }
        self.userURL = userURL
        self.collabRef = collabRef
        self.AuditRef = AuditRef
       
    }
    
    func addUserToList() -> [String:Any] {
        return [
            "userURL": userURL,
            "collabRef": collabRef,
            "AuditRef": AuditRef
          
        ]
    }
}
