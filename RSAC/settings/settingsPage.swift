//
//  TableViewController.swift
//  dbtestswift
//
//  Created by macbook on 18/4/22.
//  Copyright © 2022 macbook. All rights reserved.
//


import UIKit
import MapKit
import CoreLocation
import Firebase
import FirebaseDatabase
import SDWebImage
import SwiftLoader

class cellSettings: UITableViewCell{
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
        
     
//        siteImage.frame = CGRect(
//            x: 10,
//            y: 10,
//            width: 60,
//            height: 60)
//        //60
//
//        settingsLabel.frame = CGRect(
//            x: 20, //siteImage.frame.maxX + 5,
//            y:  75/2 - 15,
//            width: frame.width - 20,
//            height: 30)
        //60
//        auditDescription.frame = CGRect(
//            x: siteImage.frame.maxX + 5,
//            y: settingsLabel.frame.maxY + 5,
//            width: frame.width - (siteImage.frame.maxX + 40),
//            height: 30 )
        
//        auditDate.frame = CGRect(
//            x: siteImage.frame.maxX + 5,
//            y: siteImage.frame.maxY - 20,
//            width: frame.width - (siteImage.frame.maxX + 5),
//            height: 20)
        


        //
        

        contentView.addSubview(siteImage)
        contentView.addSubview(settingsLabel)
        //contentView.addSubview(auditDate)
        contentView.addSubview(auditDescription)
       

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    


    
    let siteImage: UIImageView = {
        let profile = UIImageView()
        //profile.image = UIImage(systemName: "person.fill.badge.plus")
        profile.contentMode = .scaleAspectFit
        profile.layer.cornerRadius = 10
        profile.layer.masksToBounds = true
        profile.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        profile.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        //profile.layer.borderWidth = 0.5
   
        return profile
    }()

    let settingsLabel: UILabel = {
        let label = UILabel()
        label.text = "Loading.."
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.numberOfLines = 1
        label.textAlignment = .left
        //label.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    let auditDate: UILabel = {
        let label = UILabel()
        label.text = "Loading.."
        label.font = UIFont.systemFont(ofSize: 10)
        label.numberOfLines = 1
        label.textAlignment = .left
        //label.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        label.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        return label
    }()
    let auditDescription: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        //label.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        return label
    }()
}


class settingsPage: UITableViewController,UISearchBarDelegate,UIImagePickerControllerDelegate & UINavigationControllerDelegate,UIPickerViewDelegate {

    
    let mainConsole = CONSOLE()
    let mainFunction = extens()
    let firebaseConsole = saveLocal()
    var refData = String()
    var ListReferenceDataAdd = String()
    
    var auditID = String()
    var siteID = String()
    var listOfSitesData: [auditSiteData] = []
    var filterData: [auditSiteData] = []
    
    @IBOutlet var filterSearch: UISearchBar!
    @IBOutlet weak var segmentControlOutlet: UISegmentedControl!
    
    var titleData = String()
    var descriptionData = String()
    
    //storage for image
    let storageReference = Storage.storage().reference()
    var companyImageURL = String()
    var ThecurrentUser = Auth.auth().currentUser
    let picker = UIImagePickerController()
    
    var companyImage = Data()
    var companyName: String? = "Company"

    var toggle = Bool()
    
    
    
    //section and row data:
    var profileSection = 0
    var profileSectionRow = 3
    
    var reportSection = 1
    var reportSectionRow = 1
    
    var rateAppSection = 2
    var rateAppSectionRow = 1


