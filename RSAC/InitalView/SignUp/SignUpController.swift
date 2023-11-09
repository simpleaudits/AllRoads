//
//  signUpController.swift
//  dbtestswift
//
//  Created by John on 10/3/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation

class SignUpController: UICollectionViewController,UITextFieldDelegate,UITextViewDelegate,UIPickerViewDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate,CLLocationManagerDelegate,UICollectionViewDelegateFlowLayout {
    
    
    let picker = UIImagePickerController()
    var QRImage = UIImage()

    let loginToList = "accountCreated"
    
    let usersRef = Database.database().reference(withPath: "online")
    
    let storageReference = Storage.storage().reference()
    var ThecurrentUser = Auth.auth().currentUser
    var user: User!
   
        
    //DataType Declare
    var JaffleID = String()
    var QRImageData = Data()
    var DPData = Data()
    
    var QRImageDataURL = String()
    var DPDataURL = String()

 
    let mainConsole = CONSOLE()
    let mainConsole2 = extens()

    
    
    var QRsaved = Bool()
    var DPsaved = Bool()
    var imageSelected: Bool = false
    var optionalHandler: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        //setup
        //create QR code on every instance based on the user UID.
       
        // placeholder the DP image
        
        
        
        // Register cell classes
        collectionView?.register(SignUpItemsCell.self, forCellWithReuseIdentifier: "user")
        
        
        self.collectionView?.dataSource = self
        self.collectionView?.delegate = self
        
        
        
        //declare picker
        picker.delegate = self
        

        
        
        
    }
    
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    
            return UIEdgeInsets(top: 20, left: 5, bottom: 0, right: 5)
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
            let frameSize = collectionView.frame.size
            return CGSize(width: frameSize.width, height: frameSize.height )
            //return CGSize(width:view.frame.width - padding * 2, height : screenSize.height)
        }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: "user", for: indexPath) as! SignUpItemsCell
    
        
        //DP file
        cell.DPButton.addTarget(self, action: #selector(chooseImage), for: .touchUpInside)
        //save
        cell.saveButton.addTarget(self, action: #selector(save), for: .touchUpInside)

        
      

        if imageSelected == true{
            cell.DP.image = UIImage(data: DPData)
        }else{
            let image = UIImage(named: "man")
            let data = image?.jpegData(compressionQuality: 0.9)
            DPData = data!
        }
  
        

        //When the user clicks return, keyboard dismisses.
        cell.Name.delegate = self
        cell.lastName.delegate = self
        cell.userName.delegate = self

 
          

        return cell
    }




    
     
    
    
    
    @objc func save()
    {
        //1) QR STORAGE SAVED next is DP DATA - search uploadDP(imageData: DPData)
        //uploadQRCode(imageData: QRImageData)
        uploadDP(imageData: DPData)
        
    }
    

    

    
    
    
    

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        // return NO to disallow editing.
        print("TextField should begin editing method called")
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        // became first responder
        print("TextField did begin editing method called")
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
        print("TextField should snd editing method called")
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
        print("TextField did end editing method called")
    }



    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // return NO to not change text
   
        print("While entering the characters this method gets called")
        
        
        
        
        
        return true
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        // called when clear button pressed. return NO to ignore (no notifications)
        print("TextField should clear method called")
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // called when 'return' key pressed. return NO to ignore.
        print("TextField should return method called")
        // may be useful:
        textField.resignFirstResponder()
        return true
    }

    
    
    func hideKeyboardWhenTappedAround() {
           let tapGesture = UITapGestureRecognizer(target: self,
                            action: #selector(hideKeyboard))
           view.addGestureRecognizer(tapGesture)
    }
    
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    
    
    
    
    }
