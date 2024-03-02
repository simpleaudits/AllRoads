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

class collabData: UITableViewCell{


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)


        siteName.frame = CGRect(
            x: 20,
            y: 5,
            width: frame.width,
            height: 30)


        auditDate.frame = CGRect(
            x: siteName.frame.minX ,
            y: siteName.frame.maxY + 5,
            width: frame.width ,
            height: 30 )




        //



        contentView.addSubview(siteName)
        contentView.addSubview(auditDate)




    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    let siteName: UILabel = {
        let label = UILabel()
        label.text = "Loading.."
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 1
        label.textAlignment = .left
//label.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()

    let auditDate: UILabel = {
        let label = UILabel()
        label.text = "Loading.."
        label.font = UIFont.systemFont(ofSize: 10)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        return label
    }()

}


class collaborationView: UITableViewController,UISearchBarDelegate {


    let mainConsole = CONSOLE()
    let mainFunction = extens()
    let firebaseConsole = saveLocal()
    var refData = String()
    var ListReferenceDataAdd = String()



    var listingData = Int()
    var auditID = String()
    var siteID = String()
    var listOfCollaborationData: [collaborationData] = []
    var filterData: [collaborationData] = []

    @IBOutlet var filterSearch: UISearchBar!
    @IBOutlet weak var statusSegment: UISegmentedControl!

    var titleData = String()
    var descriptionData = String()
    var sharedRef = String()
    var projectName = String()
    var collaborationID = String()
    var itemReference = String()
    
    var toggle = Bool()



    override func viewDidAppear(_ animated: Bool) {
        //filterData = listOfObservationData
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //load joined collab list:
        self.loadCollabData()
        
        //load the number of listing the user can actually make here:
        //loadFirebaseData()

        //load observation data:
        //loadSiteAuditData()

        //register cell
        tableView.register(collabData.self, forCellReuseIdentifier: "collabData")

        //conform to search bar delegate
        filterSearch?.delegate = self
        filterSearch.placeholder = "Search by project name"



    }




    //Search bar function
    @objc func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        // if the user does not search, the table does not update.
        if searchText == "" {
            filterData.removeAll()
            filterData = listOfCollaborationData


            tableView.reloadData()

        }
        //if the user decides to type, we update the table accordingly.
        else{
            filterData = listOfCollaborationData.filter(
                {return $0.projectName.localizedCaseInsensitiveContains(searchText) })


            //tableView.reloadData()
        }


    }
    @objc func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        filterSearch.endEditing(true)
        tableView.reloadData()
    }
    
  
    
    
//Load API Data---------------------------------------------------------------------------------------------------------------------[START]
    func loadCollabAPI(collaborationID:String){

                 let uid = Auth.auth().currentUser?.uid
                 let reftest = Database.database().reference()
                     .child("\(mainConsole.prod!)")
                     .child("\(mainConsole.collaborationList!)")
                     .child(collaborationID)
                 
                 reftest.queryOrderedByKey()
                     .observe( .value, with: { snapshot in
                               guard let dict = snapshot.value as? [String:Any] else {
                               //error here
                               print("could not load")
                                   
                                   let Alert = UIAlertController(title: "CollabID was not valid", message: "", preferredStyle: .alert)
                                       let action1 = UIAlertAction(title: "Okay",style: .cancel) { (action:UIAlertAction!) in
                                      
                                       }

                                   Alert.addAction(action1)
                                   self.present(Alert, animated: true, completion: nil)
                                   
                               return
                               }

                                let sharedRef = dict["sharedRef"] as? String
                                let projectName = dict["projectName"] as? String
                                let collaborationID = dict["collaborationID"] as? String
                                let auditID = dict["auditID"] as? String
                         
                                    self.sharedRef = sharedRef!
                                    self.projectName = projectName!
                                    self.collaborationID = collaborationID!
                                    self.auditID = auditID!
    
                                     let alertController = UIAlertController(title: "Join this Project?", message: "", preferredStyle: .alert)
                                     let action2 = UIAlertAction(title: "Yes",style: .default) { (action:UIAlertAction!) in
                                         // Perform action
                    
                                             self.firebaseConsole.addCollab(auditImageURL: "",
                                                                            date: self.mainFunction.timeStamp(),
                                                                            projectName: self.projectName,
                                                                            sharedRef: self.sharedRef,
                                                                            siteID: self.siteID,
                                                                            auditID: self.auditID,
                                                                            isEditable: true,
                                                                            collaborationID: self.collaborationID)
   
                                     }
                           
                                     let action1 = UIAlertAction(title: "Not now", style: .cancel) { (action:UIAlertAction!) in
                                         print("Cancel button tapped");
                                   
                                         
                                     }
                                     alertController.addAction(action1)
                                     alertController.addAction(action2)

                                     self.present(alertController, animated: true, completion: nil)
  
  
                   })
        
     
    }

    
