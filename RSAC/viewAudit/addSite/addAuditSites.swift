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





extension UITextView {
    func setTextWithTypeAnimation(typedText: String, characterDelay: TimeInterval = 5.0) {
        text = ""
        var writingTask: DispatchWorkItem?
        writingTask = DispatchWorkItem { [weak weakSelf = self] in
            for character in typedText {
                DispatchQueue.main.async {
                    weakSelf?.text!.append(character)
                }
                Thread.sleep(forTimeInterval: characterDelay/100)
            }
        }
        
        if let task = writingTask {
            let queue = DispatchQueue(label: "typespeed", qos: DispatchQoS.userInteractive)
            queue.asyncAfter(deadline: .now() + 0.05, execute: task)
        }
    }
    
}


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



class addAuditSites: UIViewController,UIImagePickerControllerDelegate,UITextViewDelegate, UINavigationControllerDelegate,CLLocationManagerDelegate,MKMapViewDelegate, saveDescription,saveDescriptionRisk, UIPencilInteractionDelegate{

 
    //userdetails:
    
    var username : String? = "Untitled"
    var companyName : String? = "Untitled"
    var userSignature : String? = "No signature"
    var userImage : String? = "No Image"
    
    
    var line1 = UIView()
    var line2 = UIView()
    
    var scrollView = UIScrollView()
    var backOfScroll = UIView()
    var editViewButton = UIView()
    var layoverView = UIView()
    var locationLabel = UILabel()
    var safetyRating = UILabel()
    var safetyRatingHeading = UILabel()
    var safetyRatingValue: Int = 4
    
    //edit image:
    var image = UIImageView()

    var canvasView: PKCanvasView!
    var imgForMarkup: UIImage?
    var editImage = UIButton()
    var saveImage = UIButton()
    
    var clearDrawingButton = UIButton()
    var backEditsButton = UIButton()
    
    var backgroundImage = UIView()
    var descriptionTextfieldHeader = UILabel()
    var descriptionTextfield = UITextView()
    var editDescription = UIButton()
    var cameraButton = UIButton()
    let picker = UIImagePickerController()
    var imageArrayURL = [String]()
   
    
    
    var maxScroll = 1000.00
    
    var userUID = String()
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
    

    var ButtonPressed: Int = 0
    
    



    func saveDescription(text: String) {
            self.siteDescription = text
            //self.descriptionTextfield.text = text
            self.descriptionTextfield.setTextWithTypeAnimation(typedText: "\n\(text)", characterDelay:  10) //less delay is faster
  
    
    }
    
    func saveRisk(text: String) {
        
        switch text {
        case "0":
            
            self.safetyRating.text = "No Risk"
            self.safetyRating.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            safetyRatingValue = 0

            
            break
        case "1":
            
            self.safetyRating.text = "Low Risk"
            self.safetyRating.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
            safetyRatingValue = 1
            
            break
        case "2":
            
            self.safetyRating.text = "Medium Risk"
            self.safetyRating.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
            safetyRatingValue = 2

            
            break
            
        case "3":
            
            self.safetyRating.text = "High Risk"
            self.safetyRating.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            safetyRatingValue = 3
            
            break
            
            
            
            
        default:

            
            break
        }
  
    }
  
