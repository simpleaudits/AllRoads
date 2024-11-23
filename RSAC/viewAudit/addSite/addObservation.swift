//
//  addObservation.swift
//  RSAC
//
//  Created by John on 8/9/2024.
//

import UIKit
import Foundation
import PhotosUI
import PencilKit
import Firebase
import SDWebImage
import SwiftLoader
import MapKit



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





extension dataCell {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "crashTypeCell", for: indexPath) as! crashTypeCell
        let data = cellItems[indexPath.row]
        
        cell.backgroundColor = #colorLiteral(red: 1, green: 0.6645795107, blue: 0.2553189099, alpha: 1)
        cell.layer.cornerRadius = 15
        cell.layer.masksToBounds = true
        cell.label.text = data
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       let string = cellItems[indexPath.item]
       
       // Create a temporary label to measure the text size
       let tempLabel = UILabel()
       tempLabel.text = (string as String)
       tempLabel.font = UIFont.systemFont(ofSize: 12) // Match the font used in the cell
       tempLabel.numberOfLines = 0
       
       // Calculate the size of the label
       let width = tempLabel.intrinsicContentSize.width + 16 // 16 is padding
       let height = tempLabel.intrinsicContentSize.height + 16 // 16 is padding
        

       
       return CGSize(width: width, height: height)
   
}
    
    
}

class dataCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {


    
    weak var textfieldViewLabel: UITextView!
    weak var siteImage: UIImageView!
    var toggleLocation: UISegmentedControl!
 
    var collectionView: UICollectionView!
    var cellItems: [String] = [] // Replace with your model

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
          super.init(style: style, reuseIdentifier: "dataCell")
          setupCollectionView()
        
       
        
        let siteImage = UIImageView(frame: .zero)
        siteImage.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(siteImage)
        NSLayoutConstraint.activate([
            siteImage.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: 10),
            siteImage.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,constant: -10),
            siteImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 10),
            siteImage.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,constant: -10),
            ])
        self.siteImage = siteImage
        self.siteImage.contentMode = .scaleAspectFit
        self.siteImage.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.007843137255)
        self.siteImage.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.siteImage.layer.shadowOpacity = 1
        self.siteImage.layer.shadowOffset = .zero
        self.siteImage.layer.shadowRadius = 5
        
        
        
        //self.siteImage.layer.borderWidth = 2
        
        let textfieldViewLabel = UITextView(frame: .zero)
        textfieldViewLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(textfieldViewLabel)
        NSLayoutConstraint.activate([
            textfieldViewLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5),
            textfieldViewLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5),
            textfieldViewLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            textfieldViewLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,constant: -10),
            ])
        self.textfieldViewLabel = textfieldViewLabel
        
        //self.textLabel.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        //self.textLabel.layer.borderWidth = 0.5
        self.textfieldViewLabel.textAlignment = .left
        self.textfieldViewLabel.font = UIFont.systemFont(ofSize: 15)
        self.textfieldViewLabel.backgroundColor = .white
        self.textfieldViewLabel.layer.masksToBounds = true
        self.textfieldViewLabel.layer.cornerRadius = 8
        
        
        let items = ["Do not use Location", "Use Location"]
        toggleLocation = UISegmentedControl(items: items)
        toggleLocation.selectedSegmentIndex = 0

        
        
     
        toggleLocation.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(toggleLocation)
        NSLayoutConstraint.activate([
            toggleLocation.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: 10),
            toggleLocation.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,constant: -10),
            toggleLocation.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 8),
            toggleLocation.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,constant: -8),
            ])
 

        
        
        
        
        
      }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // Method to handle any customization if needed
    func configure(with selectedIndex: Int) {
        toggleLocation.selectedSegmentIndex = selectedIndex
        
        
    }
    
    private func setupCollectionView() {
           let layout = UICollectionViewFlowLayout()
           layout.scrollDirection = .horizontal
           collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
           collectionView.translatesAutoresizingMaskIntoConstraints = false
           collectionView.backgroundColor = .white
           collectionView.delegate = self
           collectionView.dataSource = self
           
           
           // Register your cell class here
           collectionView.register(crashTypeCell.self, forCellWithReuseIdentifier: "crashTypeCell")
           
           contentView.addSubview(collectionView)

           // Constraints
           NSLayoutConstraint.activate([
               collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
               collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
               collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 5),
               collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
           ])
       }
           
        
           
           
       

}




