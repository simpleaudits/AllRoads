//
//  addAudit.swift
//  RoadSafetyAuditCloud
//
//  Created by John on 24/10/2023.
//

import UIKit
import Firebase
import SDWebImage
import SwiftLoader
import MapKit

class addAuditSites: UIViewController,UIImagePickerControllerDelegate,UITextViewDelegate, UINavigationControllerDelegate,CLLocationManagerDelegate,MKMapViewDelegate, siteDecriptionString {
    var scrollView = UIScrollView()
    var layoverView = UIView()
    var locationLabel = UILabel()
    var image = UIImageView()
    var descriptionTextfieldHeader = UILabel()
    var descriptionTextfield = UITextView()
    var commentButton = UIButton()
    var cameraButton = UIButton()
    let picker = UIImagePickerController()
    var imageArrayURL = [String]()
    
    var auditID = String()
    var siteID = String()
    var siteName = String()
    var siteDescription = String()
    
    let mainConsole = CONSOLE()
    let extensConsole = extens()
    
    var localImageData = Data()
    
    var lat = CGFloat()
    var long = CGFloat()
    

    var imageCount = Int()
    
    let storageReference = Storage.storage().reference()
    
    
    var location = String()
    var locationManager = CLLocationManager()
    
    
    
    func finishPassing_decription(saveDescription: String) {
        
        if (siteDescription != ""){
            print ("not empty")
            self.siteDescription = saveDescription
            
            
        }else{
            print ("empty")
        }
        
        //---------------------------------------------------------------------------------------
        
    }
    
    
    override func viewDidLoad() {

        
        super.viewDidLoad()
        findlocation()
        

        
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        descriptionTextfield.delegate = self
        picker.delegate = self
        

        image = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height - (tabBarController?.tabBar.frame.size.height)! - 100))
        image.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        image.contentMode = .scaleAspectFill
  

        self.view.addSubview(image)

    
        layoverView = UIView(frame: CGRect(x: 15, y: view.frame.height , width: view.frame.width - 30, height: 80))
        layoverView.layer.borderWidth = 1
        layoverView.layer.cornerRadius = 30
        descriptionTextfield.layer.masksToBounds = true

      

        //create but buy now and enter button
        commentButton = UIButton(frame: CGRect(x: -1, y: 0, width: layoverView.frame.width/2, height: 80))
        commentButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        commentButton.setTitle("Add Comments", for: .normal)
        commentButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        commentButton.setTitleColor(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), for: .normal)
        commentButton.addTarget(self, action: #selector(addComment), for: .touchUpInside)


        cameraButton = UIButton(frame: CGRect(x: layoverView.frame.width/2 + 1, y: 0, width: layoverView.frame.width/2, height: 80))
        cameraButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        cameraButton.setTitle("Take Photo", for: .normal)
        cameraButton.setTitleColor(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), for: .normal)
        cameraButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        cameraButton.addTarget(self, action: #selector(openCamera), for: .touchUpInside)
        self.view.addSubview(layoverView)
        layoverView.addSubview(cameraButton)
        layoverView.addSubview(commentButton)
        
        
        UIView.animate(withDuration: 1, animations: {
            self.layoverView.frame.origin.y = self.view.frame.height - 80 - (self.tabBarController?.tabBar.frame.size.height)!

        }, completion: nil)
        
        
        
        
        //Ask user for site name:
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Site name:", message: "", preferredStyle: .alert)

        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.text = ""
            
        }

        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            self.navigationItem.title = textField!.text
            self.siteName = textField!.text!
        }))
        
        let action1 = UIAlertAction(title: "Back",style: .cancel) { (action:UIAlertAction!) in
                  
            self.navigationController?.popViewController(animated: true)
        }
        
        alert.addAction(action1)
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)

    }
    
    func presentModal() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "addDescription")

        if let presentationController = viewController.presentationController as? UISheetPresentationController {
            presentationController.detents = [.medium(), .large()] /// change to [.medium(), .large()] for a half *and* full screen sheet
        }

        self.present(viewController, animated: true)

    }
    
    @objc func addComment(sender: UIButton!) {
        presentModal()

    }
    
    @objc func openCamera(_ sender: UIButton) {
       // do your stuff here
      print("you clicked on button \(sender.tag)")
        selectImageType()

    }



    @IBAction func addToAuditList(_ sender: Any) {
        self.uploadDP(imageData: localImageData)
        
    }
    
    //###############-UPLOAD IMAGE-###############U
        func selectImageType() {
            let alertController = UIAlertController(title: "Upload Image", message: "", preferredStyle: .alert)
            let action2 = UIAlertAction(title: "Photo Library",style: .default) { (action:UIAlertAction!) in
                // Perform action
                //OPEN LIBRARY
                self.picker.allowsEditing = true
                self.picker.sourceType = .photoLibrary
                self.present(self.picker, animated: true, completion: nil)
            }
            let action3 = UIAlertAction(title: "Camera",style: .default) { (action:UIAlertAction!) in
                // OPEN CAMERA
                self.picker.allowsEditing = true
                self.picker.sourceType = .camera
                self.picker.cameraCaptureMode = .photo
                self.present(self.picker, animated: true, completion: nil)
            }
            let action1 = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in
                print("Cancel button tapped");
            }
            alertController.addAction(action1)
            alertController.addAction(action2)
            alertController.addAction(action3)
            
            
            // change the background color

    
            self.present(alertController, animated: true, completion: nil)
            
        }
        
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
  
        
        
        guard let editedImage = info[.editedImage] as? UIImage else { return }
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        if let jpegData = editedImage.jpegData(compressionQuality: 0.5){
            try? jpegData.write(to: imagePath)
            

            
            //We want to save the image URL string and then loop later to save in firebase.
            
        
            
            let imageURLtoNSData = NSURL(string: "\(imagePath)")
            let imageData = NSData (contentsOf: imageURLtoNSData! as URL)
            self.localImageData = imageData! as Data
            image.image = UIImage(data: localImageData)
            
            //Update the the collectionview here.
            
 
            
        }
        
        picker.dismiss(animated: true, completion:nil)
        

        
        
    }
    
 

    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
  
    
    func uploadDP(imageData:Data){
        
        //activity indicator
        SwiftLoader.show(title: "Uploading Image (1/2)", animated: true)
        
        // Saving the image data into Storage - not real time database.
        // This link is for the storage directory
        
        
        let uuid = UUID().uuidString
        print("test:\(uuid)")
        let uid = Auth.auth().currentUser?.uid
        
        
        let Ref = storageReference
            .child("\(self.mainConsole.prod!)")
            .child("\(self.mainConsole.post!)")
            .child("\(uid!)")
            .child("\(self.mainConsole.audit!)")
            .child("\(auditID)")
            .child("\(self.mainConsole.siteList!)")
            .child("\(siteID)")
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
                        
                        //Not only are we saving the image url string, but all of the contents that relate to user details - hence calling the processdata function.
                        processdata(imageURL: "\(url!)", uuid: uuid)
                        
                    }
                }
            }
            
        }

    }
        
    
    func processdata(imageURL:String, uuid:String){
        
        //show progress view
        SwiftLoader.show(title: "Creating Audit", animated: true)
    

            
            let uid = Auth.auth().currentUser?.uid
    

            let reftest = Database.database().reference()
                .child("\(self.mainConsole.prod!)")
        
        
            let thisUsersGamesRef = reftest
            .child("\(self.mainConsole.post!)")
            .child("\(uid!)")
            .child("\(self.mainConsole.audit!)")
            .child("\(auditID)")
            .child("\(self.mainConsole.siteList!)")
            .child("\(siteID)")
            .child("\(self.mainConsole.auditList!)")
            .child("\(uuid)")
       
            let refData = "\(self.mainConsole.prod!)/\(self.mainConsole.post!)/\(uid!)/\(self.mainConsole.audit!)/\(auditID)/\(self.mainConsole.siteList!)/\(siteID)/\(self.mainConsole.auditList!)/\(uuid)"


            let saveData = auditSiteData(
            auditTitle:"\(siteName)",
            auditReference: auditID,
            imageURL: imageURL,
            auditDescription:"\(siteDescription)",
            date: "\(extensConsole.timeStamp())",
            lat: self.lat,
            long: self.long,
            ref: "\(refData)",
            completed: true)
        
         
    
            
            thisUsersGamesRef.setValue(saveData.saveAuditData()){
                (error:Error?, ref:DatabaseReference) in
                

                if let error = error {
                    print("Data could not be saved: \(error).")
                    self.extensConsole.errorUpload(errorMessage: "Data could not be saved",subtitle: "\(error)")
                    SwiftLoader.hide()
                    
                } else {
                    print("saved")
                    SwiftLoader.hide()
                    self.navigationController!.popViewController(animated: true)
                    //self.performSegue(withIdentifier: "viewAuditSnaps", sender: self)

                }
                  
            }

   
  
        }



    func textFieldDidBeginEditing(productPrice textField: UITextField) {
        //print("TextField did begin editing method called")

    }

    func textViewDidEndEditing(_ textField: UITextView) {
        //print("TextField did end editing method called")
    }

    func textViewShouldBeginEditing(_ textField: UITextView) -> Bool {
        //print("TextField should begin editing method called")
        return true;
    }

    func textFieldShouldClear(_ textField: UITextView) -> Bool {
        //print("TextField should clear method called")
        return true;
    }

    func textViewDidChangeSelection(_ textField: UITextView) {

    }

    func textField(_ textField: UITextView, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //print("While entering the characters this method gets called")
        return true;
    }

    func textFieldShouldReturn(_ textField: UITextView) -> Bool {
        //print("TextField should return method called")
        textField.resignFirstResponder();
        return true;
    }

}
