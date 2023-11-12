//
//  Save.swift
//  waiter+
//
//  Created by John on 6/9/2023.
//

import Foundation
import Firebase
import SwiftLoader

class saveLocal: UIViewController {
    
    let mainConsole = CONSOLE()
    let mainFunction = extens()
    //let mainSearchViewFunc = mainSearchView()
    var listenForUpdate = String()
    
    func updateAuditProgress(auditProgress:String, auditID:String){
        
        SwiftLoader.show(title: "Updating", animated: true)
        let uid = Auth.auth().currentUser?.uid
        let reftest = Database.database().reference()
            .child("\(self.mainConsole.prod!)")
        let auditData = reftest
            .child("\(self.mainConsole.post!)")
            .child(uid!)
            .child("\(self.mainConsole.audit!)")
            .child("\(auditID)")
//            .child("\(self.mainConsole.auditList!)")
//            .child("\(uuid)")
        
        auditData.updateChildValues([
            "auditProgress": auditProgress,
   
            
        ]){
            (error:Error?, ref:DatabaseReference) in
            if let error = error {
                print("Data could not be saved: \(error).")
                
                SwiftLoader.hide()
                self.mainFunction.errorUpload(errorMessage: "Data could not be saved",subtitle: "\(error)")
                
   
                
            } else {
                
                print("Data saved successfully!")
                
                self.mainFunction.successUpload(Message: "Uploaded", subtitle: "")
                SwiftLoader.hide()
                
                
            }
        }
  
    }
   
}