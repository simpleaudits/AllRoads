//
//  createAudit.swift
//  RoadSafetyAuditCloud
//
//  Created by John on 15/10/2023.
//

import UIKit
import SwiftLoader
import Firebase

class createSite: UITableViewController,UINavigationControllerDelegate, UITextFieldDelegate,UITextViewDelegate, locationDecriptionString {

    
    
    @IBOutlet weak var siteName: UITextField!
    @IBOutlet weak var timeDate: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    
    var lat = CGFloat()
    var long = CGFloat()
    
    var auditID = String()
    
    
    let mainConsole = CONSOLE()
    
    let a = extens()

    
    
    func finishPassing_location(saveLocation: String, lat: CGFloat, long: CGFloat){
        //Display audit stage cell when the string is not empty.
        if (self.locationLabel.text != ""){
            print ("not empty")
            self.locationLabel.text = saveLocation
            self.lat = lat
            self.long = long
        }else{
            print ("empty")
        }
    }
    
  
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 3{
            
            if indexPath.row == 0{
                
                performSegue(withIdentifier: "showStage", sender: self)
         
            }else{
            }
            
        }else if indexPath.section == 4
        {
            
            if indexPath.row == 0{
                
                performSegue(withIdentifier: "showScope", sender: self)
          
            }else{
            }
            
            
        }else if indexPath.section == 2
        {
            
            if indexPath.row == 0{
                
                performSegue(withIdentifier: "location", sender: self)

                
                
            }else{
            }
            
            
        }
    }
    
    

    override func viewDidLoad() {
        
       
        timeDate.text = a.timeStamp()
    
        
        super.viewDidLoad()

        siteName.delegate? = self

        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
    }

    // MARK: - Table view data source



    @IBAction func createAudit(_ sender: UIBarButtonItem) {
    
            //show progress view
            SwiftLoader.show(title: "Creating Site", animated: true)


            
            
            if  siteName.text!.count > 0 &&
                locationLabel.text!.count > 0 {
                
                let uid = Auth.auth().currentUser?.uid
                let uuid = UUID().uuidString
                
                let saveData = addSite(
                    addSite: siteName.text!,
                    date: timeDate.text!,
                    lat: self.lat,
                    long: self.long,
                    completed: true)
    
                let reftest = Database.database().reference().child("\(self.mainConsole.prod!)")
                let thisUsersGamesRef = reftest
                    .child("\(self.mainConsole.post!)")
                    .child(uid!)
                    .child("\(self.mainConsole.audit!)")
                    .child("\(auditID)")
                    .child("\(self.mainConsole.siteList!)")
                    .child("\(uuid)")

             
                //print(thisUsersGamesRef)
                
                thisUsersGamesRef.setValue(saveData.addSiteData()){
                    (error:Error?, ref:DatabaseReference) in
                    

                    if let error = error {
                        print("Data could not be saved: \(error).")
                        self.errorUpload(errorMessage: "Data could not be saved",subtitle: "\(error)")
                        SwiftLoader.hide()
                        
                    } else {
                        print("saved")
                        SwiftLoader.hide()
 
                        self.successUpload(Message: "New Site Added!", subtitle: "")
                    }
                      
                }
    
            }
            else{
                SwiftLoader.hide()
                self.errorUpload(errorMessage:"Some fields are empty.",subtitle:"Nearly there!")
                
            }
            
    
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if let destination3 = segue.destination as? locationView {
            destination3.delegate = self
           
            
        }
        
    
        else {
            
        }
   
            
            
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
        
      

        
        let Alert = UIAlertController(title: "\(errorMessage)", message: "\(subtitle)", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "OK",style: .default) { (action:UIAlertAction!) in
            
            
        }
        
        
        Alert.addAction(action1)
        self.present(Alert, animated: true, completion: nil)
        
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

    

    
    }
    
