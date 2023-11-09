//
//  extensionFiles.swift
//  waiter+
//
//  Created by John on 6/9/2023.
//

import Foundation
import UIKit



class extens: UIViewController {
    //this function is fetching the json from URL
    func timeStamp() -> String{
        //creating a NSURL
        
        
        let date = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        print(dateFormatter.string(from: date as Date))
        let dateNow = date.timeIntervalSince1970
        let UNIXInt = Int(dateNow)
        print("Unix Date" + "\(UNIXInt)")
        
        
        return String(dateFormatter.string(from: date as Date))
    }
    
    func auditID() -> String{
        //creating a NSURL
        let uuid = UUID().uuidString

        
        return String(uuid)
    }
    
    
    
  
    func localAlert(message:String,submessage:String){
        
        let alertController = UIAlertController(title: message, message: submessage, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK",style: .default) { (action:UIAlertAction!) in
            // Perform action

        }
        let cancel = UIAlertAction(title: "Cancel",style: .cancel) { (action:UIAlertAction!) in
            // Perform action

        }
        alertController.addAction(action)
        alertController.addAction(cancel)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func successUpload(Message:String,subtitle:String){
        
        // we want to close any activity loading


        
        let Alert = UIAlertController(title: Message, message: subtitle, preferredStyle: .alert)
        let action1 = UIAlertAction(title: "OK",style: .default) { (action:UIAlertAction!) in
            
       
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "mainView")
            self.present(controller, animated: true, completion: nil)
            
     
        }
        
        
        Alert.addAction(action1)
        self.present(Alert, animated: true, completion: nil)
        
    }
    
    func errorUpload(errorMessage:String,subtitle:String){
        
        // we want to close any activity loading
        //IHProgressHUD.dismiss()
        

        
        let Alert = UIAlertController(title: "\(errorMessage)", message: "\(subtitle)", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "OK",style: .default) { (action:UIAlertAction!) in
            
            
        }
        
        
        Alert.addAction(action1)
        self.present(Alert, animated: true, completion: nil)
        
    }
    
    
    
}


class CONSOLE: UIViewController {
    var prod:String? = "prod"
    var post:String? = "post"  // "\(ParentJSON.Parent!)"
    var audit:String? = "audit" // "\(ParentJSON.Parent_child!)"
    var auditList:String? = "auditList" // "\(ParentJSON.Parent_child!)"
    var userDetails:String? = "userDetails" // "\(ParentJSON.User_Details!)"
    var profileImage: String? = "profileImage"
    var listingImage: String? = "listingImage"
    var auditProductList:String? = "auditProductList" // "\(ParentJSON.ProductList!)"
    
 
    
    var complete: String? = "Completed Audits"
    var progress: String? = "In-Progress Audits"
    var archived: String? = "Archived"
    
}
