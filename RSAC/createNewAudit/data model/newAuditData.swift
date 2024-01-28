//
//  countofUsers.swift
//  dbtestswift
//
//  Created by macbook on 16/3/19.
//  Copyright © 2019 macbook. All rights reserved.
//


import Foundation
import Firebase

struct newAuditDataset{

    
    //This is the basic Audit Settings
    let locationImageURL: String
    let date: String
    let auditID: String
    let projectName: String
    let location: String
    let projectStage: String
    let auditCover: String
    let lat: CGFloat
    let long: CGFloat
    //---------
    
    let auditProgress: String
    
    
    let auditReference: String
    let nestedNode: String
    var completed: Bool
    
    
    
    init(locationImageURL: String,
        date: String,
     auditID: String,
     projectName: String,
     location: String,
     projectStage: String,
     auditCover: String,
         lat: CGFloat,
         long: CGFloat,
     auditProgress: String,
     auditReference: String,
     nestedNode: String,
     completed: Bool)
    
    
    {
        self.locationImageURL = locationImageURL
        self.date = date
        self.auditID = auditID
        self.projectName = projectName
        self.location = location
        self.projectStage = projectStage
        self.auditCover = auditCover
        self.lat = lat
        self.long = long
        self.auditProgress = auditProgress
        self.auditReference = auditReference
        self.nestedNode = nestedNode
        self.completed = completed
        
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            
            let locationImageURL = value["locationImageURL"] as? String,
            let date = value["date"] as? String,
            let auditID = value["auditID"] as? String,
            let projectName = value["projectName"] as? String,
            let location = value["location"] as? String,
            let projectStage = value["projectStage"] as? String,
            let auditCover = value["auditCover"] as? String,
            let lat = value["lat"] as? CGFloat,
            let long = value["long"] as? CGFloat,
            let auditProgress = value["auditProgress"] as? String,
            let auditReference = value["auditReference"] as? String,
            let nestedNode = value["nestedNode"] as? String,
            let completed = value["completed"] as? Bool else {
                return nil
        }
        self.locationImageURL = locationImageURL
        self.date = date
        self.auditID = auditID
        self.projectName = projectName
        self.location = location
        self.projectStage = projectStage
        self.auditCover = auditCover
        self.lat = lat
        self.long = long
        self.auditProgress = auditProgress
        self.auditReference = auditReference
        self.nestedNode = nestedNode
        self.completed = completed
    }
    
    func addAudit() -> [String:Any] {
        return [
            "locationImageURL": locationImageURL,
            "date": date,
            "auditID": auditID,
            "projectName": projectName,
            "location": location,
            "projectStage": projectStage,
            "auditCover": auditCover,
            "lat": lat,
            "long": long,
            "auditProgress": auditProgress,
            "auditReference": auditReference,
            "nestedNode": nestedNode,
            "completed": completed
        ]
    }
}
