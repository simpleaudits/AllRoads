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
import PencilKit

//EXTENSION FOR UIIMAGE------------------------------------------
extension UIImage {
    func scalePreservingAspectRatio(targetSize: CGSize) -> UIImage {
        // Determine the scale factor that preserves aspect ratio
        let widthRatio = targetSize.width / size.width
        let heightRatio = targetSize.height / size.height
        
        let scaleFactor = min(widthRatio, heightRatio)
        
        // Compute the new image size that preserves aspect ratio
        let scaledImageSize = CGSize(
            width: size.width * scaleFactor,
            height: size.height * scaleFactor
        )

        // Draw and return the resized UIImage
        let renderer = UIGraphicsImageRenderer(
            size: scaledImageSize
        )

        let scaledImage = renderer.image { _ in
            self.draw(in: CGRect(
                origin: .zero,
                size: scaledImageSize
            ))
        }
        
        return scaledImage
    }
}

//EXTENSION FOR UIIMAGE------------------------------------------



class addAuditSites: UIViewController,UIImagePickerControllerDelegate,UITextViewDelegate, UINavigationControllerDelegate,CLLocationManagerDelegate,MKMapViewDelegate, siteDecriptionString, UIPencilInteractionDelegate{
 
    
    var scrollView = UIScrollView()
    var layoverView = UIView()
    var locationLabel = UILabel()
    
    //edit image:
    var image = UIImageView()

    var canvasView: PKCanvasView!
    var imgForMarkup: UIImage?
    var editImage = UIButton()
    var saveImage = UIButton()
    
    
    var backgroundImage = UIView()
    var descriptionTextfieldHeader = UILabel()
    var descriptionTextfield = UITextView()
    var editDescription = UIButton()
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
    
    let firebaseConsole = saveLocal()
    var listOfSitesData: [auditSiteData] = []
    
    var location = String()
    var locationManager = CLLocationManager()
    


    

    
    
    
    
    
    
    
    func finishPassing_decription_addSite(saveDescriptionData: String) {
       
            self.siteDescription = saveDescriptionData
            self.descriptionTextfield.text = saveDescriptionData
           
        

    }
  
