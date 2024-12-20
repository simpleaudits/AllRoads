//
//  createAudit.swift
//  RoadSafetyAuditCloud
//
//  Created by John on 15/10/2023.
//

import UIKit
import SwiftLoader
import Firebase
import MapKit

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
    let extensConsole = extens()
    
    
    

    let options: MKMapSnapshotter.Options = .init()
    var localImageData = Data()
    
    
    //storage for image
    let storageReference = Storage.storage().reference()
    
    
    func finishPassing_location(saveLocation: String, lat: CGFloat, long: CGFloat){
        //Display audit stage cell when the string is not empty.
        if (self.locationLabel.text != ""){
            print ("not empty")
            self.locationLabel.text = saveLocation
            self.lat = lat
            self.long = long
            
            print(lat)
            print(long)
            
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
        
       
        timeDate.text = extensConsole.timeStamp()
        auditID.text = "\(extensConsole.auditID())"
        
        
        super.viewDidLoad()

        projectName.delegate? = self
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
    }


    @IBAction func createAudit(_ sender: UIBarButtonItem) {
    
        
     // create audit here
        
        createImageFromMap(lat: self.lat, long: self.long)
    
        
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
    
    func createImageFromMap(lat:CGFloat, long:CGFloat){
         
        options.region = MKCoordinateRegion(
           center: CLLocationCoordinate2D(
                      latitude: lat,
                      longitude: long
                  
           ), span: MKCoordinateSpan(latitudeDelta: 0.000000001, longitudeDelta: 0.000000001)
           
        )
        options.mapType = .satellite
        options.showsBuildings = true
        
        let snapshotter = MKMapSnapshotter(
            options: options
        )
        snapshotter.start { snapshot, error in
           if let snapshot = snapshot {
            
               
               let data = snapshot.image.pngData()
               self.localImageData = data! as Data
               
               self.uploadSiteImageViaMap(imageData: self.localImageData)
               
         
           } else if let error = error {
              print("Something went wrong \(error.localizedDescription)")
           }
        }
        
        
 
    }
    
    
    func saveData(imageURL:String){
        //show progress view
        SwiftLoader.show(title: "Creating Audit", animated: true)


        if
            projectName.text!.count > 0 &&
            auditStage.text!.count > 0 &&
            scopeLabel.text!.count > 0 &&
            locationLabel.text!.count > 0 {
            
            let uid = Auth.auth().currentUser?.uid
            let saveData = newAuditDataset(
                locationImageURL: imageURL,
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
    
    
    func uploadSiteImageViaMap(imageData:Data){

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
            .child("\(auditID.text!)")
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
                self.extensConsole.errorUpload(errorMessage: "Could no upload picture",subtitle: "\(String(describing: error?.localizedDescription))")
                return

            } else {

                SwiftLoader.hide()
                Ref.downloadURL { [self] url, error in
                    if error != nil {
                        // Handle any errors
                    }else{

                        //save the data
                        saveData(imageURL: "\(url!)")

                    }
                }
            }

        }

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
    
