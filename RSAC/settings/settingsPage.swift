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


            contentView.addSubview(subscriptionLabelHeader)
            contentView.addSubview(subscriptionLabel)
            contentView.addSubview(numberOfUsesLeft)
            contentView.addSubview(upgradeAccount)
                
            contentView.addSubview(siteImage)
            contentView.addSubview(settingsLabel)
            //contentView.addSubview(auditDate)
            contentView.addSubview(auditDescription)



            }

            required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
            }


//user status and subscriptions attributes:
            let subscriptionLabelHeader: UILabel = {
            let label = UILabel()
            label.text = ""
            label.font = UIFont.boldSystemFont(ofSize: 15)
            label.numberOfLines = 1
            label.textAlignment = .left
            //label.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
            label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            return label
            }()
    
            let subscriptionLabel: UILabel = {
            let label = UILabel()
            label.text = "Subscribed"
            label.font = UIFont.boldSystemFont(ofSize: 15)
            label.numberOfLines = 1
            label.textAlignment = .center
            label.layer.cornerRadius = 10
            label.layer.masksToBounds = true
            label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            return label
            }()
    
            let numberOfUsesLeft: UILabel = {
            let label = UILabel()
            label.text = ""
            label.font = UIFont.systemFont(ofSize: 22)
            label.numberOfLines = 3
            label.textAlignment = .left
            //label.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
            label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            return label
            }()
    
    
            let upgradeAccount:UIButton = {
               let button = UIButton()
                button.setTitle("Upgrade", for: .normal)
          
                button.setTitleColor(.white, for: .normal)
                button.backgroundColor = #colorLiteral(red: 0.1218188778, green: 0.5034164786, blue: 0.9990965724, alpha: 1)
                button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)

                //button.layer.borderWidth = 1
                button.layer.masksToBounds = true
                button.layer.cornerRadius = 8
                return button
                
            }()
            
    



    
    
    
    
            let siteImage: UIImageView = {
            let profile = UIImageView()
            profile.contentMode = .scaleAspectFit
            profile.layer.cornerRadius = 10
            profile.layer.masksToBounds = true
            //profile.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            profile.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
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
            label.numberOfLines = 3
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
            var userData: [userDetails] = []
            var companyNameData: String? = "Loading.."
            var companyDPData: String? = "Loading.."
            var companySigData: String? = "Loading.."
                


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


            var toggle = Bool()


    
    
    
            var listingCount = Int()
            var userStatus = String()

            //section and row data:
    
    
    
            var profileSection = 0
            var profileSectionRow = 4

            var reportSection = 1
            var reportSectionRow = 1

            var rateAppSection = 2
            var rateAppSectionRow = 1
    
            var TCsection = 3
            var TCsectionSectionRow = 1


            override func viewDidAppear(_ animated: Bool) {

            }

            override func viewDidLoad() {
            super.viewDidLoad()
      
            //load user data:
            loadUserSettingsData(ref: "\(self.mainConsole.prod!)/\(self.mainConsole.post!)/\(ThecurrentUser!.uid)")

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
            func loadUserSettingsData(ref:String){

            //if Auth.auth().currentUser != nil {

                Database.database().reference(withPath:ref)
                .observe(.value, with: { [self] snapshot in

                var userData: [userDetails] = []
                for child in snapshot.children {

                if let snapshot = child as? DataSnapshot,
                let List = userDetails(snapshot: snapshot) {
                    userData.append(List)
                    
                    
                    companyNameData = "Company name: \(List.companyName)\nUsername: \(List.userName)\nUID:\(ThecurrentUser!.uid)"
                    companyDPData = List.DPimage
                    companySigData = List.signatureURL
                    listingCount = List.listingMax
                    userStatus = List.userStatus
                    
                    
                    print(userData)

                }
                }

                self.userData = userData
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

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
           // Return different heights based on section index, or a fixed height
           switch section {
           case profileSection:
               return 50
           case reportSection:
               return 50
           case TCsection:
               return 50
           default:
               return 50 // Default height
           }
       }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        //headerView.backgroundColor = .lightGray // Set background color if needed
        
        let headerLabel = UILabel()
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.font = UIFont.boldSystemFont(ofSize: 20) // Customize font here
        headerLabel.textColor = .black // Customize text color if needed
        headerLabel.numberOfLines = 3
        
        switch section{
        case profileSection:
            headerLabel.text =  "Profile Settings"
        case reportSection:
            headerLabel.text =  "Report Settings"
        case TCsection:
            headerLabel.text =  "T&C"
        default:
            headerLabel.text =  "Rate AllRoads"
       
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
    

            override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

                if indexPath.section == profileSection{
                let cell = tableView.dequeueReusableCell(withIdentifier: "cellSettings", for: indexPath) as! cellSettings
                cell.accessoryType = .disclosureIndicator
                cell.selectionStyle = .none
                

                
                    if indexPath.row == 0 {
                        
                       
//                        cell.auditDescription.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//                        cell.numberOfUsesLeft.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//                        cell.subscriptionLabelHeader.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                        
                        cell.accessoryType = .none
                        cell.siteImage.isHidden = true
                        cell.settingsLabel.isHidden = true
                        cell.auditDescription.isHidden = true
                        cell.subscriptionLabel.isHidden = false
                        cell.numberOfUsesLeft.isHidden = false
                        cell.upgradeAccount.isHidden = false
                        cell.subscriptionLabelHeader.isHidden = false
                        cell.subscriptionLabelHeader.text = "Status:"
                    
                        
          
                        
                        cell.subscriptionLabelHeader.frame = CGRect(
                        x: 20,
                        y:  10,
                        width: cell.frame.width - 80,
                        height: 20)

                        
                        
                        if self.userStatus != mainConsole.userStatus{
                            cell.subscriptionLabel.text = "NotSubscribed"//"\(self.userStatus)"
                            cell.numberOfUsesLeft.text = "Project Limit: \(self.listingCount)\nSite Limit: \(self.listingCount*2)\nObservation Limit: \(self.listingCount*3)"
                            cell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                            
                            cell.subscriptionLabel.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
                            
                            cell.subscriptionLabel.frame = CGRect(
                            x: 20,
                            y:  cell.subscriptionLabelHeader.frame.maxY + 5,
                            width: cell.subscriptionLabel.intrinsicContentSize.width + 10,
                            height: 20)
                        }else{
                            
                            cell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                            cell.subscriptionLabel.text = "Subscribed"//"\(self.userStatus)"
                            cell.numberOfUsesLeft.text = "Project Limit: ∞\nSite Limit: ∞\nObservation Limit: ∞"

                            
                            cell.subscriptionLabel.backgroundColor = #colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0.3490196078, alpha: 1)
                            
                            cell.subscriptionLabel.frame = CGRect(
                            x: 20,
                            y:  cell.subscriptionLabelHeader.frame.maxY + 5,
                            width: cell.subscriptionLabel.intrinsicContentSize.width + 10,
                            height: 20)
                        }
                        
                
                        //60
                        cell.numberOfUsesLeft.frame = CGRect(
                        x: 20,
                        y: cell.subscriptionLabel.frame.maxY + 5,
                        width: cell.frame.width - 80,
                        height: 90 )
                        
                        cell.upgradeAccount.frame = CGRect(
                        x: 20,
                        y: cell.numberOfUsesLeft.frame.maxY + 10,
                        width: cell.frame.width - 80,
                        height: 30 )


       
                        

                    }else if indexPath.row == 1 {
                    
                    cell.siteImage.isHidden = true
                    cell.auditDescription.isHidden = false
                    cell.subscriptionLabel.isHidden = true
                    cell.numberOfUsesLeft.isHidden = true
                    cell.upgradeAccount.isHidden = true
                    cell.subscriptionLabelHeader.isHidden = true
                    cell.settingsLabel.isHidden = false
                        
                    cell.settingsLabel.text = "About You"
                    cell.auditDescription.text = "\(companyNameData!)"
                    


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
                    height: 80 )


                }else  if indexPath.row == 2{
                    
                    cell.auditDescription.isHidden = true
                    cell.siteImage.isHidden = false
                    cell.subscriptionLabel.isHidden = true
                    cell.numberOfUsesLeft.isHidden = true
                    cell.upgradeAccount.isHidden = true
                    cell.subscriptionLabelHeader.isHidden = true
                    cell.settingsLabel.isHidden = false
                    
                    cell.settingsLabel.text = "Company Logo"

                    //cell.siteImage.image = UIImage(data: companyImage)
                    
                    let transforImageSize = SDImageResizingTransformer(size: CGSize(width: 500, height: 500), scaleMode: .fill)
                    cell.siteImage.sd_setImage(with: URL(string:companyDPData!), placeholderImage: nil, context: [.imageTransformer:transforImageSize])
                    

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
                    cell.subscriptionLabel.isHidden = true
                    cell.numberOfUsesLeft.isHidden = true
                    cell.upgradeAccount.isHidden = true
                    cell.subscriptionLabelHeader.isHidden = true
                    cell.settingsLabel.isHidden = false
                    cell.settingsLabel.text = "Signature"
                    
                  
                    cell.siteImage.sd_setImage(with: URL(string:companySigData!), placeholderImage: nil)

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
                    cell.selectionStyle = .none

                    cell.settingsLabel.isHidden = false
                    cell.settingsLabel.text = "Report Configuration"
                    cell.siteImage.isHidden = true
                    cell.auditDescription.isHidden = true
                    cell.subscriptionLabel.isHidden = true
                    cell.numberOfUsesLeft.isHidden = true
                    cell.upgradeAccount.isHidden = true
                    cell.subscriptionLabelHeader.isHidden = true
                    

                    cell.settingsLabel.frame = CGRect(
                    x: 20, //siteImage.frame.maxX + 5,
                    y:  cell.frame.height/2 - 15,
                    width: cell.frame.width - 80,
                    height: 30)

                    return cell

                }else if indexPath.section == TCsection{
   
                    let cell = tableView.dequeueReusableCell(withIdentifier: "cellSettings", for: indexPath) as! cellSettings
                    cell.accessoryType = .disclosureIndicator
                    cell.selectionStyle = .none
                    
                    cell.siteImage.isHidden = true
                    cell.auditDescription.isHidden = false
                    cell.subscriptionLabel.isHidden = true
                    cell.numberOfUsesLeft.isHidden = true
                    cell.upgradeAccount.isHidden = true
                    cell.subscriptionLabelHeader.isHidden = true
                    cell.settingsLabel.isHidden = false
                        
                    cell.settingsLabel.text = "Terms of Service"
                    cell.auditDescription.text = "Last changed 20/4/2024"
                    


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
                    
                    return cell

                }else{

                //rateAppSection
                let cell = tableView.dequeueReusableCell(withIdentifier: "cellSettings", for: indexPath) as! cellSettings
                cell.accessoryType = .disclosureIndicator
                cell.selectionStyle = .none

                cell.settingsLabel.text = "Rate App"
                    
                    
                cell.settingsLabel.isHidden = false
                cell.siteImage.isHidden = true
                cell.auditDescription.isHidden = true
                cell.subscriptionLabel.isHidden = true
                cell.numberOfUsesLeft.isHidden = true
                cell.upgradeAccount.isHidden = true
                cell.subscriptionLabelHeader.isHidden = true
                    
                cell.settingsLabel.frame = CGRect(
                x: 20, //siteImage.frame.maxX + 5,
                y:  cell.frame.height/2 - 15,
                width: cell.frame.width - 80,
                height: 30)

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
                    
                case TCsection:
                    return TCsectionSectionRow

                default: // rateAppSection
                    return 1
                }
            }

                override func numberOfSections(in tableView: UITableView) -> Int {
                    return 4
                }

                override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                if indexPath.section == profileSection{
                    
                    if indexPath.row == 0{
                        
                    return 210

                    }else if indexPath.row == 1{
                    
                    return 120

                    }else if indexPath.row == 2{

                    }else{
                        
                    return 150
                        
                    }
                    
                }
                //default all cell height sizes are 75
                return 75
            }

            override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
                
                
            if indexPath.section == profileSection{
                if indexPath.row == 0{
   

                }else if indexPath.row == 1{
                //change Company name
                uploadCompanyName()

                }else if indexPath.row == 2{

                // open image picker
                uploadImageAlert()

                }else{
                    
                //open the signatureview
                presentModal()

                }
            }else  if indexPath.section == reportSection{
                if indexPath.row == 0{
   
                    self.performSegue(withIdentifier: "reportConfig", sender: self)
                }
            }
            }

// present the signature viewcontroller  --------------------------------------------------------------------------------------------------------------------[START]
                
            func presentModal() {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                
                if let viewController = storyboard.instantiateViewController(withIdentifier: "signatureViewController") as? signatureViewController{

                    if let presentationController = viewController.presentationController as? UISheetPresentationController {
                        presentationController.detents = [.medium()] /// change to [.medium(), .large()] for a half *and* full screen sheet
                        //presentationController.prefersGrabberVisible = true
                        presentationController.preferredCornerRadius = 45
                        presentationController.presentingViewController.navigationItem.title = "Signature"
                        //presentationController.largestUndimmedDetentIdentifier = .medium
                    }

                self.present(viewController, animated: true)
                }

               //self.performSegue(withIdentifier: "signatureViewController", sender: self)


            }


// present the signature viewcontroller  --------------------------------------------------------------------------------------------------------------------[END]
    
 
    

// Change user display picture  --------------------------------------------------------------------------------------------------------------------[START]
           
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
            .child("\(mainConsole.profileImage!)")
            .child("\(ThecurrentUser!.uid)-\(mainConsole.profileImage!).jpg")



            let uploadMetaData = StorageMetadata()
            uploadMetaData.contentType = "image/jpeg"

            //1) updating storage level data - data
            companyImageRef.putData(imageData as Data, metadata: uploadMetaData) { (uploadedImageMeta, error) in

            if error != nil{
                SwiftLoader.hide()
                //Could not upload data
                self.mainFunction.errorUpload(errorMessage: "Could no upload Company Picture",subtitle: "\(String(describing: error?.localizedDescription))")
                return

            }else {

            companyImageRef.downloadURL { [self] url, error in
            if error != nil {

            // handle error here
                
            }else{
            //no error, go ahead and save
                
            //2) updating reference url in data to display image via url
                
                companyImageURL = "\(url!)"
                let reftest = Database.database().reference(withPath:ref)

                reftest.updateChildValues([
                "DPimage": companyImageURL,
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


// Change user display picture  --------------------------------------------------------------------------------------------------------------------[END]
                
                
// Change user company name --------------------------------------------------------------------------------------------------------------------[START]

            func uploadCompanyName() {
                //1. Create the alert controller.
                let alert = UIAlertController(title: "Company name", message: "", preferredStyle: .alert)

                //2. Add the text field. You can configure it however you need.
                alert.addTextField { (textField) in
                textField.text = ""

                }
                // 3. Grab the value from the text field, and print it when the user clicks OK.
                alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { [self, weak alert] (_) in
                let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
                //self.navigationItem.title = textField!.text

                if textField!.text! == ""{
                    let Alert = UIAlertController(title: "Whoops!⚠️", message: "Textfield was empty", preferredStyle: .alert)
                    let action1 = UIAlertAction(title: "Okay",style: .cancel)
                    { (action:UIAlertAction!) in
                    self.navigationController?.popViewController(animated: true)

                    }
                    
                Alert.addAction(action1)
                self.present(Alert, animated: true, completion: nil)

                }else{
                            //change user compnay name here, using ref:
                            self.updateName(companyName: "\(textField!.text!)", ref: "\(self.mainConsole.prod!)/\(self.mainConsole.post!)/\(ThecurrentUser!.uid)/\(self.mainConsole.userDetails!)")
                          
                }

                }))

                let action1 = UIAlertAction(title: "Cancel",style: .cancel)
                { (action:UIAlertAction!) in
                    //self.navigationController?.popViewController(animated: true) // returns view
                }

                alert.addAction(action1)
                // 4. Present the alert.
                self.present(alert, animated: true, completion: nil)

            }
                
            //SAVE user configuration settings here:

            func updateName(companyName:String, ref:String){

            SwiftLoader.show(title: "Updating", animated: true)
            let reftest = Database.database().reference(withPath:ref)


            reftest.updateChildValues([
            "companyName": companyName
            ]){
                
                
            (error:Error?, ref:DatabaseReference) in
                if let error = error {
                    print("\(companyName) could not update: \(error).")
                    SwiftLoader.hide()
                    self.mainFunction.errorUpload(errorMessage: "Data could not be saved",subtitle: "\(error)")
                    
                }else {
                    print("\(companyName) updated")
                    self.mainFunction.successUpload(Message: "Updated", subtitle: "")
                    SwiftLoader.hide()

                }
                
            }
            }


// Change user company name --------------------------------------------------------------------------------------------------------------------[END]
                
                
                
                
                
                

// Change user DP ALERT --------------------------------------------------------------------------------------------------------------------[START]
            func uploadImageAlert() {
                
                //PREVIEW THE CURRENT IMAGE WITHIN ALERT
                let alertController = UIAlertController(title: "Company Logo", message: "", preferredStyle: .alert)
                let imageView = UIImageView(frame: CGRect(x: alertController.view.frame.maxX/2 - 160, y: 50, width: 200, height: 200))
                let transforImageSize = SDImageResizingTransformer(size: CGSize(width: 500, height: 500), scaleMode: .fill)
                imageView.sd_setImage(with: URL(string:companyDPData!), placeholderImage: nil, context: [.imageTransformer:transforImageSize])
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
                alertController.addAction(action3)
                alertController.view.addSubview(imageView)


                self.present(alertController, animated: true, completion: nil)


                }

// Change user DP ALERT --------------------------------------------------------------------------------------------------------------------[END]
                
                
                
// Image Picker Delegate --------------------------------------------------------------------------------------------------------------------
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
                


                }
                //dismiss the current view
                picker.dismiss(animated: true, completion:nil)

                //save and update new image
                self.updateCompanyImage(imageData: companyImage, ref: "\(self.mainConsole.prod!)/\(self.mainConsole.post!)/\(ThecurrentUser!.uid)/\(self.mainConsole.userDetails!)")
                
                
                }
                
                

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
// Image Picker Delegate --------------------------------------------------------------------------------------------------------------------



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

    
    
    

}