class addObservation: UITableViewController,UIPencilInteractionDelegate, imageData, saveDescription, saveDescriptionRisk, saveDescriptionTag,locationDecriptionString {


    
    let mainConsole = CONSOLE()
    let extensConsole = extens()

    
    var refData = String()
    var listOfSitesData: [auditSiteData] = []
    let firebaseConsole = saveLocal()
    
    //load user details:
    var username : String? = "Untitled"
    var companyName : String? = "Untitled"
    var userSignature : String? = "No signature"
    var userImage : String? = "No Image"
    
    
    //Reference to site and audit ID
    var auditID = String()
    var siteID = String()
    var userUID = String()
    var companyImage = UIImage()
    
    var locationString = String()
    var lat = CGFloat(0.00)
    var long = CGFloat(0.00)

    let storageReference = Storage.storage().reference()
    
    //image save contents:
    
    //audit data here:
    var image = UIImage()
    var selectedImage = UIImage()
    //var canvasView = PKCanvasView()
    var canvasData = PKDrawing()
    var siteTitle = String()
    var siteDescription = String()
    var riskDataArray : [String] = []
    var tagDataArray : [String] = []
    var nest1 : [String] = []
    
    let switchKey = ["Comment",
                     "Risk",
                     "Tag",
                     "Title",
                     "Location"
    ]
    var switchKeySelection = String()
    
    let headingsItem =         ["Title",
                                "Photo",
                                "Comment",
                                "Risk",
                                "Tag",
                                "Location"
                                ]
    
    let questionsListSection4 = [""]     // title
    let questionsListSection0 = ["",""] //photo
    let questionsListSection1 = [""]    // comment
    let questionsListSection2 = [""]    //risk
    let questionsListSection3 = [""]    //tag
    let questionsListSection5 = ["",""]    //location
    var rowForLocationCount = 1

    
    // this has been removed
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.register(dataCell.self, forCellReuseIdentifier: "dataCell")
        tableView.dataSource = self
        tableView.delegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Upload", style: .plain, target: self, action: #selector(callSave))
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    //Passing the Risk data
    func saveRisk(text: [String]) {
        print("riskTypeTo:\(text)")
        self.riskDataArray = text
       
    }
    
    
    func saveTag(text: [String]) {
        print("TagTypeTo:\(text)")
        self.tagDataArray = text
    }
    
    func finishPassing_location(saveLocation: String, lat: CGFloat, long: CGFloat){
        //Display audit stage cell when the string is not empty.
            print ("not empty")

            self.lat = lat
            self.long = long
        
            self.locationString = "\(saveLocation)"
        

        
            
   
            tableView.reloadData()
       
    }
    
    //MARK: image edit here:
    func finishPassing_Image(saveImage: UIImage, saveCavnasView: PKDrawing, selectedImage: UIImage) {

        //merged iamge
        image = saveImage
        //canvas pallete
        canvasData = saveCavnasView
        //origionalImage
        self.selectedImage = selectedImage
        
        
    }
    
    func saveDescription(text: String) {
        self.siteDescription = text
        print("siteDescriptionTo:\(siteDescription)")
    }

    // Action for UISegmentedControl value change
    @objc func segmentedControlValueChanged(_ segmentedControl: UISegmentedControl) {
         switch (segmentedControl.selectedSegmentIndex) {
         case 0:
             print("no location")
             locationString = ""
             rowForLocationCount = 1
             tableView.reloadData()
             break
         default:
             print("use location")
             locationString = " "
             rowForLocationCount = 2
             tableView.reloadData()
             
             break
         }
     }
   