    override func viewDidAppear(_ animated: Bool) {
        
        if let window = self.view.window, let toolPicker = PKToolPicker.shared(for: window) {
        toolPicker.setVisible(true, forFirstResponder: self.canvasView)
        toolPicker.addObserver(self.canvasView)

            

            
        }
        //presentModal()
        
        

    }
    override func viewDidLoad() {

        
        super.viewDidLoad()
        
 
       
        findlocation()
  
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        descriptionTextfield.delegate = self
        picker.delegate = self
        

        
        let topBarHeight = UIApplication.shared.statusBarFrame.size.height +
                    (self.navigationController?.navigationBar.frame.height ?? 0.0)
        image = UIImageView(frame: CGRect(x: 0, y: topBarHeight, width: view.frame.width, height: 400))
        image.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        //image.layer.borderColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        //image.layer.borderWidth = 2
        image.contentMode = .scaleAspectFit
        
        //initiliaze the canvas:
        self.canvasView = PKCanvasView.init(frame: self.image.frame)
        self.canvasView.isOpaque = false

        
        layoverView = UIView(frame: CGRect(x: 0, y: topBarHeight, width: view.frame.width, height: 397))
        layoverView.layer.borderColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        layoverView.layer.borderWidth = 2
        layoverView.isHidden = true
       
        
        
        let tabBarHeight = tabBarController?.tabBar.frame.size.height
        descriptionTextfield = UITextView(frame: CGRect(x: 5, y: image.frame.maxY , width: view.frame.width - 10, height: view.frame.height - (image.frame.maxY + tabBarHeight!)))
        descriptionTextfield.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        descriptionTextfield.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)
        descriptionTextfield.font = UIFont.boldSystemFont(ofSize: 20)
        descriptionTextfield.text = ""
        descriptionTextfield.layer.cornerRadius = 10
        descriptionTextfield.layer.masksToBounds = true
        descriptionTextfield.isUserInteractionEnabled = false
        descriptionTextfield.delegate = self
    
        
        //Buttons:
        editImage = UIButton(frame: CGRect(x: 10, y:  descriptionTextfield.frame.minY - 50 - 10, width: 150, height: 40))
        editImage.setTitleColor(UIColor.white, for: .normal)
        editImage.setTitle("Edit Image", for: .normal)
        //editImage.setImage(UIImage(systemName: "pencil"), for: .normal)
        editImage.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        editImage.layer.cornerRadius = 15
        editImage.layer.masksToBounds = true
        editImage.addTarget(self, action: #selector(editImageButton(_:)), for: .touchUpInside)
        
        
        saveImage = UIButton(frame: CGRect(x: editImage.frame.maxX + 10, y:  descriptionTextfield.frame.minY - 50 - 10, width: 150, height: 40))
        saveImage.setTitleColor(UIColor.white, for: .normal)
        saveImage.setTitle("Save Edits", for: .normal)
        //editImage.setImage(UIImage(systemName: "pencil"), for: .normal)
        saveImage.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        saveImage.layer.cornerRadius = 15
        saveImage.layer.masksToBounds = true
        saveImage.addTarget(self, action: #selector(saveDrawing(_:)), for: .touchUpInside)


        
        self.view.addSubview(image)
        self.view.addSubview(descriptionTextfield)
        self.view.addSubview(layoverView)
        self.view.addSubview(self.canvasView)
        self.view.addSubview(editImage)
        self.view.addSubview(saveImage)
        
        
        //Ask user for site name:
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Site Name:", message: "", preferredStyle: .alert)

        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.text = ""

        }

        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "Add Photo", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            self.navigationItem.title = textField!.text
            self.siteName = textField!.text!
            self.navigationItem.title = textField!.text!

            if textField!.text! == ""{

                let Alert = UIAlertController(title: "Whoops!⚠️", message: "Site name was empty", preferredStyle: .alert)
                    let action1 = UIAlertAction(title: "Okay",style: .cancel) { (action:UIAlertAction!) in
                        self.navigationController?.popViewController(animated: true)

                    }

                Alert.addAction(action1)
                self.present(Alert, animated: true, completion: nil)

                }else{

                    self.selectImageType()

                }


        }))

        let action1 = UIAlertAction(title: "Back",style: .cancel) { (action:UIAlertAction!) in

            self.navigationController?.popViewController(animated: true)
        }

        alert.addAction(action1)
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)

    }
    
    @objc func  onClear(_ sender : UIButton) {
        canvasView.drawing = PKDrawing()
    }
    
    @objc func saveDrawing(_ sender : UIButton){
        var drawing = self.canvasView.drawing.image(from: self.canvasView.bounds, scale: 0)
        if let markedupImage = self.saveImage(drawing: drawing){
            // Save the image or do whatever with the Marked up Image
            
            let data = markedupImage.pngData()
            self.localImageData = data! as Data
  

    }
    
        
}
    
    @objc func editImageButton(_ sender: UIButton) {
        
        self.canvasView.drawingPolicy = .anyInput
        self.canvasView?.drawing = PKDrawing()
        self.canvasView.becomeFirstResponder()
        print("Edit Image button pressed")
    
        self.layoverView.isHidden = false

        
    }
    

    func saveImage(drawing : UIImage) -> UIImage? {
    let bottomImage = image.image
    let newImage = autoreleasepool { () -> UIImage in
    UIGraphicsBeginImageContextWithOptions(self.canvasView!.frame.size, false, 0.0)
    bottomImage!.draw(in: CGRect(origin: CGPoint.zero, size: self.canvasView!.frame.size))
    drawing.draw(in: CGRect(origin: CGPoint.zero, size: self.canvasView!.frame.size))
    let createdImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
        return createdImage!
    }
        return newImage
    }
    
    
    func presentModal() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let viewController = storyboard.instantiateViewController(withIdentifier: "addSiteDetails") as? addSiteDetails{

            if let presentationController = viewController.presentationController as? UISheetPresentationController {
                presentationController.detents = [.medium(), .large()] /// change to [.medium(), .large()] for a half *and* full screen sheet
                presentationController.prefersGrabberVisible = true
                presentationController.preferredCornerRadius = 45
                presentationController.largestUndimmedDetentIdentifier = .medium
            }

           self.present(viewController, animated: true)
        }

       //self.performSegue(withIdentifier: "addDescription", sender: self)


    }
    
    @objc func editDescriptionButton(sender: UIButton!) {
        self.performSegue(withIdentifier: "addDescription", sender: self)

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
            
            
            
            
            //self.localImageData = imageData! as Data
            image.image = UIImage(data: jpegData)
            
            //Update the the collectionview here.
            
 
            
        }
        
        picker.dismiss(animated: true, completion:nil)
       // presentModal()
        

        
        
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
        let uid = Auth.auth().currentUser?.uid
        
        
        let Ref = storageReference
            .child("\(self.mainConsole.prod!)")
            .child("\(self.mainConsole.post!)")
            .child("\(uid!)")
            .child("\(self.mainConsole.audit!)")
            .child("\(auditID)")
            .child("\(self.mainConsole.auditList!)")
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
                self.extensConsole.errorUpload(errorMessage: "Could not upload data",subtitle: "\(String(describing: error?.localizedDescription))")
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
            auditID: auditID,
            imageURL: imageURL,
            auditDescription:"\(siteDescription)",
            date: "\(extensConsole.timeStamp())",
            lat: self.lat,
            long: self.long,
            ref: "\(refData)",
            observationID: "\(uuid)",
            siteID:"\(siteID)",
            status: "true")
        
         
    
            
            thisUsersGamesRef.setValue(saveData.saveAuditData()){
                (error:Error?, ref:DatabaseReference) in
                

                if let error = error {
                    print("Data could not be saved: \(error).")
                    self.extensConsole.errorUpload(errorMessage: "Data could not be saved",subtitle: "\(error)")
                    SwiftLoader.hide()
                    
                } else {
                   
                    print("saved data entry")
                   
                    
                    self.navigationController!.popViewController(animated: true)
                    //self.performSegue(withIdentifier: "viewAuditSnaps", sender: self)
                    
                    //1 load the obsevation count
                    self.observationSnapshotCount(auditID: self.auditID, siteID: self.siteID)
                    //2 save the key
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                        self.firebaseConsole.updateObservationCount(count: "\(self.listOfSitesData.count)", auditID: self.auditID, siteID: self.siteID)
                        
                        print("updated and saved observation")
                        SwiftLoader.hide()
                        
                    })
           
                }
                  
            }

   
  
        }
    
    
    func observationSnapshotCount(auditID: String, siteID : String){
    
        let uid = Auth.auth().currentUser?.uid
            //we want to get the database reference
            let reftest = Database.database().reference()
                .child("\(self.mainConsole.prod!)")
            let auditData = reftest
                .child("\(self.mainConsole.post!)")
                .child(uid!)
                .child("\(self.mainConsole.audit!)")
                .child("\(auditID)")
                .child("\(self.mainConsole.siteList!)")
                .child("\(siteID)")
                .child("\(self.mainConsole.auditList!)")
        
        print("obscount:\(auditData)")
        
        auditData.queryOrderedByKey()
            .observeSingleEvent(of: .value, with: { snapshot in
                    var listOfSitesData: [auditSiteData] = []
                    for child in snapshot.children {
                        if let snapshot = child as? DataSnapshot,
                            let listOfSites = auditSiteData(snapshot: snapshot) {
                            listOfSitesData.append(listOfSites)
                        }
                    }
                
                
                    self.listOfSitesData = listOfSitesData
                    print("obscount:\(self.listOfSitesData.count)")
                    SwiftLoader.hide()

               
                })

   

        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if let destination3 = segue.destination as? addDescription {
            destination3.delegate = self
           
        }
        
    
        else {
            
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
