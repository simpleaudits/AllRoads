//
//  editImage.swift
//  RSAC
//
//  Created by John on 16/9/2024.
//

import UIKit
import PencilKit
import SDWebImage
import PhotosUI
import Foundation


// create a protocol for the edit image
protocol imageData {
    func finishPassing_Image(saveImage: UIImage, saveCavnasView: PKDrawing, selectedImage: UIImage)
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


class editImage: UIViewController,UIImagePickerControllerDelegate,UIPencilInteractionDelegate, UINavigationControllerDelegate {

    //image properties:
    //edit image:
    var imageView = UIImageView()
    var canvasView = PKCanvasView()
    var canvasData = PKDrawing()
    var selectedImage = UIImage()
    
    var layoverView = UIView()
    let toolPicker = PKToolPicker()
    let picker = UIImagePickerController()
    var delegate: imageData?
    var ButtonPressed: Int = 0
    
    
    
    override func viewDidDisappear(_ animated: Bool) {
        hideToolPicker()

        if imageView.image == nil{

        }else{
            saveData()
        }


    }
    
    override func viewDidAppear(_ animated: Bool) {
        //load the pencil kit after 1 second, can not load instant
        presentPencilKit()
        
        if isImageEmpty(image: selectedImage) {
            print("The image is empty.")
            permissionToAccessPhotos()
           
           
            } else {
            print("The image is valid.")
            imageView.image = selectedImage
            canvasView.drawing = canvasData
   
      
            }

        


  
    }
    
    func isImageEmpty(image: UIImage?) -> Bool {
        // Check if the image is nil or has no size
        guard let image = image else { return true }
        return image.size == .zero
    }
    
    func  saveData(){

        let drawing = self.canvasView.drawing.image(from: self.canvasView.bounds, scale: 0)
        
        if let markedupImage = self.saveImage(drawing: drawing){
            // Save the image or do whatever with the Marked up Image
            let data = markedupImage
            let canvasData = canvasView.drawing
            
            self.delegate?.finishPassing_Image(saveImage: data, saveCavnasView: canvasData, selectedImage: imageView.image!)


            
        }


   }
    
