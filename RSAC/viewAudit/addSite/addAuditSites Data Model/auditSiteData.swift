//
//  countofUsers.swift
//  dbtestswift
//
//  Created by macbook on 16/3/19.
//  Copyright © 2019 macbook. All rights reserved.
//


import Foundation
import Firebase

struct auditSiteData{

    
    //This is the basic Audit Settings
    let auditTitle: String
    let auditID: String
    let imageURL: String
    let auditDescription: String
    let date: String
    let lat: CGFloat
    let long: CGFloat
    let ref: String
    let siteID: String
    var completed: Bool
    
    
    
    
    init(
        auditTitle: String,
        auditID: String,
        imageURL: String,
        auditDescription: String,
        date: String,
        lat: CGFloat,
        long: CGFloat,
        ref: String,
        siteID: String,
        completed: Bool
    )
    
    
    {
        self.auditTitle = auditTitle
        self.auditID = auditID
        self.imageURL = imageURL
        self.auditDescription = auditDescription
        self.date = date
        self.lat = lat
        self.long = long
        self.ref = ref
        self.siteID = siteID
        self.completed = completed
        
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            
            let auditTitle = value["auditTitle"] as? String,
            let auditID = value["auditID"] as? String,
            let imageURL = value["imageURL"] as? String,
            let auditDescription = value["auditDescription"] as? String,
            let date = value["date"] as? String,
            let lat = value["lat"] as? CGFloat,
            let long = value["long"] as? CGFloat,
            let ref = value["ref"] as? String,
            let siteID = value["siteID"] as? String,
            let completed = value["completed"] as? Bool else {
                return nil
        }
        self.auditTitle = auditTitle
        self.auditID = auditID
        self.imageURL = imageURL
        self.auditDescription = auditDescription
        self.date = date
        self.lat = lat
        self.long = long
        self.ref = ref
        self.siteID = siteID
        self.completed = completed
    }
    
    func saveAuditData() -> [String:Any] {
        return [
            "auditTitle": auditTitle,
            "auditID": auditID,
            "imageURL": imageURL,
            "auditDescription": auditDescription,
            "date": date,
            "lat": lat,
            "long": long,
            "ref": ref,
            "siteID": siteID,
            "completed": completed
        ]
    }
}