    override func viewDidAppear(_ animated: Bool) {
        //filterData = listOfSitesData
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //load observation data:
        //loadSiteAuditData()
        
        //register cell
        tableView.register(cellSettings.self, forCellReuseIdentifier: "cellSettings")

        //declare picker
        picker.delegate = self
        
        
      
  
    }

//    @IBAction func indexChanged(_ sender: Any) {
//        switch segmentControlOutlet.selectedSegmentIndex {
//        case 0:
//            print("Working")
//            toggle = true
//
//            filterData = listOfSitesData.filter(
//                {return $0.status.description.localizedCaseInsensitiveContains("true") })
//
//            tableView.reloadData()
//
//
//        case 1:
//            print("Archive")
//            toggle = false
//
//
//            filterData = listOfSitesData.filter(
//                {return $0.status.description.localizedCaseInsensitiveContains("false") })
//
//            tableView.reloadData()
//
//        default:
//            break
//        }
//
//    }

  
    
    //get the list of users that applied. (3)
       func loadSiteAuditData(){
     
           //if Auth.auth().currentUser != nil {
  
               Database.database().reference(withPath:"\(refData)/\(mainConsole.auditList!)")
                   .observe(.value, with: { [self] snapshot in

                var listOfSitesData: [auditSiteData] = []
                for child in snapshot.children {

                if let snapshot = child as? DataSnapshot,
                   let List = auditSiteData(snapshot: snapshot) {
                    listOfSitesData.append(List)

                }
                }

                self.listOfSitesData = listOfSitesData
                filterData = self.listOfSitesData
                       
     
                       
                self.tableView.reloadData()
                  
               })

//               DispatchQueue.main.async {
//                   self.tableView.reloadData()
//
//               }
           
       }
    
    
//    override func tableView(_ tableView: UITableView,
//                   leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
//    {
//        let items = filterData[indexPath.row]
//
//        let item = UIContextualAction(style: .destructive, title: "Undo") { [self]  (contextualAction, view, boolValue) in
//            //Write your code in here
//            self.firebaseConsole.updateObservationStatus(status: "true", ref: items.ref)
//
//            tableView.reloadData()
//
//        }
//
//        item.backgroundColor = .purple
//        let swipeActions = UISwipeActionsConfiguration(actions: [item])
//        return swipeActions
//    }

//    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let items = filterData[indexPath.row]
//
//        let item = UIContextualAction(style: .destructive, title: "Delete") { (contextualAction, view, boolValue) in
//            //Write your code in here
//            //self.firebaseConsole.updateObservationStatus(status: "false", ref: items.ref)
//
//            let itemRef = Database.database().reference(withPath: "\(items.ref)")
//            itemRef.removeValue()
//
//
//
//        }
//
//        tableView.reloadData()
//        let swipeActions = UISwipeActionsConfiguration(actions: [item])
//        return swipeActions
//    }
//
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == profileSection {
            return "Profile Settings"
        } else if section == reportSection{
            return "Report Settings"
        }else{
            return "Rate AllRoads"
        }
    }
  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == profileSection{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellSettings", for: indexPath) as! cellSettings
            cell.accessoryType = .disclosureIndicator
            
            if indexPath.row == 0 {
                cell.siteImage.isHidden = true
                cell.auditDescription.isHidden = false
                cell.settingsLabel.text = "Company name"
                cell.auditDescription.text = companyName
                
                cell.settingsLabel.frame = CGRect(
                    x: 20,
                    y:  10,
                    width: cell.frame.width - 80,
                    height: 20)
                //60
                cell.auditDescription.frame = CGRect(
                    x: 20,
                    y: cell.settingsLabel.frame.maxY + 5,
                    width: cell.frame.width - 80,
                    height: 20 )
                
                
            }else  if indexPath.row == 1{
                cell.auditDescription.isHidden = true
                cell.siteImage.isHidden = false
                cell.settingsLabel.text = "Company Logo"
                
                cell.siteImage.image = UIImage(data: companyImage)
                
                cell.siteImage.frame = CGRect(
                    x: cell.frame.width - 80,
                    y:cell.frame.height/2 - 20,
                    width: 40,
                    height: 40)
                
                cell.settingsLabel.frame = CGRect(
                    x: 20, //siteImage.frame.maxX + 5,
                    y:  cell.frame.height/2 - 15,
                    width: cell.frame.width - 80,
                    height: 30)
                
                
            }else{
                cell.siteImage.isHidden = false
                cell.auditDescription.isHidden = true
                cell.settingsLabel.text = "Signature"
                
                cell.settingsLabel.frame = CGRect(
                    x: 20,
                    y:  10,
                    width: cell.frame.width - 80,
                    height: 20)
                
                cell.siteImage.frame = CGRect(
                    x: 20,
                    y:cell.settingsLabel.frame.maxY + 10,
                    width: cell.frame.width - 80,
                    height: 90)
                
                
             
            }
            
            return cell
        }else if indexPath.section == reportSection{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellSettings", for: indexPath) as! cellSettings
            cell.accessoryType = .disclosureIndicator
            

            cell.settingsLabel.text = "Report Configuration"
            cell.siteImage.isHidden = true
            cell.auditDescription.isHidden = true

            cell.settingsLabel.frame = CGRect(
                x: 20, //siteImage.frame.maxX + 5,
                y:  cell.frame.height/2 - 15,
                width: cell.frame.width - 80,
                height: 30)
            
            
            
            
            return cell
            
        }else{
            
            //rateAppSection
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellSettings", for: indexPath) as! cellSettings
            cell.accessoryType = .disclosureIndicator
            
            cell.settingsLabel.text = "Rate!"
            cell.siteImage.isHidden = true
            cell.auditDescription.isHidden = true
            
            return cell
            
        }
       
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        switch section {
            case profileSection:
            return profileSectionRow
            
            case reportSection:
            return reportSectionRow

            default: // rateAppSection
            return 1
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == profileSection{
            if indexPath.row == 0{
                
            }else if indexPath.row == 1{
                
            }else{
                return 150
            }
        }
        
        
        return 75
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == profileSection{
            if indexPath.row == 0{
                //change Company name
                uploadCompanyName()
                
            }else if indexPath.row == 1{
                
                // open image picker
                uploadImageAlert()
                
            }else{
                
            }
        }
    }
    
    
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     if let destination4 = segue.destination as? addAuditSites {
          destination4.siteID = siteID
          destination4.auditID = auditID

        
     }else if let destination5 = segue.destination as? viewPDF {
         destination5.refData = refData

      }
      

      else {
          
      }

          
          
    }
    
    
    //SAVE user configuration settings here:
    
    func updateName(companyName:String, ref:String){
        
        SwiftLoader.show(title: "Updating", animated: true)
        let reftest = Database.database().reference(withPath:ref)
        
        
        reftest.updateChildValues([
            "companyName": companyName,
        ]){
            (error:Error?, ref:DatabaseReference) in
            if let error = error {
                print("\(companyName) could not update: \(error).")
                SwiftLoader.hide()
                self.mainFunction.errorUpload(errorMessage: "Data could not be saved",subtitle: "\(error)")
            } else {
                print("\(companyName) updated")
                self.mainFunction.successUpload(Message: "Updated", subtitle: "")
                SwiftLoader.hide()

            }
        }
    }
    
    
    func updateCompanyImage(imageData:Data, ref:String){
        //activity indicator
        SwiftLoader.show(title: "Uploading Image", animated: true)
    

        // constantly override the image
        let companyImageRef = storageReference
            .child("\(self.mainConsole.prod!)")
            .child("\(self.mainConsole.post!)")
            .child(ThecurrentUser!.uid)
            //.child("\(self.mainConsole.audit!)")
            .child("\(mainConsole.userDetails!)")
            .child("\(mainConsole.settingsConfig!)")
            .child("companyProfile.jpg")

    
        let uploadMetaData = StorageMetadata()
        uploadMetaData.contentType = "image/jpeg"
        
        //Save image in the refecence directory above
        companyImageRef.putData(imageData as Data, metadata: uploadMetaData) { (uploadedImageMeta, error) in
            
            if error != nil
            {
                SwiftLoader.hide()
                //Could not upload data
                self.mainFunction.errorUpload(errorMessage: "Could no upload Company Picture",subtitle: "\(String(describing: error?.localizedDescription))")
                
                return
                
            } else {
                
              
                companyImageRef.downloadURL { [self] url, error in
                    if error != nil {

                        
                    }else{

                
                        companyImageURL = "\(url!)"
                   
                        let reftest = Database.database().reference(withPath:ref)
                        
                        reftest.updateChildValues([
                            "imageURL": companyImageURL,
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

                            }
                        }

        
                        
                        
                    }
                }
            }
            
            
        }
    }
    
    
    
    
    
    
    //alert view for compnay name change
    func uploadCompanyName() {
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Company name", message: "", preferredStyle: .alert)

        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.text = ""

        }

        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            //self.navigationItem.title = textField!.text
            self.companyName = textField!.text!
            self.tableView.reloadData()
       

            if textField!.text! == ""{

                let Alert = UIAlertController(title: "Whoops!⚠️", message: "Textfield was empty", preferredStyle: .alert)
                    let action1 = UIAlertAction(title: "Okay",style: .cancel) { (action:UIAlertAction!) in
                        self.navigationController?.popViewController(animated: true)

                    }

                Alert.addAction(action1)
                self.present(Alert, animated: true, completion: nil)

                }else{

                    // SAVE Data function here
  

                }


        }))

        let action1 = UIAlertAction(title: "Cancel",style: .cancel) { (action:UIAlertAction!) in

        self.navigationController?.popViewController(animated: true)
        }

        alert.addAction(action1)
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    
    
    
    
    
    
    
    
    //alert view for image content
    func uploadImageAlert() {
        let alertController = UIAlertController(title: "Company Logo", message: "", preferredStyle: .alert)
        let imageView = UIImageView(frame: CGRect(x: alertController.view.frame.maxX/2 - 160, y: 50, width: 200, height: 200))
        imageView.image = UIImage(data: companyImage) // Your image here...
        imageView.layer.cornerRadius = 40
        imageView.layer.masksToBounds = true
        alertController.view.addSubview(imageView)
        let height = NSLayoutConstraint(item: alertController.view!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 320)
        let width = NSLayoutConstraint(item: alertController.view!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 250)
        alertController.view.addConstraint(height)
        alertController.view.addConstraint(width)

 
        
        
        let action1 = UIAlertAction(title: "Change",style: .default) { (action:UIAlertAction!) in
            // Perform action
            
            //open camera
            self.picker.allowsEditing = true
            self.picker.sourceType = .photoLibrary
            self.present(self.picker, animated: true, completion: nil)
            
            
            
            //
        }

        let action3 = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in
            print("Cancel button tapped");
        }
        alertController.addAction(action1)
        //alertController.addAction(action2)
        alertController.addAction(action3)
        
        alertController.view.addSubview(imageView)
        // change the background color
        
        self.present(alertController, animated: true, completion: nil)
        
        
    }
    
    
    
       func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
           // Local variable inserted by Swift 4.2 migrator.
           let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
   
   
           //We allow the user to pick an image, which they can edit.
           if let profileImage = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.editedImage)] as? UIImage,
   
                let optimizedImageData = profileImage.jpegData(compressionQuality: 0.1)// image quality.
                               {
                                   // assign user image to uiimageview
                                   //save the image as object
                                   companyImage = optimizedImageData
                                   tableView.reloadData()
                       
   
                               }
   
                                picker.dismiss(animated: true, completion:nil)
   
                   }
   
       // Helper function inserted by Swift 4.2 migrator.
       fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
           return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
       }
   
       // Helper function inserted by Swift 4.2 migrator.
       fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
           return input.rawValue
       }
       func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
           dismiss(animated: true, completion: nil)
       }
    
    
    
    
    
    
    
    
    
    

}
