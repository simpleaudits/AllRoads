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



class signatureViewController: UIViewController,UIImagePickerControllerDelegate,UITextViewDelegate, UINavigationControllerDelegate,CLLocationManagerDelegate,MKMapViewDelegate, UIPencilInteractionDelegate{
 
    
 
    


    //edit image:
    var textPlaceHolder = UILabel()
    var image = UIImageView()
    var layoverView = UIView()
    var canvasView: PKCanvasView!
    var imgForMarkup: UIImage?
    var clearImage = UIButton()
    var saveImage = UIButton()
    
    
    var backgroundImage = UIView()
  


    var cameraButton = UIButton()

 
    
    var auditID = String()
    var siteID = String()
    var siteName = String()
    var siteDescription = String()
    
    let mainConsole = CONSOLE()
    let mainFunction = extens()
    var localImageData = Data()
    
    

    let storageReference = Storage.storage().reference()
    var ThecurrentUser = Auth.auth().currentUser
    var signatureURL = String()
    let firebaseConsole = saveLocal()

    
    var location = String()
    var locationManager = CLLocationManager()
    


    

  
    override func viewDidAppear(_ animated: Bool) {
        
//        if let window = self.view.window, let toolPicker = PKToolPicker.shared(for: window) {
//        toolPicker.setVisible(true, forFirstResponder: self.canvasView)
//        toolPicker.colorUserInterfaceStyle = .dark
//        toolPicker.addObserver(self.canvasView)
//
//
//        }

    }
    
    
    
    override func viewDidLoad() {

        
        super.viewDidLoad()
  
  

        image = UIImageView(frame: CGRect(x: 10, y: 40, width: view.frame.width - 20, height: 200))
        image.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "whiteBackdrop")
        
        //initiliaze the canvas:
        self.canvasView = PKCanvasView.init(frame: self.image.frame)
        self.canvasView.isOpaque = false

        
        layoverView = UIView.init(frame: self.image.frame)
        layoverView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        layoverView.layer.borderWidth = 1
        layoverView.isHidden = true
        
        
        textPlaceHolder = UILabel.init(frame: self.image.frame)
        textPlaceHolder.text = "Sign here"
        textPlaceHolder.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        textPlaceHolder.font = UIFont.boldSystemFont(ofSize: 30)
        textPlaceHolder.textAlignment = .center

        

        saveImage = UIButton(frame: CGRect( x:image.frame.minX + 10 , y:  image.frame.maxY + 10, width: 100, height: 30))
        saveImage.setTitleColor(UIColor.white, for: .normal)
        saveImage.setTitle("Save", for: .normal)
        saveImage.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        saveImage.layer.cornerRadius = 15
        saveImage.layer.masksToBounds = true
        saveImage.addTarget(self, action: #selector(saveDrawing(_:)), for: .touchUpInside)
        
        clearImage = UIButton(frame: CGRect( x:saveImage.frame.maxX + 10 , y:  image.frame.maxY + 10, width: 100, height: 30))
        clearImage.setTitleColor(UIColor.white, for: .normal)
        clearImage.setTitle("Clear", for: .normal)
        clearImage.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        clearImage.layer.cornerRadius = 15
        clearImage.layer.masksToBounds = true
        clearImage.addTarget(self, action: #selector(onClear(_:)), for: .touchUpInside)
        
        
        
        
        self.view.addSubview(saveImage)
        self.view.addSubview(clearImage)
        self.view.addSubview(image)
        self.view.addSubview(layoverView)
        self.view.addSubview(textPlaceHolder)
        self.view.addSubview(self.canvasView)
      

        
        //ENALBE EDIT
        openCanvas()
    }
    
// Drawing  --------------------------------------------------------------------------------------------------------------------[START]
    @objc func saveDrawing(_ sender : UIButton){
        saveDrawing()
    }
    
    @objc func  onClear(_ sender : UIButton) {
        canvasView.drawing = PKDrawing()
    }
    
    
    
   func saveDrawing(){
        var drawing = self.canvasView.drawing.image(from: self.canvasView.bounds, scale: 0)
        if let markedupImage = self.saveImage(drawing: drawing){
            // Save the image or do whatever with the Marked up Image
            let saveData = markedupImage.pngData()
            self.localImageData = saveData! as Data
            
      
            updateCompanyImage(imageData: self.localImageData, ref: "\(self.mainConsole.prod!)/\(self.mainConsole.post!)/\(ThecurrentUser!.uid)/\(self.mainConsole.userDetails!)")
            
        }
        
         
    }
        
    func openCanvas(){
        self.canvasView.drawingPolicy = .anyInput
        self.canvasView?.drawing = PKDrawing()
        self.canvasView.becomeFirstResponder()
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
    
   
// Drawing  --------------------------------------------------------------------------------------------------------------------[END]
    
// Change user display picture  --------------------------------------------------------------------------------------------------------------------[START]
               
                func updateCompanyImage(imageData:Data, ref:String){
                //activity indicator
                SwiftLoader.show(title: "Uploading Signature", animated: true)


                // constantly override the image
                let companyImageRef = storageReference
                .child("\(self.mainConsole.prod!)")
                .child("\(self.mainConsole.post!)")
                .child(ThecurrentUser!.uid)
                //.child("\(self.mainConsole.audit!)")
                .child("\(mainConsole.userDetails!)")
                .child("\(mainConsole.profileSignature!)")
                .child("\(ThecurrentUser!.uid)-\(mainConsole.profileSignature!).jpg")



                let uploadMetaData = StorageMetadata()
                uploadMetaData.contentType = "image/jpeg"

                //1) updating storage level data - data
                companyImageRef.putData(imageData as Data, metadata: uploadMetaData) { (uploadedImageMeta, error) in

                if error != nil{
                    SwiftLoader.hide()
                    //Could not upload data
                    self.mainFunction.errorUpload(errorMessage: "Could no upload Signature",subtitle: "\(String(describing: error?.localizedDescription))")
                    return

                }else {

                companyImageRef.downloadURL { [self] url, error in
                if error != nil {

                // handle error here
                    
                }else{
                //no error, go ahead and save
                    
                //2) updating reference url in data to display image via url
                    
                    signatureURL = "\(url!)"
                    let reftest = Database.database().reference(withPath:ref)

                    reftest.updateChildValues([
                    "signatureURL": signatureURL,
                    ]){
                    (error:Error?, ref:DatabaseReference) in
                   
                    if let error = error {
                        print("could not update company image URL: \(error).")
                        SwiftLoader.hide()
                        self.mainFunction.errorUpload(errorMessage: "Data could not be saved",subtitle: "\(error)")
                    } else {
                        print("company image URL updated")
                        self.mainFunction.successUpload(Message: "Updated", subtitle: "")
                        SwiftLoader.hide()
                        
                        self.dismiss(animated: true, completion: nil)
                    }
                    }


                }
                }
                }


                }
                }


// Change user display picture  --------------------------------------------------------------------------------------------------------------------[END]
                    
 

}
