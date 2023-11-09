//
//  Alerts.swift
//  dbtestswift
//
//  Created by John on 20/3/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import Foundation
import UIKit
//import IHProgressHUD




extension SignUpController{

    
    
    
    func errorUpload(errorMessage:String,subtitle:String){
        
        // we want to close any activity loading
        //IHProgressHUD.dismiss()
        

        
        let Alert = UIAlertController(title: "\(errorMessage)", message: "\(subtitle)", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "OK",style: .default) { (action:UIAlertAction!) in
            
            
        }
        
        
        Alert.addAction(action1)
        self.present(Alert, animated: true, completion: nil)
        
    }
    
    func successUpload(Message:String,subtitle:String){
        
        // we want to close any activity loading
        //IHProgressHUD.dismiss()
        

        
        let Alert = UIAlertController(title: Message, message: subtitle, preferredStyle: .alert)
        let action1 = UIAlertAction(title: "OK",style: .default) { (action:UIAlertAction!) in
            
            

            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "mainView")
            self.present(controller, animated: true, completion: nil)
            
            
            
            
        }
        
        
        Alert.addAction(action1)
        self.present(Alert, animated: true, completion: nil)
        
    }
    
    func AlertCompletion () {
        let alertController = UIAlertController(title: "Welcome to Jaffle", message: "", preferredStyle: .alert)
   
           let action1 = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                 //print("Okay Selected");
   
                    // let storyboard = UIStoryboard(name: "MainView", bundle: nil)
                     let controller = self.storyboard!.instantiateViewController(withIdentifier: "MainView")
                     self.present(controller, animated: true, completion: nil)
   
                        if #available(iOS 13.0, *) {
                            controller.isModalInPresentation = false // available in IOS13
                        }
   
   
             }
             alertController.addAction(action1)
   
             self.present(alertController, animated: true, completion: nil)
   
   
         }
       
    
}
