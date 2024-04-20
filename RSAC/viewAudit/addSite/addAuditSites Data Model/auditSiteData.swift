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
    let observationID: String
    let siteID: String
    let riskRating: Int
    var status: String
    
    let userUploaded: String
    let userUploadedSignature: String
    let userUpladedImage: String
    
    
    
    
    
    init(
        auditTitle: String,
        auditID: String,
        imageURL: String,
        auditDescription: String,
        date: String,
        lat: CGFloat,
        long: CGFloat,
        ref: String,
        observationID: String,
        siteID: String,
        riskRating: Int,
        status: String,
        
        userUploaded: String,
        userUploadedSignature: String,
        userUpladedImage: String
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
        self.observationID = observationID
        self.siteID = siteID
        self.riskRating = riskRating
        self.status = status
        
        self.userUploaded = userUploaded
        self.userUploadedSignature = userUploadedSignature
        self.userUpladedImage = userUpladedImage
        
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
            let riskRating = value["riskRating"] as? Int,
            let observationID = value["observationID"] as? String,
            let siteID = value["siteID"] as? String,
            let userUploaded = value["userUploaded"] as? String,
            let userUploadedSignature = value["userUploadedSignature"] as? String,
            let userUpladedImage = value["userUpladedImage"] as? String,
            let status = value["status"] as? String else {
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
        self.observationID = observationID
        self.riskRating = riskRating
        self.siteID = siteID
        self.status = status
        
        self.userUploaded = userUploaded
        self.userUploadedSignature = userUploadedSignature
        self.userUpladedImage = userUpladedImage
    }
    
    func saveAuditData() -> [String:Any] {
        return [
            "auditTitle": auditTitle,
            "auditID": auditID,
            "imageURL": imageURL,
            "auditDescription": auditDescription,
            "date": date,
            "riskRating": riskRating,
            "lat": lat,
            "long": long,
            "ref": ref,
            "observationID": observationID,
            "siteID": siteID,
            "userUploaded": userUploaded,
            "userUploadedSignature": userUploadedSignature,
            "userUpladedImage": userUpladedImage,
            "status": status
        ]
    }
}
