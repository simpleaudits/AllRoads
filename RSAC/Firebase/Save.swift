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
    
    //storage for image
    let storageReference = Storage.storage().reference()
    
    
    func addToUserCollabList(auditID:String, userUID:String, collabRef:String, AuditRef: String){
        
                //show progress view
        

                    let uid = Auth.auth().currentUser?.uid
                    
                    let reftest = Database.database().reference().child("\(self.mainConsole.prod!)")
                    let thisUsersGamesRef = reftest
                        .child("\(self.mainConsole.post!)")
                        .child(userUID)
                        .child("\(self.mainConsole.audit!)")
                        .child("\(auditID)")
                        .child("\(self.mainConsole.userCollaborationList!)")
                        .child("\(uid!)")
        
        
        
                   let userURL = "\(self.mainConsole.prod!)/\(self.mainConsole.post!)/\(uid!)/\(self.mainConsole.userDetails!)"
             
        
                   let saveData = listOfUsers(userURL: userURL,
                                              collabRef: collabRef,
                                              AuditRef: AuditRef)
        
                    thisUsersGamesRef.setValue(saveData.addUserToList()){
                        (error:Error?, ref:DatabaseReference) in

                        if let error = error {
                            print("Data could not be saved: \(error).")
                            self.mainFunction.errorUpload(errorMessage: "Data could not be saved",subtitle: "\(error)")
                            SwiftLoader.hide()
                            
                        } else {
                            print("Collaborators data saved to project sponsors list")
                            SwiftLoader.hide()
                            self.mainFunction.successUpload(Message: "Welcome", subtitle: "")
                            
          
                        }
                          
                    }
        
    }
    
 
    func addCollab(userUID: String,auditImageURL: String,date: String,projectName: String,sharedRef: String,auditID: String,isEditable: Bool, collaborationID:String){
        
                //show progress view
                SwiftLoader.show(title: "Loading..", animated: true)

                    let uid = Auth.auth().currentUser?.uid
                    
                    let reftest = Database.database().reference().child("\(self.mainConsole.prod!)")
                    let thisUsersGamesRef = reftest
                        .child("\(self.mainConsole.post!)")
                        .child(uid!)
                        .child("\(self.mainConsole.collaborationList!)")
                        .child("\(collaborationID)")
       
        
        //collaborators reference
                    let collabData = "\(self.mainConsole.prod!)/\(self.mainConsole.post!)/\(uid!)/\(self.mainConsole.collaborationList!)/\(collaborationID)"
        //sponsors reference
                    let AuditRef = "\(self.mainConsole.prod!)/\(self.mainConsole.post!)/\(userUID)/\(self.mainConsole.audit!)/\(auditID)/\(self.mainConsole.userCollaborationList!)/\(uid!)"
        
                    let saveData = collaborationData(userUID: userUID,
                                                     auditImageURL: auditImageURL,
                                                     date: date,
                                                     projectName: projectName,
                                                     sharedRef: sharedRef,
                                                     AuditRef: AuditRef,
                                                     auditID: auditID,
                                                     collabRef: collabData,
                                                     isEditable: isEditable
                                                     )
        
                    thisUsersGamesRef.setValue(saveData.saveCollabData()){
                        (error:Error?, ref:DatabaseReference) in

                        if let error = error {
                            print("Data could not be saved: \(error).")
                            self.mainFunction.errorUpload(errorMessage: "Data could not be saved",subtitle: "\(error)")
                            SwiftLoader.hide()
                            
                        } else {
                            print("Data saved to collaborators list")
                            //add the collab user details to the list of collaborators in the sponsor view
                            self.addToUserCollabList(auditID: auditID, userUID: userUID, collabRef: collabData, AuditRef: AuditRef)
                            

                            
          
                        }
                          
                    }
        
    }
    
    
    func createCollaborationAPI(collaborationID:String, date: String, projectName: String, isEditable:Bool, auditID:String){
        
                //show progress view
                SwiftLoader.show(title: "Creating Site", animated: true)

                    let uid = Auth.auth().currentUser?.uid
                    
                    let reftest = Database.database().reference().child("\(self.mainConsole.prod!)")
                    let thisUsersGamesRef = reftest
                        .child("\(self.mainConsole.collaborationList!)")
                        .child("\(collaborationID)")
       
                    
                    //let collabData = "\(self.mainConsole.prod!)/\(self.mainConsole.post!)/\(uid!)/\(self.mainConsole.audit!)/\(auditID)"
            
        
                    let collabData = "\(self.mainConsole.prod!)/\(self.mainConsole.collaborationList!)/\(auditID)"

                    let saveData = collaborationAPI(
                        userUID: "\(uid!)",
                        date: date,
                        auditID: auditID,
                        projectName: projectName,
                        sharedRef: collabData,
                        isEditable: isEditable)
        
                    thisUsersGamesRef.setValue(saveData.saveCollabData()){
                        (error:Error?, ref:DatabaseReference) in

                        if let error = error {
                            print("Data could not be saved: \(error).")
                            self.mainFunction.errorUpload(errorMessage: "Data could not be saved",subtitle: "\(error)")
                            SwiftLoader.hide()
                            
                        } else {
                            print("saved")
                            SwiftLoader.hide()
     
                            self.mainFunction.successUpload(Message: "Uploaded", subtitle: "")
                            
          
                        }
                          
                    }
        
    }
    
    
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
    
    func updateSiteProgress(siteStatus:String, auditID:String){
        //status is either: "active" or "not active"
        
        SwiftLoader.show(title: "Updating", animated: true)
        let uid = Auth.auth().currentUser?.uid
        let reftest = Database.database().reference()
            .child("\(self.mainConsole.prod!)")
        let auditData = reftest
            .child("\(self.mainConsole.post!)")
            .child(uid!)
            .child("\(self.mainConsole.audit!)")
            .child("\(auditID)")
        
        
        auditData.updateChildValues([
            "status": siteStatus,
            
            
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
    func updateObservationCount(count:String, auditID:String,siteID:String,userUID:String ){
        //status is either: "active" or "not active"
       
        //This goes to: siteList node
        
        SwiftLoader.show(title: "Updating", animated: true)
        let uid = Auth.auth().currentUser?.uid
        
        if userUID != uid!{
            //collaborator
            
            let reftest = Database.database().reference()
                .child("\(self.mainConsole.prod!)")
            let auditData = reftest
                .child("\(self.mainConsole.post!)")
                .child(userUID)
                .child("\(self.mainConsole.audit!)")
                .child("\(auditID)")
                .child("\(self.mainConsole.siteList!)")
                .child("\(siteID)")
            
            print("obscount ref:\(auditData)")
            
            auditData.updateChildValues([
                "observationCount": count,
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
        }else{
            //sponsor
            let reftest = Database.database().reference()
                .child("\(self.mainConsole.prod!)")
            let auditData = reftest
                .child("\(self.mainConsole.post!)")
                .child(uid!)
                .child("\(self.mainConsole.audit!)")
                .child("\(auditID)")
                .child("\(self.mainConsole.siteList!)")
                .child("\(siteID)")
            
            print("obscount ref:\(auditData)")
            
            auditData.updateChildValues([
                "observationCount": count,
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
    func updateColourPreference(colourStyle:String, ref:String){
        //status is either: "active" or "not active"
       
        //This goes to: siteList node
        
        SwiftLoader.show(title: "Updating", animated: true)
        let reftest = Database.database().reference(withPath:"\(ref)")
        
        
        reftest.updateChildValues([
            "colourStyle": colourStyle,
        ]){
            (error:Error?, ref:DatabaseReference) in
            if let error = error {
                print("Data could not be saved: \(error).")
                
                SwiftLoader.hide()
                self.mainFunction.errorUpload(errorMessage: "Data could not be saved",subtitle: "\(error)")
                
                
                
            } else {
                
                print("Data saved successfully!")
                
                self.mainFunction.successUpload(Message: "Updated", subtitle: "")
                SwiftLoader.hide()
                
                
            }
        }
    }
    
    
    
    func updateReportStyle(pdfStyle:String, ref:String){
        //status is either: "active" or "not active"
       
        //This goes to: siteList node
        
        SwiftLoader.show(title: "Updating", animated: true)
        let reftest = Database.database().reference(withPath:"\(ref)")
        
        
        reftest.updateChildValues([
            "pdfStyle": pdfStyle,
        ]){
            (error:Error?, ref:DatabaseReference) in
            if let error = error {
                print("Data could not be saved: \(error).")
                
                SwiftLoader.hide()
                self.mainFunction.errorUpload(errorMessage: "Data could not be saved",subtitle: "\(error)")
                
                
                
            } else {
                
                print("Data saved successfully!")
                
                self.mainFunction.successUpload(Message: "Updated", subtitle: "")
                SwiftLoader.hide()
                
                
            }
        }
    }
    
    
    
    
    func updateObservationStatus(status:String, ref:String){
        //status is either: "active" or "not active"
       
        //This goes to: siteList node
        
        SwiftLoader.show(title: "Updating", animated: true)
        let reftest = Database.database().reference(withPath:"\(ref)")
        
        
        reftest.updateChildValues([
            "status": status,
        ]){
            (error:Error?, ref:DatabaseReference) in
            if let error = error {
                print("Data could not be saved: \(error).")
                
                SwiftLoader.hide()
                self.mainFunction.errorUpload(errorMessage: "Data could not be saved",subtitle: "\(error)")
                
                
                
            } else {
                
                print("Data saved successfully!")
                
                self.mainFunction.successUpload(Message: "Updated", subtitle: "")
                SwiftLoader.hide()
                
                
            }
        }
    }
    
    
    
    func uploadSiteImageViaMap(imageData:Data, auditID:String){

        //activity indicator
        SwiftLoader.show(title: "Uploading Image (1/2)", animated: true)

        // Saving the image data into Storage - not real time database.
        // This link is for the storage directory

        let uuid = UUID().uuidString
        let uid = Auth.auth().currentUser?.uid


        let Ref = storageReference
            .child("\(self.mainConsole.prod!)")
            .child("\(self.mainConsole.post!)")
            .child("\(uid!)")
            .child("\(self.mainConsole.audit!)")
            .child("\(auditID)")
            .child("\(self.mainConsole.auditSiteData!)")
            .child("\(uuid)")
            .child("snapshot.jpg")




        let uploadMetaData = StorageMetadata()
        uploadMetaData.contentType = "image/jpeg"

        //Save image in the refecence directory above
        Ref.putData(imageData as Data, metadata: uploadMetaData) { (uploadedImageMeta, error) in

            if error != nil
            {
                SwiftLoader.hide()
                //Could not upload data
                //self.extensConsole.errorUpload(errorMessage: "Could no upload picture",subtitle: "\(String(describing: error?.localizedDescription))")
                return

            } else {

                SwiftLoader.hide()
                Ref.downloadURL { [self] url, error in
                    if error != nil {
                        // Handle any errors
                    }else{

                        //Not only are we saving the image url string, but all of the contents that relate to user details - hence calling the processdata function.
                        //processdata(imageURL: "\(url!)", uuid: uuid)

                    }
                }
            }

        }

    }
    

    
    
}
