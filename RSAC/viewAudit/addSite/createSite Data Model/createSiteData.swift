//
//  countofUsers.swift
//  dbtestswift
//
//  Created by macbook on 16/3/19.
//  Copyright © 2019 macbook. All rights reserved.
//


import Foundation
import Firebase

struct createSiteData{

    
    //This is the basic Audit Settings
    let siteName: String
    let date: String
    let lat: CGFloat
    let long: CGFloat
    let ref: String
    let siteID: String
    var completed: Bool
    let status: String
    let observationCount: String
    
    
    
    init(
        siteName: String,
        date: String,
        lat: CGFloat,
        long: CGFloat,
        ref:String,
        siteID:String,
        status:String,
        observationCount:String,
        completed: Bool
    )
    
    
    {
        self.siteName = siteName
        self.date = date
        self.lat = lat
        self.long = long
        self.ref = ref
        self.siteID = siteID
        self.observationCount = observationCount
        self.completed = completed
        self.status = status
        
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            
            let siteName = value["siteName"] as? String,
            let date = value["date"] as? String,
            let lat = value["lat"] as? CGFloat,
            let long = value["long"] as? CGFloat,
            let ref = value["ref"] as? String,
            let observationCount = value["observationCount"] as? String,
            let siteID = value["siteID"] as? String,
            let status = value["status"] as? String,
            let completed = value["completed"] as? Bool else {
                return nil
        }
        self.siteName = siteName
        self.date = date
        self.lat = lat
        self.long = long
        self.ref = ref
        self.siteID = siteID
        self.observationCount = observationCount
        self.status = status
        self.completed = completed
    }
    
    func saveSiteData() -> [String:Any] {
        return [
            "siteName": siteName,
            "date": date,
            "lat": lat,
            "long": long,
            "observationCount": observationCount,
            "ref": ref,
            "status": status,
            "siteID": siteID,
            "completed": completed
        ]
    }
}
