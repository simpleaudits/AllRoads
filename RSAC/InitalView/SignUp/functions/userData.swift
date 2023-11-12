//
//  userData.swift
//  dbtestswift
//
//  Created by John on 22/3/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import SwiftLoader


extension SignUpController {
    //this function is fetching the json from URL
    func timeStamp() -> String{
        //creating a NSURL
        
        
        let date = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss z"
        
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        print(dateFormatter.string(from: date as Date))
        let dateNow = date.timeIntervalSince1970
        let UNIXInt = Int(dateNow)
        print("Unix Date" + "\(UNIXInt)")
        
        
        return String(UNIXInt)
    }
    
    
    //SAVE user data.
    
    func processdata(){
        //show progress view
        SwiftLoader.show(title: "Saving User (2/2)", animated: true)

        let index1 = IndexPath(row: 0, section: 0)
        let cell1: SignUpItemsCell = self.collectionView.cellForItem(at: index1) as! SignUpItemsCell
        
        
        if  cell1.userName.text!.count > 0 &&
            cell1.lastName.text!.count > 0 &&
            cell1.Name.text!.count > 0 {
            
          
    
            
//############################################################################
            let uid = Auth.auth().currentUser?.uid
            let saveData = userDetails(UserReferenceLink: "\(self.mainConsole.post!)/\(uid!)/\(self.mainConsole.userDetails!)",
                                       Username: cell1.userName.text!,
                                       orgType: cell1.lastName.text!,
                                       contact: 0,
                                       accountVerificationStatus: true,
                                       userStatus: "bronze",
                                       DPimage: DPDataURL,
                                       listingMax: 3,
                                       nestedNode: "",
                                       dateJoined: timeStamp(),
                                       completed: true)
            
           
            let reftest = Database.database().reference().child("\(self.mainConsole.prod!)")
            let thisUsersGamesRef = reftest.child("\(self.mainConsole.post!)").child(uid!).child("\(self.mainConsole.userDetails!)")
         

            thisUsersGamesRef.setValue(saveData.saveUserData()){
                (error:Error?, ref:DatabaseReference) in
                

                if let error = error {
                    print("Data could not be saved: \(error).")
                    self.errorUpload(errorMessage: "Data could not be saved",subtitle: "\(error)")
                    SwiftLoader.hide()
                    
                } else {
                    print("saved")
                    SwiftLoader.hide()
                    self.successUpload(Message: "Welcome!", subtitle: "")
                }
                  
            }
            
          
//############################################################################
            
        }
        else{
            SwiftLoader.hide()
            self.errorUpload(errorMessage:"Some fields are empty.",subtitle:"Nearly there!")
            
        }
        

        
        

    }
    
    

    
}
    
    
    