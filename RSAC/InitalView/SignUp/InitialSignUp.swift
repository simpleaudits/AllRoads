//
//  Signup.swift
//  dbtestswift
//
//  Created by macbook on 21/10/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit
import Firebase
import SwiftLoader

class InitialSignUp: UITableViewController,UITextFieldDelegate,UITextViewDelegate {
    

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var createAccount: UIButton!
    
    //create object type from the local extension
    let localExtensionFile = extens()
    
    
    
    
    @IBAction func createaccount(_ sender: Any) {
        
        SwiftLoader.show(animated: true)
        
        Auth.auth().createUser(withEmail: username.text!, password: password.text!) { user, error in
            if error == nil {
            Auth.auth().signIn(withEmail: self.username.text!,
                                   password: self.password.text!)
           
                //---Alert to let user know they have created an account.
                self.SuccessfulLogin()
                self.localExtensionFile.localAlert(message: "Account Created", submessage: "")
                
            }else{
                // failed to create account
                self.localExtensionFile.localAlert(message: "\(error!)", submessage: "unable to create account at this time")

            }
            SwiftLoader.hide()
        }
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //---initial textview delagate
        self.username.delegate = self
        self.password.delegate = self
        
        //---textfiled corner bounds
         username.layer.cornerRadius = username.frame.height/2
         username.layer.masksToBounds = true
         username.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
         username.layer.borderWidth = 1.0;
         
         password.layer.cornerRadius = password.frame.height/2
         password.layer.masksToBounds = true
         password.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
         password.layer.borderWidth = 1.0;
    
        
        createAccount.layer.cornerRadius = createAccount.frame.height/2
        createAccount.layer.masksToBounds = true
        
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {


    }
    
    
    func SuccessfulLogin(){
        
        SwiftLoader.hide()
        
        
        let alertController = UIAlertController(title: "Account created", message: "... let's update some details.", preferredStyle: .alert)
        let action = UIAlertAction(title: "Update",style: .default) { (action:UIAlertAction!) in
            // Perform action
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "updateDetails")
            self.present(controller, animated: true, completion: nil)
            
        }
   
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        password.resignFirstResponder()
        username.resignFirstResponder()
   
        return true
    }
 

}