    // MARK: - save function here
    @objc func callSave(){
        
        if (siteTitle.isEmpty || siteDescription.isEmpty || riskDataArray.isEmpty || tagDataArray.isEmpty){
            
            let Alert = UIAlertController(title: "Whoops!⚠️", message: "One or more fields are empty", preferredStyle: .alert)
            let action1 = UIAlertAction(title: "Try Again",style: .cancel)
            { (action:UIAlertAction!) in
            }
            
            Alert.addAction(action1)
            self.present(Alert, animated: true, completion: nil)
            
            
    
            
        }else{
            if (selectedImage.size.width == 0 || selectedImage.size.height == 0){
                
                let Alert = UIAlertController(title: "Whoops!⚠️", message: "Image is empty", preferredStyle: .alert)
                let action1 = UIAlertAction(title: "Try Again",style: .cancel)
                { (action:UIAlertAction!) in
                }
                
                Alert.addAction(action1)
                self.present(Alert, animated: true, completion: nil)
                
            }else{
                saveData(imageData: selectedImage.pngData()!)
            }
           
        }
        
        
         
    }
    func saveData(imageData:Data){
        
        //activity indicator
        SwiftLoader.show(title: "Saving Data (1/2)", animated: true)
        
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
        SwiftLoader.show(title: "Saving Data (2/2)", animated: true)
    
            
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
                auditTitle:"\(siteTitle)",
                auditID: auditID,
                imageURL: imageURL,
                auditDescription:"\(siteDescription)",
                date: "\(extensConsole.timeStamp())",
                lat: self.lat,
                long: self.long,
                ref: "\(refData)",
                observationID: "\(uuid)",
                siteID:"\(siteID)",
                riskRating: "\(riskDataArray)",
                nest1: "\(nest1)",
                tag: "\(tagDataArray)",
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
                auditTitle:"\(siteTitle)",
                auditID: auditID,
                imageURL: imageURL,
                auditDescription:"\(siteDescription)",
                date: "\(extensConsole.timeStamp())",
                lat: self.lat,
                long: self.long,
                ref: "\(refData)",
                observationID: "\(uuid)",
                siteID:"\(siteID)",
                riskRating: "\(riskDataArray)",
                nest1: "\(nest1)",
                tag: "\(tagDataArray)",
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
                        self.firebaseConsole.updateObservationCount(count: "\(self.listOfSitesData.count)", auditID: self.auditID, siteID: self.siteID, userUID: uid!)
                        
                        print("updated and saved observation")
                        SwiftLoader.hide()
                        
                    })
                    
                    
                    
                    
                }
                
            }
         
            
        }
  
        }
    
    
    