    func showActionSheet() {
        // Create the action sheet
        let actionSheet = UIAlertController(title: "Choose an Option", message: "", preferredStyle: .actionSheet)

        // Add actions
        actionSheet.addAction(UIAlertAction(title: "Draw", style: .default, handler: { _ in
        
            self.canvasView.becomeFirstResponder()
            
            //animate scroll to the left
            self.ButtonPressed += 1
            
            self.canvasView.isUserInteractionEnabled = false
            
            if self.ButtonPressed % 2 == 0  {
                
            }else{
                
            self.canvasView.isUserInteractionEnabled = true
                
            }
            
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Clear drawing", style: .default, handler: { _ in
            
            self.canvasView.drawing = PKDrawing()
        
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        // Present the action sheet
        present(actionSheet, animated: true, completion: nil)
    }
    
    
    @IBAction func editButton(_ sender: Any) {
        showActionSheet()

        
    }
    
    
    override func viewDidLoad() {
        //navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(onClear))
        
        super.viewDidLoad()
        
  
        //new canvas on load, so it doesnt renew everytime.
        self.canvasView.drawing = PKDrawing()
        
        
        picker.delegate = self

        

        // Do any additional setup after loading the view.
           // Get the navigation bar height
          
        imageView = UIImageView(frame: CGRect(x: 0, y: 150, width: view.frame.width, height:400))
    
           
       
        //image.backgroundColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
        //image.layer.borderColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        //image.layer.borderWidth = 2
        imageView.contentMode = .scaleToFill
        imageView.layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        //imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        imageView.layer.shadowOffset = CGSize(width: 0, height: 4.0)
        imageView.layer.shadowRadius = 8.0
        imageView.layer.shadowOpacity = 0.4
        //image.layer.borderColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        imageView.layer.borderWidth = 2
        //image.image = UIImage(named: "man.png")
        
        //initiliaze the canvas:
        self.canvasView = PKCanvasView.init(frame: self.imageView.frame)
        self.canvasView .contentMode = .scaleAspectFit
        self.canvasView.isOpaque = false
        self.canvasView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        self.canvasView.layer.borderWidth = 2
   
     
        

        

        
        view.addSubview(imageView)
        //self.view.addSubview(descriptionTextfield)
        //self.view.addSubview(descriptionTextfieldHeader)
  
        view.addSubview(self.canvasView)
      
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
        
        if let jpegData = editedImage.jpegData(compressionQuality: 1){
            try? jpegData.write(to: imagePath)

      
            //We want to save the image URL string and then loop later to save in firebase.
            let imageURLtoNSData = NSURL(string: "\(imagePath)")
         
            //let imageData = NSData (contentsOf: imageURLtoNSData! as URL)
           
      
            imageView.image = UIImage(data: jpegData)
   
            
            
        }
        
        picker.dismiss(animated: true, completion:nil)
        
     
  
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func saveImage(drawing : UIImage) -> UIImage? {
        
        let bottomImage = imageView.image
        let newImage = autoreleasepool { () -> UIImage in
            UIGraphicsBeginImageContextWithOptions(self.canvasView.frame.size, false, 0.0)
            bottomImage!.draw(in: CGRect(origin: CGPoint.zero, size: self.canvasView.frame.size))
            drawing.draw(in: CGRect(origin: CGPoint.zero, size: self.canvasView.frame.size))
            let createdImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
                return createdImage!
            }

                return newImage
        
        
            }

    func presentPencilKit(){
         // Create an instance of PKToolPicker
    
         
       // if let window = self.view.window, let toolPicker = PKToolPicker.shared(for: window) {
        
        if self.view.window != nil {
            
            toolPicker.setVisible(true, forFirstResponder: self.canvasView)
            toolPicker.addObserver(self.canvasView)
            
        }
         
         self.canvasView.drawingPolicy = .anyInput
         self.canvasView.isUserInteractionEnabled = false
      
    }
    //hide pencilkit
    func hideToolPicker() {
           // Hide the tool picker
        if self.view.window != nil {
               toolPicker.setVisible(false, forFirstResponder: canvasView)
           }
       }
    
    func permissionToAccessPhotos(){
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { [unowned self] (status) in
            DispatchQueue.main.async { [unowned self] in
                showUI(for: status)
            }
        }
    }
    
    func showUI(for status: PHAuthorizationStatus) {
        
        switch status {
        case .authorized:
            //showFullAccessUI()
            print("authorised")
            //if the user is granted access the page will continue to function.
            selectImageType()
      

        case .limited:
            //showLimittedAccessUI()
            print("limited")
            selectImageType()
            
         

        case .restricted:
            //showRestrictedAccessUI()
            print("restricted")

        case .denied:
            showAccessDeniedUI()

        case .notDetermined:
            break

        @unknown default:
            break
        }
    }

    
    func showAccessDeniedUI() {
        
        let alert = UIAlertController(title: "AllRoadsAudit Does not have permission to access your photos.",
                                      message: "To change this, go to your settings and tap \"Photos\".\nif you want to use photos from your library, please select \"All photos\".",
                                      preferredStyle: .alert)
        
        let notNowAction = UIAlertAction(title: "Exit",
                                         style: .cancel,
                                         handler: nil)
        
        
        alert.addAction(notNowAction)
        
        let openSettingsAction = UIAlertAction(title: "Open Settings",
                                               style: .default) { [unowned self] (_) in
            // Open app privacy settings
            gotoAppPrivacySettings()
        }
        alert.addAction(openSettingsAction)
        
        present(alert, animated: true, completion: nil)
        
    }
    
//    func showLimittedAccessUI() {
//        manageButton.isHidden = false
//        seeAllButton.isHidden = true
//        
//        let photoCount = PHAsset.fetchAssets(with: nil).count
//        infoLabel.text = "Status: limited\nPhotos: \(photoCount)"
//    }
//    
   func seeAllButtonTapped(_ sender: Any) {
        
        let alert = UIAlertController(title: "Allow access to your photos",
                                      message: "This lets you share from your camera roll and enables other features for photos and videos. Go to your settings and tap \"Photos\".\nif you want to use photos from your library, please select \"All photos\".",
                                      preferredStyle: .alert)
        
        let notNowAction = UIAlertAction(title: "Not Now",
                                         style: .cancel,
                                         handler: nil)
       
       
       self.navigationController?.popViewController(animated: true)
       
        alert.addAction(notNowAction)
        
        let openSettingsAction = UIAlertAction(title: "Open Settings",
                                               style: .default) { [unowned self] (_) in
            // Open app privacy settings
            gotoAppPrivacySettings()
        }
        alert.addAction(openSettingsAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func gotoAppPrivacySettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString),
            UIApplication.shared.canOpenURL(url) else {
                assertionFailure("Not able to open App privacy settings")
                return
        }

        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }

}
