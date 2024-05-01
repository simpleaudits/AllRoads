//
//  countofUsers.swift
//  dbtestswift
//
//  Created by macbook on 16/3/19.
//  Copyright © 2019 macbook. All rights reserved.
//


import Foundation
import Firebase

struct reportConfigData{

    let pdfStyle: String
    let colourStyle: String
    let fontStyle: String
    
    
    
    let nest1: String
    let nest2: String
    let nest3: String
    let nest4: String
    let nest5: String
    

    
    var completed: Bool
    

    
    init(pdfStyle: String, colourStyle: String, fontStyle: String, nest1:String,nest2:String,nest3:String, nest4:String,nest5:String,completed: Bool) {

        self.pdfStyle = pdfStyle
        self.colourStyle = colourStyle
        self.fontStyle = fontStyle
        
        self.nest1 = nest1
        self.nest2 = nest2
        self.nest3 = nest3
        self.nest4 = nest4
        self.nest5 = nest5
        
     
      
        
        
        self.completed = completed
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let pdfStyle = value["pdfStyle"] as? String,
            let colourStyle = value["colourStyle"] as? String,
            let fontStyle = value["fontStyle"] as? String,

            
            let nest1 = value["nest1"] as? String,
            let nest2 = value["nest2"] as? String,
            let nest3 = value["nest3"] as? String,
            let nest4 = value["nest4"] as? String,
            let nest5 = value["nest5"] as? String,
                
            let completed = value["completed"] as? Bool else {
                return nil
        }
        
        self.pdfStyle = pdfStyle
        self.colourStyle = colourStyle
        self.fontStyle = fontStyle
  
        
        
        self.nest1 = nest1
        self.nest2 = nest2
        self.nest3 = nest3
        self.nest4 = nest4
        self.nest5 = nest5
        
        
        self.completed = completed
    }
    
    func saveReportConfig() -> [String:Any] {
        return [
            "pdfStyle": pdfStyle,
            "colourStyle": colourStyle,
            "fontStyle": fontStyle,
    
            
            "nest1": nest1,
            "nest2": nest2,
            "nest3": nest3,
            "nest4": nest4,
            "nest5": nest5,
            
            "completed": completed
        ]
    }
}
