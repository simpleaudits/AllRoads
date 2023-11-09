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
    let ref: DatabaseReference?

    
    let UserReferenceLink: String
    let Username: String
    let orgType: String
    let contact: Int
    let accountVerificationStatus: Bool // either yes or no
    let userStatus: String // banned, bronze, silver or gold
    let DPimage: String
    let listingMax: Int
    let nestedNode:String
    let dateJoined:String
    var completed: Bool
    //[10]
    
    
    init(UserReferenceLink:String,
         Username:String,
         orgType:String,
         contact:Int,
         accountVerificationStatus: Bool,
         userStatus:String,
         DPimage:String,
         listingMax:Int,
         nestedNode:String,
         dateJoined:String,
         completed:Bool) {

        self.UserReferenceLink = UserReferenceLink
        self.Username = Username
        self.orgType = orgType
        self.contact = contact
        self.accountVerificationStatus = accountVerificationStatus
        self.userStatus = userStatus
        self.DPimage = DPimage
        self.listingMax = listingMax
        self.nestedNode = nestedNode
        self.completed = completed
        self.dateJoined = dateJoined
        self.ref = nil


    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            
            let UserReferenceLink = value["UserReferenceLink"] as? String,
            let Username = value["Username"] as? String,
            let orgType = value["orgType"] as? String,
            let contact = value["contact"] as? Int,
            let accountVerificationStatus = value["accountVerificationStatus"] as? Bool,
            let userStatus = value["userStatus"] as? String,
            let DPimage = value["DPimage"] as? String,
            let listingMax = value["listingMax"] as? Int,
            let nestedNode = value["nestedNode"] as? String,
            let dateJoined = value["dateJoined"] as? String,
            let completed = value["completed"] as? Bool
        
        else {

            return nil
        }
        self.ref = snapshot.ref
        
        self.UserReferenceLink = UserReferenceLink
        self.Username = Username
        self.orgType = orgType
        self.contact = contact
        self.accountVerificationStatus = accountVerificationStatus
        self.userStatus = userStatus
        self.DPimage = DPimage
        self.listingMax = listingMax
        self.nestedNode = nestedNode
        self.dateJoined = dateJoined
        self.completed = completed
    }
    
    func saveUserData() -> [String:Any] {
        return [
            "UserReferenceLink": UserReferenceLink,
            "Username": Username,
            "orgType": orgType,
            "contact": contact,
            "accountVerificationStatus": accountVerificationStatus,
            "userStatus": userStatus,
            "DPimage": DPimage,
            "listingMax": listingMax,
            "nestedNode": nestedNode,
            "dateJoined": dateJoined,
            "completed": completed
        ]
    }
}
