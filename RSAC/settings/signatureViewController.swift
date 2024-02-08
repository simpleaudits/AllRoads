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
    var image = UIImageView()
    var layoverView = UIView()
    var canvasView: PKCanvasView!
    var imgForMarkup: UIImage?
    var editImage = UIButton()
    var saveImage = UIButton()
    
    
    var backgroundImage = UIView()
  


    var cameraButton = UIButton()

 
    
    var auditID = String()
    var siteID = String()
    var siteName = String()
    var siteDescription = String()
    
    let mainConsole = CONSOLE()
    let extensConsole = extens()
    var localImageData = Data()
    
    

    let storageReference = Storage.storage().reference()
    
    let firebaseConsole = saveLocal()
    var listOfSitesData: [auditSiteData] = []
    
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
        //ENALBE EDIT
       openCanvas()
    }
    
    
    
    override func viewDidLoad() {

        
        super.viewDidLoad()
  
  

        image = UIImageView(frame: CGRect(x: 0, y: 40, width: view.frame.width, height: 200))
        image.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        image.contentMode = .scaleAspectFit
        
        //initiliaze the canvas:
        self.canvasView = PKCanvasView.init(frame: self.image.frame)
        self.canvasView.isOpaque = false

        
        layoverView = UIView.init(frame: self.image.frame)
        layoverView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        layoverView.layer.borderWidth = 2
        layoverView.isHidden = true
       
    
        self.view.addSubview(image)
        self.view.addSubview(layoverView)
        self.view.addSubview(self.canvasView)

  
       
    }
    
    @objc func  onClear(_ sender : UIButton) {
        canvasView.drawing = PKDrawing()
    }
    
   func saveDrawing(){
        var drawing = self.canvasView.drawing.image(from: self.canvasView.bounds, scale: 0)
        if let markedupImage = self.saveImage(drawing: drawing){
            // Save the image or do whatever with the Marked up Image
            let data = markedupImage.pngData()
            self.localImageData = data! as Data
  

    }
    
        
}
    
     func openCanvas() {
        
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
    
   
    

    @IBAction func addToAuditList(_ sender: Any) {
        self.uploadDP(imageData: localImageData)
        
    }
  

//Saves the image to firebase -----------------------------------------------------------------------------------------[START]
    
    func uploadDP(imageData:Data){
        
      
    }
    
//Saves the image to firebase -----------------------------------------------------------------------------------------[END]
    
    
    

    
//Saves the image to firebase realtime of the URL -----------------------------------------------------------------------------------------[START]
    
    func processdata(imageURL:String, uuid:String){
        
   
  
    }

//Saves the image to firebase realtime of the URL -----------------------------------------------------------------------------------------[START]
    
 

}
