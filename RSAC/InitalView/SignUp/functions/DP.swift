//
//  DP.swift
//  dbtestswift
//
//  Created by John on 20/3/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import Foundation
import UIKit
import SwiftLoader
import Firebase



extension SignUpController{
    
    
    @objc func chooseImage()
    {

        
        uploadImageAlert()
    }
    
    //alert view for image content
    func uploadImageAlert () {
        let alertController = UIAlertController(title: "Upload Image", message: "", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "Photo Library",style: .default) { (action:UIAlertAction!) in
            // Perform action
            
            //open camera
            self.picker.allowsEditing = true
            self.picker.sourceType = .photoLibrary
            self.present(self.picker, animated: true, completion: nil)
            
            
            
            //
        }
        let action2 = UIAlertAction(title: "Camera",style: .default) { (action:UIAlertAction!) in
            // Perform action
            self.picker.allowsEditing = true
            self.picker.sourceType = .camera
            self.picker.cameraCaptureMode = .photo
            self.present(self.picker, animated: true, completion: nil)
            
        
            
        }
        let action3 = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in
            print("Cancel button tapped");
        }
        alertController.addAction(action1)
        alertController.addAction(action2)
        alertController.addAction(action3)
        
        
        // change the background color
        
        self.present(alertController, animated: true, completion: nil)
        
        
    }
    
    
    
       func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
           // Local variable inserted by Swift 4.2 migrator.
           let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
   
   
           //We allow the user to pick an image, which they can edit.
           if let profileImage = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.editedImage)] as? UIImage,
   
                let optimizedImageData = profileImage.jpegData(compressionQuality: 0.1)// image quality.
                               {
                                   // assign user image to uiimageview
                                   //save the image as object
                                   DPData = optimizedImageData
                                   imageSelected = true//so the paceholder gets romoved.
                                   collectionView.reloadData()

   
                               }
   
                                picker.dismiss(animated: true, completion:nil)
   
                   }
   
       // Helper function inserted by Swift 4.2 migrator.
       fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
           return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
       }
   
       // Helper function inserted by Swift 4.2 migrator.
       fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
           return input.rawValue
       }
       func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
           dismiss(animated: true, completion: nil)
       }
    

    
    
    
    
    func uploadDP(imageData:Data){
        
        //activity indicator
        SwiftLoader.show(title: "Uploading Image (1/2)", animated: true)
        
        // Saving the image data into Storage - not real time database.
        // This link is for the storage directory
        
        
        let uuid = UUID().uuidString
        self.JaffleID = "JaffleID-\(uuid)"
        
        
        let QRRef = storageReference
            .child("\(self.mainConsole.prod!)")
            .child("\(self.mainConsole.post!)")
            .child(ThecurrentUser!.uid)
            //.child("\(self.mainConsole.audit!)")
            .child("\(mainConsole.userDetails!)")
            .child("\(mainConsole.profileImage!)")
            .child("\(ThecurrentUser!.uid)-\(mainConsole.profileImage!).jpg")
        

        
        let uploadMetaData = StorageMetadata()
        uploadMetaData.contentType = "image/jpeg"
        
        //Save image in the refecence directory above
        QRRef.putData(imageData as Data, metadata: uploadMetaData) { (uploadedImageMeta, error) in
            
            if error != nil
            {
                SwiftLoader.hide()
                //Could not upload data
                self.errorUpload(errorMessage: "Could no upload Company Picture",subtitle: "\(String(describing: error?.localizedDescription))")
                
                return
                
            } else {
                
                SwiftLoader.hide()
                QRRef.downloadURL { [self] url, error in
                    if error != nil {
                        // Handle any errors
                        DPsaved = false
                        
                    }else{
                        
                        //Not only are we saving the image url string, but all of the contents that relate to user details - hence calling the processdata function.
                        
                        DPDataURL = "\(url!)"
                        DPsaved = true
                        
                        
                        //3) DP/QR STORAGE SAVED and now report configuration data. Once the configuration data is saved successfully user data presets will be saved
                        // this is under the processdata() function.
                        self.reportConfiguration()
                       
                        
                        
                        
                    }
                }
            }
            
            
        }
    }
        
    
    
}