    override func viewDidAppear(_ animated: Bool) {
        
        if let window = self.view.window, let toolPicker = PKToolPicker.shared(for: window) {
        toolPicker.setVisible(true, forFirstResponder: self.canvasView)
        toolPicker.addObserver(self.canvasView)
            
            print("A2:\(self.siteID)")
            print("A2:\(self.auditID)")
            print("A2:\(self.userUID)")
         
        }
  
        self.canvasView.drawingPolicy = .anyInput
        self.canvasView.isUserInteractionEnabled = false

    }
    
   
    override func viewDidLoad() {

        
        super.viewDidLoad()
        //new canvas on load, so it doesnt renew everytime.
        self.canvasView?.drawing = PKDrawing()
       
        
        
        //get the users details
        loadUserStats()
        
        
        findlocation()
  
    
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        descriptionTextfield.delegate = self
        
        picker.delegate = self
        

        
    
        image = UIImageView(frame: CGRect(x: 0, y: -3, width: Int(view.frame.width), height: 400))
        //image.backgroundColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
        //image.layer.borderColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        //image.layer.borderWidth = 2
        image.contentMode = .scaleAspectFit
        image.layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        image.layer.cornerRadius = 20
        image.layer.masksToBounds = false
        image.layer.shadowOffset = CGSize(width: 0, height: 4.0)
        image.layer.shadowRadius = 8.0
        image.layer.shadowOpacity = 0.4
        image.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        image.layer.borderWidth = 4
        
        
        //initiliaze the canvas:
        self.canvasView = PKCanvasView.init(frame: self.image.frame)
        self.canvasView .contentMode = .scaleAspectFit
        self.canvasView.isOpaque = false
        self.canvasView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        self.canvasView.layer.borderWidth = 2

        
        layoverView = UIView.init(frame: self.image.frame)
        layoverView.layer.borderColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        layoverView.layer.borderWidth = 2
        layoverView.isHidden = true
       
        
        
        descriptionTextfieldHeader = UILabel(frame:CGRect(x: 10, y:image.frame.maxY / 2 + 10 /*image.frame.maxY*/, width: image.frame.width, height: 30))
        //descriptionTextfieldHeader.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        descriptionTextfieldHeader.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        descriptionTextfieldHeader.text = ""
        descriptionTextfieldHeader.font = UIFont.boldSystemFont(ofSize: 30)

        
        
        
       
        descriptionTextfield = UITextView(frame: CGRect(x: 0, y: descriptionTextfieldHeader.frame.maxY + 20 , width: view.frame.width, height: 200))
        descriptionTextfield.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        descriptionTextfield.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        descriptionTextfield.font = UIFont.boldSystemFont(ofSize: 15)
        descriptionTextfield.text = ""
        descriptionTextfield.isUserInteractionEnabled = true
        descriptionTextfield.isEditable = false
        descriptionTextfield.delegate = self
        descriptionTextfield.textAlignment = .left
        descriptionTextfield.layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        descriptionTextfield.layer.cornerRadius = 20
        descriptionTextfield.layer.masksToBounds = false
        descriptionTextfield.layer.shadowOffset = CGSize(width: 0, height: 4.0)
        descriptionTextfield.layer.shadowRadius = 4.0
        descriptionTextfield.layer.shadowOpacity = 0.4
  
    
        
    
   

        
        
        
        //Buttons:

        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: image.frame.minY, width: view.frame.width, height: view.frame.height ))
        scrollView.contentSize.height = maxScroll
        scrollView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        scrollView.isHidden = true

        
        editViewButton = UIView(frame: CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: view.frame.height))
        editViewButton.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
        editViewButton.layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        editViewButton.layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        editViewButton.layer.cornerRadius = 20
        editViewButton.layer.masksToBounds = false
        editViewButton.layer.shadowOffset = CGSize(width: 0, height: 4.0)
        editViewButton.layer.shadowRadius = 8.0
        editViewButton.layer.shadowOpacity = 0.4
        
        backEditsButton = UIButton(frame: CGRect(x: view.frame.width*1/4 - 50, y:  30, width: 100, height: 100))
        backEditsButton.setTitleColor(UIColor.white, for: .normal)
        backEditsButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        backEditsButton.setTitle("Done", for: .normal)
        //backEditsButton.setImage(UIImage(systemName: "pencil"), for: .normal)
        backEditsButton.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        backEditsButton.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        backEditsButton.layer.cornerRadius = 50
        backEditsButton.layer.masksToBounds = true
        backEditsButton.addTarget(self, action: #selector(backEdits(_:)), for: .touchUpInside)
   
        
        clearDrawingButton = UIButton(frame: CGRect(x: view.frame.width*3/4 - 50, y:  30, width: 100, height: 100))
        clearDrawingButton.setTitleColor(UIColor.white, for: .normal)
        clearDrawingButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        clearDrawingButton.setTitle("Clear", for: .normal)
        //clearDrawingButton.setImage(UIImage(systemName: "pencil"), for: .normal)
        clearDrawingButton.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        clearDrawingButton.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        clearDrawingButton.layer.cornerRadius = 50
        clearDrawingButton.layer.masksToBounds = true
        clearDrawingButton.addTarget(self, action: #selector(onClear(_:)), for: .touchUpInside)
  
        
        
        
        backOfScroll = UIView(frame: CGRect(x: 0, y: descriptionTextfield.frame.maxY - 50, width: view.frame.width, height: scrollView.frame.height ))
        backOfScroll.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
 
   
        line1 = UIView(frame: CGRect(x: 10, y: descriptionTextfield.frame.maxY + 30, width: view.frame.width - 20, height: 0.5))
        line1.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        line1.layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        line1.layer.cornerRadius = 20
        line1.layer.masksToBounds = false
        line1.layer.shadowOffset = CGSize(width: 0, height: 4.0)
        line1.layer.shadowRadius = 8.0
        line1.layer.shadowOpacity = 0.4
        
        
        
        
        safetyRatingHeading = UILabel(frame:CGRect(x: 10, y: descriptionTextfield.frame.maxY + 30, width: 160, height: 40))
        //safetyRating.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        safetyRatingHeading.text = "Risk Rating:"
        safetyRatingHeading.numberOfLines = 1
        safetyRatingHeading.font = UIFont.boldSystemFont(ofSize: 20)
        safetyRatingHeading.layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        safetyRatingHeading.layer.cornerRadius = 8
        safetyRatingHeading.textAlignment = .center
        safetyRatingHeading.layer.masksToBounds = false
        safetyRatingHeading.layer.shadowOffset = CGSize(width: 0, height: 4.0)
        safetyRatingHeading.layer.shadowRadius = 8.0
        safetyRatingHeading.layer.shadowOpacity = 0.4
        
        
        safetyRating = UILabel(frame:CGRect(x: safetyRatingHeading.frame.maxX + 10, y: descriptionTextfield.frame.maxY + 30, width: view.frame.width - (safetyRatingHeading.frame.maxX + 20), height: 40))
        //safetyRating.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        //safetyRating.text = "Safety Rating:"
        safetyRating.numberOfLines = 1
        safetyRating.font = UIFont.boldSystemFont(ofSize: 20)
        safetyRating.layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        safetyRating.layer.cornerRadius = 8
        safetyRating.textAlignment = .center
        safetyRating.layer.masksToBounds = true
        safetyRating.layer.shadowOffset = CGSize(width: 0, height: 4.0)
        safetyRating.layer.shadowRadius = 8.0
        safetyRating.layer.shadowOpacity = 0.4
        
        
        line2 = UIView(frame: CGRect(x: 10, y: line1.frame.maxY + 30 + 50, width: view.frame.width - 20, height: 0.5))
        line2.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        line2.layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        line2.layer.cornerRadius = 20
        line2.layer.masksToBounds = false
        line2.layer.shadowOffset = CGSize(width: 0, height: 4.0)
        line2.layer.shadowRadius = 8.0
        line2.layer.shadowOpacity = 0.4
        
        
        editDescription = UIButton(frame: CGRect(x: 10, y:  line2.frame.maxY + 80, width: view.frame.width - 20, height: 40))
        editDescription.setTitleColor(UIColor.white, for: .normal)
        editDescription.setTitle("Edit description", for: .normal)
        editDescription.backgroundColor = #colorLiteral(red: 1, green: 0.5843137255, blue: 0, alpha: 1)
        editDescription.layer.cornerRadius = 20
        editDescription.layer.masksToBounds = true
        editDescription.addTarget(self, action: #selector(editDescriptionButton(_:)), for: .touchUpInside)
     
        
        
        editImage = UIButton(frame: CGRect(x: 10, y:  line2.frame.maxY + 30, width: view.frame.width - 20, height: 40))
        editImage.setTitleColor(UIColor.white, for: .normal)
        editImage.setTitle("Edit Image", for: .normal)
        //editImage.setImage(UIImage(systemName: "pencil"), for: .normal)
        editImage.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        editImage.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        editImage.layer.cornerRadius = 20
        editImage.layer.masksToBounds = true
        editImage.addTarget(self, action: #selector(editImageButton), for: .touchUpInside)
   
        
        

        view.addSubview(image)
        //self.view.addSubview(descriptionTextfield)
        //self.view.addSubview(descriptionTextfieldHeader)
        view.addSubview(layoverView)
        view.addSubview(self.canvasView)
        
        //self.view.addSubview(editDescription)
        
        view.addSubview(scrollView)
        view.addSubview(editViewButton)
 
        
        editViewButton.addSubview(backEditsButton)
        editViewButton.addSubview(clearDrawingButton)
        
        
        scrollView.addSubview(backOfScroll)
        scrollView.addSubview(editDescription)
        scrollView.addSubview(editImage)
        scrollView.addSubview(descriptionTextfield)
        scrollView.addSubview(descriptionTextfieldHeader)
        //scrollView.addSubview(line1)
        scrollView.addSubview(safetyRatingHeading)
        scrollView.addSubview(safetyRating)
        //scrollView.addSubview(line2)
        
        
        
  
        
        
        
        
        
        
        
        
        
        
        
        
        //Ask user for site name:
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Audit Title:", message: "", preferredStyle: .alert)

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
    
    @objc func  backEdits(_ sender : UIButton) {

        editImageButton()

    }
        
     func  saveData() {
 
         var drawing = self.canvasView.drawing.image(from: self.canvasView.bounds, scale: 0)
         if let markedupImage = self.saveImage(drawing: drawing){
             // Save the image or do whatever with the Marked up Image
             
             let data = markedupImage.pngData()
             self.localImageData = data! as Data
             

             self.saveImageDataFirebase(imageData: localImageData)
             
             
         }


    }
    
    @objc func editImageButton(){
        
        //self.canvasView.drawingPolicy = .anyInput
        //self.canvasView?.drawing = PKDrawing()
        self.canvasView.becomeFirstResponder()

  
        
        //animate scroll to the left
        ButtonPressed += 1
        
        if ButtonPressed % 2 == 0  {
            //hide edit options
            self.layoverView.isHidden = true
            UIView.animate(withDuration: 1, delay: 0, animations: {
                
                
                self.scrollView.frame.origin.y -= self.view.frame.height
                self.editViewButton.frame.origin.y += self.view.frame.height
                self.canvasView.isUserInteractionEnabled = false
                
                
                self.image.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.layoverView.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.canvasView.transform = CGAffineTransform(scaleX: 1, y: 1)
            })
     
        }else{
            // show edit options
            self.layoverView.isHidden = false
            UIView.animate(withDuration: 1, delay: 0, animations: {
               
                self.canvasView.isUserInteractionEnabled = true
                self.scrollView.frame.origin.y += self.view.frame.height

              
                //adjust the image so its center here

                self.image.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
                self.layoverView.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
                self.canvasView.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
 
                self.editViewButton.frame = CGRect(x: 0, y: self.image.frame.maxY + 20,  width: self.view.frame.width , height: self.view.frame.height - (self.image.frame.maxY) )


            })
            
        }
        
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
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        if let viewController = storyboard.instantiateViewController(withIdentifier: "addSiteDetails") as? addSiteDetails{
//
//            if let presentationController = viewController.presentationController as? UISheetPresentationController {
//                presentationController.detents = [.medium(), .large()] /// change to [.medium(), .large()] for a half *and* full screen sheet
//                presentationController.prefersGrabberVisible = true
//                presentationController.preferredCornerRadius = 45
//                presentationController.largestUndimmedDetentIdentifier = .medium
//            }
//
//
//
//          self.present(viewController, animated: true)
//
         
//    }

       
    self.performSegue(withIdentifier: "addDescription", sender: self)
        
        
//        let pageSheet = addSiteDetails()
//        let nav = UINavigationController(rootViewController: pageSheet)
//        nav.title = "Description"
//        nav.modalPresentationStyle = .pageSheet
//
//        if let sheet = nav.sheetPresentationController {
//            sheet.detents = [.medium()]
//            sheet.prefersGrabberVisible = true
//            sheet.preferredCornerRadius = 40
//            sheet.largestUndimmedDetentIdentifier = .medium
//        }
//
//        present(nav, animated: true, completion: nil)

    }
    
    @objc func editDescriptionButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "addDescription", sender: self)
        

    }
    
    @objc func openCamera(_ sender: UIButton) {
       // do your stuff here
      print("you clicked on button \(sender.tag)")
        selectImageType()

    }



    @IBAction func addToAuditList(_ sender: Any) {
        //self.saveImageDataFirebase(imageData: localImageData)
        
        //save drawing and upload to database
        saveData()
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
            
            //show edit button
            scrollView.isHidden = false

            
 
            
        }
        
        picker.dismiss(animated: true, completion:nil)
        presentModal()
        

        
        
    }
    
 

    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
  
    
    func saveImageDataFirebase(imageData:Data){
        
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
        
  
        
        if userUID != uid!{
            
//This would be from a user that is collaborating
    
            let reftest = Database.database().reference()
                .child("\(self.mainConsole.prod!)")
            
            let thisUsersGamesRef = reftest
                .child("\(self.mainConsole.post!)")
                .child("\(userUID)")
                .child("\(self.mainConsole.audit!)")
                .child("\(auditID)")
                .child("\(self.mainConsole.siteList!)")
                .child("\(siteID)")
                .child("\(self.mainConsole.auditList!)")
                .child("\(uuid)")
            
            let refData = "\(self.mainConsole.prod!)/\(self.mainConsole.post!)/\(userUID)/\(self.mainConsole.audit!)/\(auditID)/\(self.mainConsole.siteList!)/\(siteID)/\(self.mainConsole.auditList!)/\(uuid)"
            
            
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
                riskRating: safetyRatingValue,
                status: "true",
                userUploaded: "\(self.username!) • [\(self.companyName!)] ",
                userUploadedSignature: self.userSignature!,
                userUploadedImage: "")
            
            
            
            
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
                        
                        
                        self.firebaseConsole.updateObservationCount(count: "\(self.listOfSitesData.count)", auditID: self.auditID, siteID: self.siteID, userUID: self.userUID)
                        
                        print("updated and saved observation")
                        SwiftLoader.hide()
                        
                    })
                    
                }
                
            }
            
        }else{
            
//This would be user that is listing item
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
                riskRating: safetyRatingValue,
                status: "true",
                userUploaded: "\(self.username!) • [\(self.companyName!)] ",
                userUploadedSignature: self.userSignature!,
                userUploadedImage: self.userImage!)
            
            
            
            
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
                        self.firebaseConsole.updateObservationCount(count: "\(self.listOfSitesData.count)", auditID: self.auditID, siteID: self.siteID, userUID: uid!)
                        
                        print("updated and saved observation")
                        SwiftLoader.hide()
                        
                    })
                    
                }
                
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
    
    
    
    
    
    
    
    
    
    
    
    
//Get the creating the observation details--------------------------------------------------------[START]
    
  
    func loadUserStats(){

        
                 let uid = Auth.auth().currentUser?.uid
                 let reftest = Database.database().reference()
                     .child("\(mainConsole.prod!)")
                     .child("\(mainConsole.post!)")
                     .child(uid!)
                     .child("\(mainConsole.userDetails!)")
                 
                 reftest.queryOrderedByKey()
                     .observe( .value, with: { snapshot in
                               guard let dict = snapshot.value as? [String:Any] else {
                               //error here
                               return
                               }

                                let username = dict["userName"] as? String
                                let companyName = dict["companyName"] as? String
                                let DPimage = dict["DPimage"] as? String
                                let signatureURL = dict["signatureURL"] as? String
                         
                                 self.username = username
                                 self.companyName = companyName
                                 self.userSignature = signatureURL
                                 self.userImage = DPimage
                  
                           
                   })
        
     
    }

//Get the creating the observation details--------------------------------------------------------[END]
    
    
    
    
    
    
    
    
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if let destination3 = segue.destination as? addSiteDetails {
             destination3.delegate1 = self
             destination3.delegate2 = self
             destination3.stringData = siteDescription
             destination3.safetRiskValue = safetyRatingValue
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
