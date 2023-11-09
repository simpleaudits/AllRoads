//
//  countofUsers.swift
//  dbtestswift
//
//  Created by macbook on 16/3/19.
//  Copyright © 2019 macbook. All rights reserved.
//


import Foundation
import Firebase

struct auditListData{

    
    //This is the basic Audit Settings
    let auditTitle: String
    let auditReference: String
    let imageURL: String
    let auditDescription: String
    let date: String
    let lat: CGFloat
    let long: CGFloat
    var completed: Bool
    
    
    
    init(
        auditTitle: String,
        auditReference: String,
        imageURL: String,
        auditDescription: String,
        date: String,
        lat: CGFloat,
        long: CGFloat,
        completed: Bool
    )
    
    
    {
        self.auditTitle = auditTitle
        self.auditReference = auditReference
        self.imageURL = imageURL
        self.auditDescription = auditDescription
        self.date = date
        self.lat = lat
        self.long = long
        self.completed = completed
        
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            
            let auditTitle = value["auditTitle"] as? String,
            let auditReference = value["auditReference"] as? String,
            let imageURL = value["imageURL"] as? String,
            let auditDescription = value["auditDescription"] as? String,
            let date = value["date"] as? String,
            let lat = value["lat"] as? CGFloat,
            let long = value["long"] as? CGFloat,
            let completed = value["completed"] as? Bool else {
                return nil
        }
        self.auditTitle = auditTitle
        self.auditReference = auditReference
        self.imageURL = imageURL
        self.auditDescription = auditDescription
        self.date = date
        self.lat = lat
        self.long = long

        self.completed = completed
    }
    
    func addAudit() -> [String:Any] {
        return [
            "auditTitle": auditTitle,
            "auditReference": auditReference,
            "imageURL": imageURL,
            "auditDescription": auditDescription,
            "date": date,
            "lat": lat,
            "long": long,
            "completed": completed
        ]
    }
}
