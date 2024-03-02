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

class createSite: UITableViewController,UINavigationControllerDelegate, UITextFieldDelegate,UITextViewDelegate, locationDecriptionString {

    
    
    @IBOutlet weak var siteName: UITextField!
    @IBOutlet weak var timeDate: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    
    var lat = CGFloat()
    var long = CGFloat()
    
    var auditID = String()
    var siteID = String()
    var refData = String()
  
    
    

    let extensConsole = extens()
    let firebaseConsole = saveLocal()
    
    //storage for image
    let storageReference = Storage.storage().reference()
    let options: MKMapSnapshotter.Options = .init()
    var localImageData = Data()
  
    
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
                SwiftLoader.show(title: "Creating Site", animated: true)

                if  siteName.text!.count > 0 &&
                    locationLabel.text!.count > 0 {
                    
                    let uid = Auth.auth().currentUser?.uid
                    siteID = UUID().uuidString
                    
                    let reftest = Database.database().reference().child("\(self.mainConsole.prod!)")
                    let thisUsersGamesRef = reftest
                        .child("\(self.mainConsole.post!)")
                        .child(uid!)
                        .child("\(self.mainConsole.audit!)")
                        .child("\(auditID)")
                        .child("\(self.mainConsole.siteList!)")
                        .child("\(siteID)")
                    
                    refData = "\(self.mainConsole.prod!)/\(self.mainConsole.post!)/\(uid!)/\(self.mainConsole.audit!)/\(auditID)/\(self.mainConsole.siteList!)/\(siteID)"

                    let saveData = createSiteData(
                        locationImageURL: imageURL,
                        siteName: siteName.text!,
                        date: timeDate.text!,
                        lat: self.lat,
                        long: self.long,
                        ref: "\(refData)",
                        siteID: "\(siteID)",
                        status: "In-Progress Audits",
                        observationCount:"0",
                        completed: true)
        
                    thisUsersGamesRef.setValue(saveData.saveSiteData()){
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
            .child("\(auditID)")
            .child("\(self.mainConsole.siteList!)")
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

        
        
    }

    // MARK: - Table view data source



    @IBAction func createAudit(_ sender: UIBarButtonItem) {
            
        createImageFromMap(lat: self.lat, long: self.long)
        
    }
    
   
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if let destination3 = segue.destination as? locationView {
            destination3.delegate = self
           
        }else if let destination4 = segue.destination as? addAuditSites {
            destination4.siteID = siteID
            destination4.auditID = auditID
          
        }else if let destination4 = segue.destination as? viewSiteSnaps {
            destination4.siteID = siteID
            destination4.auditID = auditID
            destination4.refData = refData
          
        }
        else if let destination4 = segue.destination as? Observation {
            destination4.siteID = siteID
            destination4.auditID = auditID
            destination4.refData = refData
          
        }
        
    
        else {
            
        }
   
            
            
        }
    
    func successUpload(Message:String,subtitle:String){
        
        // we want to close any activity loading


        
        let Alert = UIAlertController(title: Message, message: subtitle, preferredStyle: .alert)
        let action1 = UIAlertAction(title: "Start Audit",style: .default) { (action:UIAlertAction!) in
            
            self.performSegue(withIdentifier: "startAudit", sender: self)
            
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let controller = storyboard.instantiateViewController(withIdentifier: "mainView")
//            self.present(controller, animated: true, completion: nil)
            
     
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
    
