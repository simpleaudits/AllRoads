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
    let userUID: String
    let auditImageURL: String
    let date: String
    let projectName: String
    let sharedRef: String
    let AuditRef: String
    let auditID: String
    let collabRef:String
    var isEditable: Bool

    
    init(
        userUID: String,
        auditImageURL: String,
        date: String,
        projectName: String,
        sharedRef:String,
        AuditRef:String,
        auditID:String,
        collabRef:String,
        isEditable: Bool
    )
    
    {
        self.userUID = userUID
        self.auditImageURL = auditImageURL
        self.date = date
        self.projectName = projectName
        self.sharedRef = sharedRef
        self.AuditRef = AuditRef
        self.auditID = auditID
        self.collabRef = collabRef
        self.isEditable = isEditable

        
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let userUID = value["userUID"] as? String,
            let auditImageURL = value["auditImageURL"] as? String,
            let date = value["date"] as? String,
            let projectName = value["projectName"] as? String,
            let sharedRef = value["sharedRef"] as? String,
            let AuditRef = value["AuditRef"] as? String,
            let auditID = value["auditID"] as? String,
            let collabRef = value["collabRef"] as? String,
            let isEditable = value["isEditable"] as? Bool else {
                return nil
        }
        self.userUID = userUID
        self.auditImageURL = auditImageURL
        self.date = date
        self.projectName = projectName
        self.sharedRef = sharedRef
        self.AuditRef = AuditRef
        self.auditID = auditID
        self.collabRef = collabRef
        self.isEditable = isEditable
    }
    
    func saveCollabData() -> [String:Any] {
        return [
            "userUID": userUID,
            "auditImageURL": auditImageURL,
            "date": date,
            "projectName": projectName,
            "sharedRef": sharedRef,
            "AuditRef": AuditRef,
            "auditID": auditID,
            "collabRef": collabRef,
            "isEditable": isEditable
        ]
    }
}
