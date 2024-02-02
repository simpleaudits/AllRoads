//
//  countofUsers.swift
//  dbtestswift
//
//  Created by macbook on 16/3/19.
//  Copyright © 2019 macbook. All rights reserved.
//


import Foundation
import Firebase

struct settingsData{

    
    //This is the basic Audit Settings
    let companyName: String
    let date: String
    let userID: String
    let userRef: String
    let imageURL: String
    let signatureURL: String
    let nest1: String
    let nest2: String
    let nest3: String
    let nest4: String
    let nest5: String
    let nest6: String
    var completed: Bool
    
    
    
    init(companyName: String,
        date: String,
     userID: String,
     userRef: String,
     imageURL: String,
     signatureURL: String,
     nest1: String,
         nest2: String,
         nest3: String,
     nest4: String,
     nest5: String,
     nest6: String,
     completed: Bool)
    
    
    {
        self.companyName = companyName
        self.date = date
        self.userID = userID
        self.userRef = userRef
        self.imageURL = imageURL
        self.signatureURL = signatureURL
        self.nest1 = nest1
        self.nest2 = nest2
        self.nest3 = nest3
        self.nest4 = nest4
        self.nest5 = nest5
        self.nest6 = nest6
        self.completed = completed
        
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            
            let companyName = value["companyName"] as? String,
            let date = value["date"] as? String,
            let userID = value["userID"] as? String,
            let userRef = value["userRef"] as? String,
            let imageURL = value["imageURL"] as? String,
            let signatureURL = value["signatureURL"] as? String,
            let nest1 = value["nest1"] as? String,
            let nest2 = value["nest2"] as? String,
            let nest3 = value["nest3"] as? String,
            let nest4 = value["nest4"] as? String,
            let nest5 = value["nest5"] as? String,
            let nest6 = value["nest6"] as? String,
            let completed = value["completed"] as? Bool else {
                return nil
        }
        self.companyName = companyName
        self.date = date
        self.userID = userID
        self.userRef = userRef
        self.imageURL = imageURL
        self.signatureURL = signatureURL
        self.nest1 = nest1
        self.nest2 = nest2
        self.nest3 = nest3
        self.nest4 = nest4
        self.nest5 = nest5
        self.nest6 = nest6
        self.completed = completed
    }
    
    func addSettingsData() -> [String:Any] {
        return [
            "companyName": companyName,
            "date": date,
            "userID": userID,
            "userRef": userRef,
            "imageURL": imageURL,
            "signatureURL": signatureURL,
            "nest1": nest1,
            "nest2": nest2,
            "nest3": nest3,
            "nest4": nest4,
            "nest5": nest5,
            "nest6": nest6,
            "completed": completed
        ]
    }
}
