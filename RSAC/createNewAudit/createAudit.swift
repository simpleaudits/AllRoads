//
//  createAudit.swift
//  RoadSafetyAuditCloud
//
//  Created by John on 15/10/2023.
//

import UIKit
import SwiftLoader
import Firebase

class createAudit: UITableViewController,UINavigationControllerDelegate, auditStage,scopeDecriptionString,locationDecriptionString , UITextFieldDelegate,UITextViewDelegate {

    
    
    @IBOutlet weak var projectName: UITextField!
    @IBOutlet weak var auditStage: UILabel!
    @IBOutlet weak var scopeLabel: UITextView!
    @IBOutlet weak var timeDate: UILabel!
    @IBOutlet weak var auditID: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    
    var lat = CGFloat()
    var long = CGFloat()
    
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
    
    func finishPassing_category(saveCategory: String) {
        //Display audit stage cell when the string is not empty.
        if (self.auditStage.text != ""){
            print ("not empty")
            self.auditStage.text = saveCategory
        }else{
            print ("empty")
        }
    }
    
    func finishPassing_decription(saveDescription: String) {
        
        if (self.scopeLabel.text != ""){
            print ("not empty")
            self.scopeLabel.text = saveDescription
            
            
        }else{
            print ("empty")
        }
        
        //---------------------------------------------------------------------------------------
        
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
        auditID.text = "\(a.auditID())"
        
        
        super.viewDidLoad()

        projectName.delegate? = self
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
    }


    @IBAction func createAudit(_ sender: UIBarButtonItem) {
    
            //show progress view
            SwiftLoader.show(title: "Creating Audit", animated: true)


            if  projectName.text!.count > 0 &&
                auditStage.text!.count > 0 &&
                scopeLabel.text!.count > 0 &&
                locationLabel.text!.count > 0 {
                
                let uid = Auth.auth().currentUser?.uid
                let saveData = newAuditDataset(
                    date: timeDate.text!,
                    auditID: "\(auditID.text!)",
                    projectName: projectName.text!,
                    location: locationLabel.text!,
                    projectStage: auditStage.text!,
                    auditCover: "",
                    lat: self.lat,
                    long: self.long,
                    auditProgress: "\(self.mainConsole.progress!)",
                    auditReference: "\(self.mainConsole.prod!)/\(self.mainConsole.post!)/\(uid!)/\(self.mainConsole.audit!)/\(auditID.text!)",
                    nestedNode: "",
                    completed: true)
    
                let reftest = Database.database().reference().child("\(self.mainConsole.prod!)")
                let thisUsersGamesRef = reftest.child("\(self.mainConsole.post!)").child(uid!).child("\(self.mainConsole.audit!)").child("\(auditID.text!)")
             
                //print(thisUsersGamesRef)
                
                thisUsersGamesRef.setValue(saveData.addAudit()){
                    (error:Error?, ref:DatabaseReference) in
                    

                    if let error = error {
                        print("Data could not be saved: \(error).")
                        self.errorUpload(errorMessage: "Data could not be saved",subtitle: "\(error)")
                        SwiftLoader.hide()
                        
                    } else {
                        print("saved")
                        SwiftLoader.hide()
 
                        self.successUpload(Message: "New Audit Created!", subtitle: "")
                    }
                      
                }
    
            }
            else{
                SwiftLoader.hide()
                self.errorUpload(errorMessage:"Some fields are empty.",subtitle:"Nearly there!")
                
            }
            
    
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? CategoryTableViewController {
            
            destination.delegate = self
            
        }else if let destination2 = segue.destination as? scopeDecription {
            
            destination2.delegate = self
            
            if self.scopeLabel.text != "" {
                
            destination2.descriptionFromParent = self.scopeLabel.text
                
            }else{
                //nothing
            }
            
            
        }else if let destination3 = segue.destination as? locationView {
            
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
    
