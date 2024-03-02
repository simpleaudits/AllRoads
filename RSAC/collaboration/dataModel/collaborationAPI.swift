//
//  countofUsers.swift
//  dbtestswift
//
//  Created by macbook on 16/3/19.
//  Copyright © 2019 macbook. All rights reserved.
//


import Foundation
import Firebase

struct collaborationAPI{

    //This is the basic Audit Settings

    let collaborationID: String
    let date: String
    let auditID: String
    let projectName: String
    let sharedRef: String
    var isEditable: Bool
    
    init(
        collaborationID: String,
        date: String,
        auditID: String,
        projectName: String,
        sharedRef:String,
        isEditable: Bool
    )
    
    {
        self.collaborationID = collaborationID
        self.date = date
        self.auditID = auditID
        self.projectName = projectName
        self.sharedRef = sharedRef
        self.isEditable = isEditable
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let collaborationID = value["collaborationID"] as? String,
            let date = value["date"] as? String,
            let auditID = value["auditID"] as? String,
            let projectName = value["projectName"] as? String,
            let sharedRef = value["sharedRef"] as? String,
            let isEditable = value["isEditable"] as? Bool else {
                return nil
        }
   
        self.collaborationID = collaborationID
        self.date = date
        self.auditID = auditID
        self.projectName = projectName
        self.sharedRef = sharedRef
        self.isEditable = isEditable
    }
    
    func saveCollabData() -> [String:Any] {
        return [
            "collaborationID": collaborationID,
            "date": date,
            "auditID": auditID,
            "projectName": projectName,
            "sharedRef": sharedRef,
            "isEditable": isEditable
        ]
    }
}
