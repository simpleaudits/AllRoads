//
//  countofUsers.swift
//  dbtestswift
//
//  Created by macbook on 16/3/19.
//  Copyright © 2019 macbook. All rights reserved.
//


import Foundation
import Firebase

struct userDetails{
  

    
    let UserReferenceLink: String
    let companyName: String
    let orgType: String
    let contact: Int
    let accountVerificationStatus: Bool // either yes or no
    let userStatus: String // banned, bronze, silver or gold
    let DPimage: String
    let listingMax: Int

    let dateJoined:String
    var completed: Bool
    let userRef: String
    let signatureURL: String
    let userName: String
    let nest2: String
    let nest3: String
    let nest4: String
    let nest5: String
    let nest6: String

    //[10]
    
    
    init(UserReferenceLink:String,
         companyName:String,
         orgType:String,
         contact:Int,
         accountVerificationStatus: Bool,
         userStatus:String,
         DPimage:String,
         listingMax:Int,
         dateJoined:String,
         completed:Bool,
         userRef: String,
         signatureURL: String,
         userName: String,
         nest2: String,
         nest3: String,
         nest4: String,
         nest5: String,
         nest6: String
        ) {

        self.UserReferenceLink = UserReferenceLink
        self.companyName = companyName
        self.orgType = orgType
        self.contact = contact
        self.accountVerificationStatus = accountVerificationStatus
        self.userStatus = userStatus
        self.DPimage = DPimage
        self.listingMax = listingMax
        self.completed = completed
        self.dateJoined = dateJoined
        self.userRef = userRef
        self.signatureURL = signatureURL
        self.userName = userName
        self.nest2 = nest2
        self.nest3 = nest3
        self.nest4 = nest4
        self.nest5 = nest5
        self.nest6 = nest6


    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            
            let UserReferenceLink = value["UserReferenceLink"] as? String,
            let companyName = value["companyName"] as? String,
            let orgType = value["orgType"] as? String,
            let contact = value["contact"] as? Int,
            let accountVerificationStatus = value["accountVerificationStatus"] as? Bool,
            let userStatus = value["userStatus"] as? String,
            let DPimage = value["DPimage"] as? String,
            let listingMax = value["listingMax"] as? Int,
            let dateJoined = value["dateJoined"] as? String,
            
            let userRef = value["userRef"] as? String,
            let signatureURL = value["signatureURL"] as? String,
            let userName = value["userName"] as? String,
            let nest2 = value["nest2"] as? String,
            let nest3 = value["nest3"] as? String,
            let nest4 = value["nest4"] as? String,
            let nest5 = value["nest5"] as? String,
            let nest6 = value["nest6"] as? String,
            let completed = value["completed"] as? Bool
                
                
                
        
        else {

            return nil
        }

        
        self.UserReferenceLink = UserReferenceLink
        self.companyName = companyName
        self.orgType = orgType
        self.contact = contact
        self.accountVerificationStatus = accountVerificationStatus
        self.userStatus = userStatus
        self.DPimage = DPimage
        self.listingMax = listingMax
        self.dateJoined = dateJoined
        self.completed = completed
        
        
        
        self.userRef = userRef
        self.signatureURL = signatureURL
        self.userName = userName
        self.nest2 = nest2
        self.nest3 = nest3
        self.nest4 = nest4
        self.nest5 = nest5
        self.nest6 = nest6
    }
    
    func saveUserData() -> [String:Any] {
        return [
            "UserReferenceLink": UserReferenceLink,
            "companyName": companyName,
            "orgType": orgType,
            "contact": contact,
            "accountVerificationStatus": accountVerificationStatus,
            "userStatus": userStatus,
            "DPimage": DPimage,
            "listingMax": listingMax,
            "dateJoined": dateJoined,
            "completed": completed,
            
            "userName": userName,
            "nest2": nest2,
            "nest3": nest3,
            "nest4": nest4,
            "nest5": nest5,
            "nest6": nest6,
            "signatureURL": signatureURL,
            "userRef": userRef
            
        ]
    }
}