//Load my collab Data---------------------------------------------------------------------------------------------------------------------[END]
    
    func loadCollabData(){


        SwiftLoader.show(title: "Loading Data", animated: true)
        let uid = Auth.auth().currentUser?.uid

        let reftest = Database.database().reference().child("\(self.mainConsole.prod!)")
        let thisUsersGamesRef = reftest
            .child("\(self.mainConsole.post!)")
            .child(uid!)
            .child("\(self.mainConsole.collaborationList!)")
           
        
              
        thisUsersGamesRef.observe(.value, with: { [self] snapshot in

                var listOfCollaborationData: [collaborationData] = []
                for child in snapshot.children {

                if let snapshot = child as? DataSnapshot,
                   let List = collaborationData(snapshot: snapshot) {
                    listOfCollaborationData.append(List)

                }
                }

                self.listOfCollaborationData = listOfCollaborationData
                filterData = self.listOfCollaborationData

                self.tableView.reloadData()
            
                SwiftLoader.hide()

        })

       }






//Load Data from Firebase, get max listing---------------------------------------------------------------------------------------------------------------------[START]
    func loadFirebaseData(){

        let mainConsole = CONSOLE()

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

                                let listingMax = dict["listingMax"] as? Int
                                self.listingData = listingMax!
                               })

    }


    @IBAction func addCollabUser(_ sender: Any) {

        //Ask user for site name:
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Please Add The CollabID below:", message: "This is a unique ID that is shared by project sponsor.", preferredStyle: .alert)

        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.text = ""

        }

        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "Join", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.

            self.collaborationID = textField!.text!


            if textField!.text! == ""{

                let Alert = UIAlertController(title: "Whoops!⚠️", message: "CollabID was empty", preferredStyle: .alert)
                    let action1 = UIAlertAction(title: "Okay",style: .cancel) { (action:UIAlertAction!) in
                   
                    }

                Alert.addAction(action1)
                self.present(Alert, animated: true, completion: nil)

                }else{

                    
                    //If we get a non empty string, we want to save reference to the audit we are joining here:
                    self.loadCollabAPI(collaborationID: self.collaborationID)
                    
                

                }


        }))

        let action1 = UIAlertAction(title: "Back",style: .cancel) { (action:UIAlertAction!) in

            self.navigationController?.popViewController(animated: true)
        }

        alert.addAction(action1)
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }

//Load Data from Firebase, get max listing---------------------------------------------------------------------------------------------------------------------[END]









    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let items = filterData[indexPath.row]

        let item = UIContextualAction(style: .destructive, title: "Delete") { (contextualAction, view, boolValue) in
            //Write your code in here
            //self.firebaseConsole.updateObservationStatus(status: "false", ref: items.ref)





        }

        tableView.reloadData()
        let swipeActions = UISwipeActionsConfiguration(actions: [item])
        return swipeActions
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "collabData", for: indexPath) as! collabData


        let items = filterData[indexPath.row]
        cell.siteName.text = items.projectName
        cell.auditDate.text = "Joined: \(items.date)"
      
//        let transforImageSize = SDImageResizingTransformer(size: CGSize(width: 150, height: 150), scaleMode: .fill)
//        cell.siteImage.sd_setImage(with: URL(string:items.auditImageURL), placeholderImage: nil, context: [.imageTransformer:transforImageSize])

        cell.accessoryType = .disclosureIndicator



        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows

        return filterData.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 70
    }


    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
   
        let items = filterData[indexPath.row]

        itemReference = items.sharedRef
        self.auditID = items.auditID
        self.projectName = items.projectName

        self.performSegue(withIdentifier: "fromCollaboration", sender: indexPath.row);
 

    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
        if let viewInfoView = segue.destination as?  viewAuditList{

            if auditID != ""{
                viewInfoView.auditID = auditID
                viewInfoView.projectName  = projectName
            }else{
                
            }

        }
        
   }

    

}
