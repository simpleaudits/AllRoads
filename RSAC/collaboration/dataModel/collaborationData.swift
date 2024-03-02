//
//  countofUsers.swift
//  dbtestswift
//
//  Created by macbook on 16/3/19.
//  Copyright © 2019 macbook. All rights reserved.
//


import Foundation
import Firebase

struct collaborationData{

    //This is the basic Audit Settings
    let auditImageURL: String
    let date: String
    let collaborationID: String
    let projectName: String
    let sharedRef: String
    let siteID: String
    let auditID: String
    var isEditable: Bool

    
    init(
        auditImageURL: String,
        date: String,
        collaborationID: String,
        projectName: String,
        sharedRef:String,
        siteID:String,
        auditID:String,
        isEditable: Bool
    )
    
    {
        self.auditImageURL = auditImageURL
        self.date = date
        self.collaborationID = collaborationID
        self.projectName = projectName
        self.sharedRef = sharedRef
        self.siteID = siteID
        self.auditID = auditID
        self.isEditable = isEditable

        
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let auditImageURL = value["auditImageURL"] as? String,
            let date = value["date"] as? String,
            let collaborationID = value["collaborationID"] as? String,
            let projectName = value["projectName"] as? String,
            let sharedRef = value["sharedRef"] as? String,
            let siteID = value["siteID"] as? String,
            let auditID = value["auditID"] as? String,

            let isEditable = value["isEditable"] as? Bool else {
                return nil
        }
        self.auditImageURL = auditImageURL
        self.date = date
        self.collaborationID = collaborationID
        self.projectName = projectName
        self.sharedRef = sharedRef
        self.siteID = siteID
        self.auditID = auditID
        self.isEditable = isEditable
    }
    
    func saveCollabData() -> [String:Any] {
        return [
            "auditImageURL": auditImageURL,
            "date": date,
            "collaborationID": collaborationID,
            "projectName": projectName,
            "sharedRef": sharedRef,
            "siteID": siteID,
            "auditID": auditID,
            "isEditable": isEditable
        ]
    }
}