//MARK: - get compnay details:
    
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
    
    
//MARK: - get listing count and update
    
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
    
    
    
    
    
    
    
  //MARK: - set alert for title
    func addTitle(){
        let alert = UIAlertController(title: "Site title", message: "", preferredStyle: .alert)

        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
        textField.text = ""
        }
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { [self, weak alert] (_) in
        let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
   
            if textField!.text! == ""{
                let Alert = UIAlertController(title: "Whoops!⚠️", message: "Textfield was empty", preferredStyle: .alert)
                let action1 = UIAlertAction(title: "Try Again",style: .cancel)
                { (action:UIAlertAction!) in
                    
                    //show popup again
                    self.addTitle()
            
                }
                
                Alert.addAction(action1)
                self.present(Alert, animated: true, completion: nil)

            }else{
                //Action here
                siteTitle = textField!.text!
                tableView.reloadData()
                
            }

        }))

        let action1 = UIAlertAction(title: "Done",style: .cancel)
        { (action:UIAlertAction!) in
            

            
            
        }

        alert.addAction(action1)
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - section heading title
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        //headerView.backgroundColor = .lightGray // Set background color if needed
        
        let headerLabel = UILabel()
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.font = UIFont.boldSystemFont(ofSize: 20) // Customize font here
        headerLabel.textColor = #colorLiteral(red: 1, green: 0.5843137255, blue: 0, alpha: 1) // Customize text color if needed
        
        headerLabel.numberOfLines = 3
        
        switch section{
            
        case 0:
            //title
            headerLabel.text =  "\(headingsItem[0])"
        case 1:
            //photo
            headerLabel.text =  "\(headingsItem[1])"
        case 2:
            //comment
            headerLabel.text =  "\(headingsItem[2])"
        case 3:
            //risk
            headerLabel.text =  "\(headingsItem[3])"
        case 4:
            //risk
            headerLabel.text =  "\(headingsItem[4])"
        default:
            //tag
            headerLabel.text =  "\(headingsItem[5])"
        }
        
        
        
        headerView.addSubview(headerLabel)
        
        // Set constraints for headerLabel
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            headerLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            headerLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 0),
            headerLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 0)
        ])
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        // Return different heights based on section index, or a fixed height
        
        
        switch section {
        case 0:
            //title
            return 50
        case 1:
            //photo
            return 50
        case 2:
            //comment
            return 50
        case 3:
            //risk
            return 50
        case 4:
            //tag
            return 50
        default:
            //location
            return 50 // Default height
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
         if indexPath.section == 0 {
                //Title
                return 50.0 // Height for rows in other sections
            
        }
        else if indexPath.section == 1 {
            if indexPath.row == 0 {
                //Photo
                return 400.0 // Height for rows in section 0
            }else{
                //Add Photo
                return 50.0
            }
            
        }else if indexPath.section == 2 {
                //Comment
                return 150.0 // Height for rows in section 0
        }else if indexPath.section == 3 {
                //Risk
                return 50.0 // Height for rows in other sections
            
        }else if indexPath.section == 4 {
                //Tag
                return 50.0 // Height for rows in other sections
            
        }else if indexPath.section == 5 {
            //location
            if indexPath.row == 0{
                return 70.0 // Height for rows in other sections
            }   else{
                return 100.0 // Height for rows in other sections
            }
            
        
        
    }
   
        
        return 0
    }
    
    // MARK: - rows in section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
                switch section{
                case 0:
                    //title
                    return questionsListSection4.count
                case 1:
                    //phott
                    return questionsListSection0.count
                case 2:
                    //comment
                    return questionsListSection1.count
                case 3:
                    //risk
                    return questionsListSection2.count
                case 4:
                    //tag
                    return questionsListSection3.count
                default:
                    //location
                    return rowForLocationCount
        
                }
        
   
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return headingsItem.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "dataCell", for: indexPath) as! dataCell
       
        
        // Reset cell for reuse
        cell.siteImage.isHidden = true
        cell.textfieldViewLabel.isHidden = true // Default hidden
        cell.toggleLocation.isHidden = true
        cell.collectionView.isHidden = true
        cell.textLabel?.text = "" // Clear text label
        cell.accessoryType = .disclosureIndicator
        cell.backgroundColor = .white
        
        
        // Configure based on section and row
        
        
        if indexPath.section == 0 {
            // First row in the fourth section
     
            
            
            if indexPath.row == 0 {
          
                cell.textfieldViewLabel.isEditable = false
                cell.textfieldViewLabel.isHidden = false
                cell.textfieldViewLabel.text = siteTitle
             
     
            }
        }
        
        
        else if indexPath.section == 1 {
            cell.backgroundColor = .white
            
            if indexPath.row == 0 {
                // First row in the first section
                cell.siteImage.isHidden = false
                cell.siteImage.image = image // Ensure 'image' is defined

                cell.accessoryType = .none
                
       
         
            } else if indexPath.row == 1 {
                // Second row in the first section
          
                cell.textfieldViewLabel.isEditable = false
                cell.textLabel?.text = "Add Photo 📷"
                
            }
        } else if indexPath.section == 2 {
            // First row in the second section
            if indexPath.row == 0 {
             
                cell.textfieldViewLabel.isHidden = false
                cell.textfieldViewLabel.isEditable = false
                cell.textfieldViewLabel.setTextWithTypeAnimation(typedText: "\n\(siteDescription)", characterDelay:  1)

                
            }
        } else if indexPath.section == 3 {
            // First row in the third section
            if indexPath.row == 0 {
                
           
                cell.textfieldViewLabel.isEditable = false
                cell.collectionView.isHidden = false
                cell.textfieldViewLabel.text = "risk"
                cell.cellItems = riskDataArray
                cell.collectionView.reloadData()
                cell.backgroundColor = .systemGroupedBackground
                cell.collectionView.backgroundColor = .systemGroupedBackground
                
                return cell
                
           
                
                
            }
        } else if indexPath.section == 4 {
            // First row in the fourth section
            if indexPath.row == 0 {
                
      
                cell.textfieldViewLabel.isEditable = false
                cell.collectionView.isHidden = false
                cell.textfieldViewLabel.text = "tag"
                cell.cellItems = tagDataArray
                cell.collectionView.reloadData()
                cell.backgroundColor = .systemGroupedBackground
                cell.collectionView.backgroundColor = .systemGroupedBackground
            }
        }else if indexPath.section == 5 {
            // First row in the fourth section
           
            if indexPath.row == 0 {
                cell.accessoryType = .none
                cell.toggleLocation.isHidden = false
                cell.toggleLocation.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
                cell.backgroundColor = .systemGroupedBackground
                
                
                //check if there is any data in the string:
                if locationString.isEmpty{
                    //if its empty we leave it on - do not use location
                    cell.toggleLocation.selectedSegmentIndex = 0
                }else{
                    //if its not empty we leave it on - use location
                    cell.toggleLocation.selectedSegmentIndex = 1
                }

  

            }else{
                cell.textfieldViewLabel.isEditable = false
                cell.textfieldViewLabel.isHidden = false
                cell.textfieldViewLabel.text = locationString
                cell.backgroundColor = .systemGroupedBackground
                
            }
        }
 
        return cell
    }

    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        
        switch indexPath.section{
            
            
        case 0:
            print("Title")
          
            switchKeySelection = switchKey[3]
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
               
                self.addTitle()
                
 
            })
            
        case 1:
            if indexPath.row == 0 {
                print("")
            }else{
                self.performSegue(withIdentifier: "editImage", sender: self)
            }
        
            
        case 2:
            print("Comment Selected")
       
            switchKeySelection = switchKey[0]
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                self.performSegue(withIdentifier: "addDescription", sender: self)
 
            })

          
        case 3:
            print("Risk Selected")
     
            switchKeySelection = switchKey[1]
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                self.performSegue(withIdentifier: "addDescription", sender: self)
 
            })
        case 4:
            print("Tag Selected")
     
            switchKeySelection = switchKey[2]
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                self.performSegue(withIdentifier: "addDescription", sender: self)
 
            })
            
       
        default :
            if indexPath.row == 1{
                print("Location Selected")
                
                switchKeySelection = switchKey[4]
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                    self.performSegue(withIdentifier: "location", sender: self)
                    
                })
                
                
            }else{
                
            }
       
        }
        
    }
 

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
             if let viewInfoView = segue.destination as? buildReportContentPage{
     
                 viewInfoView.siteID = siteID
                 viewInfoView.auditID = auditID
                 //viewInfoView.userUID = userUID
                 
             }else if let destination6 = segue.destination as? editImage {
                 
                 destination6.delegate = self
                 destination6.canvasData = canvasData
                 destination6.selectedImage = selectedImage
    
                
             }else if let destination3 = segue.destination as? addSiteDetails {
                 
                 destination3.delegate1 = self
                 destination3.delegate2 = self
                 destination3.delegate3 = self
                    
                 
                 destination3.switchKey = switchKeySelection
                                  
                 switch switchKeySelection {
                     
                     case "Comment":
                     destination3.stringData = siteDescription
                     destination3.value_DataArray = riskDataArray
                         
                     case "Risk":
                     destination3.stringData = siteDescription
                     destination3.value_DataArray = riskDataArray
                  
                         
                     case "Tag":
                     destination3.stringData = siteDescription
                     destination3.value_DataArray = tagDataArray
                        
                         
                     case "Location":
                     print("Location")
                         
                  
                         
                     default:
                         
                 break
                 }
       

            }else if let destination7 = segue.destination as? locationView {
                
                destination7.delegate = self
                
                destination7.lat = Float(lat)
                destination7.long = Float(long)
                destination7.locationLabel.text = locationString
   
               
            }
        
        
             else{
                 
             }
         }
    
}
