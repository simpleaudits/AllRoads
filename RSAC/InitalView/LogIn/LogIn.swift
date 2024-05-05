//
//  ViewController.swift
//  dbtestswift
//
//  Created by macbook on 20/10/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit
import Firebase



class LogIn: UITableViewController,UITextFieldDelegate,UITextViewDelegate {
    

    
    //section where we add all the UI
    let loginToList = "mainView"
    var signin:NSInteger = 0
    
    

    
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    //let firstNameMessage        = NSLocalizedString("First name is required.", comment: "")
    //let lastNameMessage         = NSLocalizedString("Last name is required.", comment: "")
    let emailMessage            = NSLocalizedString("Email is required.", comment: "")
    let passwordMessage         = NSLocalizedString("Password is required.", comment: "")
    //let confirmPasswordMessage  = NSLocalizedString("Confirm password is required.", comment: "")
    //let mismatchPasswordMessage = NSLocalizedString("Password and Confirm password are not matching.", comment: "")
    
    
    
    @IBOutlet weak var LoginButtonImage: UIButton!
    
    @IBOutlet weak var SignupButtonImage: UIButton!
    
    
    
    
    override func viewDidLoad() {

    super.viewDidLoad()
        self.check()
      
        //---initial textview delagate
        
        self.username.delegate = self
        self.password.delegate = self
        
        
        navigationItem.prompt = "Version:\(getAppVersion() )"

        


        SignupButtonImage.layer.cornerRadius = SignupButtonImage.frame.height/2
        SignupButtonImage.layer.masksToBounds = true
        //SignupButtonImage.layer.borderColor = UIColor(red:237/255, green:83/255, blue:83/255, alpha: 1).cgColor
        //SignupButtonImage.layer.borderWidth = 1.0;
        
        LoginButtonImage.layer.cornerRadius = LoginButtonImage.frame.height/2
        LoginButtonImage.layer.masksToBounds = true
        //LoginButtonImage.layer.borderColor = UIColor(red:237/255, green:83/255, blue:83/255, alpha: 1).cgColor
        //LoginButtonImage.layer.borderWidth = 1.0;
 
   
        username.layer.cornerRadius = username.frame.height/2
        username.layer.masksToBounds = true
        username.layer.borderColor = UIColor(red:220/255, green:220/255, blue:220/255, alpha: 1).cgColor
        username.layer.borderWidth = 1.0;
        
        password.layer.cornerRadius = password.frame.height/2
        password.layer.masksToBounds = true
        password.layer.borderColor = UIColor(red:220/255, green:220/255, blue:220/255, alpha: 1).cgColor
        password.layer.borderWidth = 1.0;
 }
    
    func getAppVersion() -> String {

        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"]
        return appVersion as! String
        }
    
    func nextview(){
        performSegue(withIdentifier: loginToList, sender: self)

    }
  
    
    func check(){
        
        // Do any additional setup after loading the view, typically from a nib.
        //check if the user is logged in
        Auth.auth().addStateDidChangeListener() { auth, user in
            if user != nil {
  
                let alertController = UIAlertController(title: "Stay Signed in with:\(user!.email!) ?", message: "", preferredStyle: .alert)
                let action2 = UIAlertAction(title: "Stay Signed In",style: .default) { (action:UIAlertAction!) in
                    // Perform action
                 
                    self.username.text = nil
                    self.password.text = nil
                    
                    self .nextview()
                    
   
             
//
                }
                let action3 = UIAlertAction(title: "Sign Out",style: .default) { (action:UIAlertAction!) in
                    // Perform action
                    
                    let user = Auth.auth().currentUser!
                    let onlineRef = Database.database().reference(withPath: "online/\(user.uid)")
                    
          
                    onlineRef.removeValue { (error, _) in
                        if let error = error {
                            print("Removing online failed: \(error)")
                            return
                        }
                        do {
                            try Auth.auth().signOut()
                            self.dismiss(animated: true, completion: nil)
                        } catch (let error) {
                            print("Auth sign out failed: \(error)")
                        }
                    }
                    
                  
                }
                let action1 = UIAlertAction(title: "Sign Up", style: .cancel) { (action:UIAlertAction!) in
                    print("Cancel button tapped");
                    
                    self.performSegue(withIdentifier: "signUpSegue", sender: self)
                    
                }
                alertController.addAction(action1)
                alertController.addAction(action2)
                alertController.addAction(action3)
                
                

              
                
                self.present(alertController, animated: true, completion: nil)
                
       
        
            }else{
                
            }
        
    }
    }
 
    
    //############ THIS IS THE INSTANCE WHERE WE DECLARE USER LOG IN
    
    @IBAction func login(_ sender: AnyObject) {

        guard
    //we use guard to prevent any nil retun calls on sever side.
            
            let email = username.text,
            let password = password.text,
            email.count > 0,
            password.count > 0
         
            
            
            //Programmically switch to the news feed

                   
      
      
            else {
            return
        
                
       
    }

        
    //firebase authentication step.
    Auth.auth().signIn(withEmail: email, password: password) { user, error in
    if let error = error, user == nil {
    let alert = UIAlertController(title: "Sign In Failed",
    message: error.localizedDescription,
    preferredStyle: .alert)
    
    alert.addAction(UIAlertAction(title: "OK", style: .default))
    
    self.present(alert, animated: true, completion: nil)
    }
    }
}

    //############ THIS IS THE INSTANCE WHERE WE DECLARE USER LOG IN
    
    @IBAction func singup(_ sender: Any) {
        
        performSegue(withIdentifier: "signUpSegue", sender: self)
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        password.resignFirstResponder()
        username.resignFirstResponder()
        
        
         
        
        return true
    }
    
    
    
    
    
    
}

