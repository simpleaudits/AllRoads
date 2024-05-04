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
    
    
    
    
    //Generate default report configuration Settings-------------------------------------------------[START]
    
    func reportConfiguration(){
        //show progress view
        SwiftLoader.show(title: "Generataring Report Configurations", animated: true)

        let uid = Auth.auth().currentUser?.uid
            
        let reftest = Database.database().reference().child("\(self.mainConsole.prod!)")
       
        let thisUsersGamesRef = reftest
            .child("\(self.mainConsole.post!)")
            .child(uid!)
            .child("\(self.mainConsole.reportConfig!)")


        let saveData = reportConfigData(
            pdfStyle: "1",
            colourStyle: "#FFA500",
            fontStyle: "",
            nest1: "",
            nest2: "",
            nest3: "",
            nest4: "",
            nest5: "",
            completed: true)

            thisUsersGamesRef.setValue(saveData.saveReportConfig()){
                (error:Error?, ref:DatabaseReference) in

                if let error = error {
                    print("Data could not be saved: \(error).")
                    self.errorUpload(errorMessage: "report presets could not be saved",subtitle: "\(error)")
                    SwiftLoader.hide()
                    
                } else {
                    print("saved")
                    SwiftLoader.hide()
                    self.processdata()
                    
      
                    
  
                }
                  
            }
    }
    
    
    //Generate default report configuration Settings-------------------------------------------------[END]
    
    //SAVE user data.
    
    func processdata(){
        //show progress view
        SwiftLoader.show(title: "Saving User (2/2)", animated: true)

        let index1 = IndexPath(row: 0, section: 0)
        let cell1: SignUpItemsCell = self.collectionView.cellForItem(at: index1) as! SignUpItemsCell
        
        
        if  cell1.userName.text!.count > 0 &&
            cell1.lastName.text!.count > 0 &&
            cell1.CompanyName.text!.count > 0 {
            
            
//############################################################################
            let uid = Auth.auth().currentUser?.uid

            
            let saveData = userDetails(
                UserReferenceLink: "\(self.mainConsole.post!)/\(uid!)/\(self.mainConsole.userDetails!)",
                companyName: cell1.CompanyName.text!,
                orgType: cell1.lastName.text!,
                contact: 0,
                accountVerificationStatus: true,
                userStatus: "\(mainConsole.userStatusNotSubbed!)",
                DPimage: DPDataURL,
                listingMax: mainConsole.maxListing!,
                dateJoined: timeStamp(),
                completed: true,
                userRef: "",
                signatureURL: "",
                userName: cell1.userName.text!,
                nest2: "",
                nest3: "",
                nest4: "",
                nest5: "",
                nest6: "")
            
           
            let reftest = Database.database().reference().child("\(self.mainConsole.prod!)")
            let thisUsersGamesRef = reftest.child("\(self.mainConsole.post!)").child(uid!).child("\(self.mainConsole.userDetails!)")
         

            thisUsersGamesRef.setValue(saveData.saveUserData()){
                (error:Error?, ref:DatabaseReference) in
                

                if let error = error {
                    print("Data could not be saved: \(error).")
                    self.errorUpload(errorMessage: "Data could not be saved",subtitle: "\(error)")
                    SwiftLoader.hide()
                    
                } else {
                    print("user info saved")
                    SwiftLoader.hide()
                    
                    //save the users report default data here:
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
    
    
    
