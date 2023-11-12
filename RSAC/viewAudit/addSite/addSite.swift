//
//  countofUsers.swift
//  dbtestswift
//
//  Created by macbook on 16/3/19.
//  Copyright © 2019 macbook. All rights reserved.
//


import Foundation
import Firebase

struct addSite{

    
    //This is the basic Audit Settings
    let addSite: String
    let date: String
    let lat: CGFloat
    let long: CGFloat
    var completed: Bool
    
    
    
    init(
        addSite: String,
        date: String,
        lat: CGFloat,
        long: CGFloat,
        completed: Bool
    )
    
    
    {
        self.addSite = addSite
        self.date = date
        self.lat = lat
        self.long = long
        self.completed = completed
        
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            
            let addSite = value["addSite"] as? String,
            let date = value["date"] as? String,
            let lat = value["lat"] as? CGFloat,
            let long = value["long"] as? CGFloat,
            let completed = value["completed"] as? Bool else {
                return nil
        }
        self.addSite = addSite
        self.date = date
        self.lat = lat
        self.long = long

        self.completed = completed
    }
    
    func addSiteData() -> [String:Any] {
        return [
            "addSite": addSite,
            "date": date,
            "lat": lat,
            "long": long,
            "completed": completed
        ]
    }
}
