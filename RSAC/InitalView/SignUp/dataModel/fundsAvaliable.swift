//
//  countofUsers.swift
//  dbtestswift
//
//  Created by macbook on 16/3/19.
//  Copyright © 2019 macbook. All rights reserved.
//


import Foundation
import Firebase

struct fundsAUD{

    let funds: Int
    let date: String
    let status: String
    let transactionID: String
    var completed: Bool
    
    
    
    init(funds: Int, date: String,transactionID:String, status: String, completed: Bool) {

        self.funds = funds
        self.date = date
        self.status = status
        self.transactionID = transactionID
        self.completed = completed
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let funds = value["funds"] as? Int,
            let date = value["date"] as? String,
            let status = value["status"] as? String,
            let transactionID = value["transactionID"] as? String,
            let completed = value["completed"] as? Bool else {
                return nil
        }
        
        self.funds = funds
        self.date = date
        self.status = status
        self.transactionID = transactionID
        self.completed = completed
    }
    
    func addFunds() -> [String:Any] {
        return [
            "funds": funds,
            "date": date,
            "status": status,
            "transactionID": transactionID,
            "completed": completed
        ]
    }
}
