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

class cellData: UITableViewCell{
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
        
     
        siteImage.frame = CGRect(
            x: 10,
            y: 10,
            width: 100,
            height: 100)
        //60
        
        siteName.frame = CGRect(
            x: siteImage.frame.maxX + 5,
            y:  5,
            width: frame.width - (siteImage.frame.maxX + 20),
            height: 30)
        //60
        auditDescription.frame = CGRect(
            x: siteImage.frame.maxX + 5,
            y: siteName.frame.maxY + 5,
            width: frame.width - (siteImage.frame.maxX + 40),
            height: 40 )
        
        auditDate.frame = CGRect(
            x: siteImage.frame.maxX + 5,
            y: siteImage.frame.maxY - 20,
            width: frame.width - (siteImage.frame.maxX + 5),
            height: 20)
        


        //
        

        contentView.addSubview(siteImage)
        contentView.addSubview(siteName)
        contentView.addSubview(auditDate)
        contentView.addSubview(auditDescription)
       

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    


    
    let siteImage: UIImageView = {
        let profile = UIImageView()
        //profile.image = UIImage(named: "frozen")
        profile.contentMode = .scaleAspectFill
        profile.layer.cornerRadius = 10
        profile.layer.masksToBounds = true
        //profile.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        //
        //profile.layer.borderWidth = 0.5
   
        return profile
    }()

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
    let auditDescription: UILabel = {
        let label = UILabel()
        label.text = "Loading.."
        label.font = UIFont.systemFont(ofSize: 10)
        label.numberOfLines = 3
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        //label.backgroundColor = .red
        return label
    }()
}


class Observation: UITableViewController,UISearchBarDelegate {

    
    let mainConsole = CONSOLE()
    let mainFunction = extens()
    let firebaseConsole = saveLocal()
    var refData = String()
    var ListReferenceDataAdd = String()
    
    
    var userUID = String()
    var listingData = Int()
    var auditID = String()
    var siteID = String()
    var listOfObservationData: [auditSiteData] = []

    
    var filterData: [auditSiteData] = []
    
    @IBOutlet var filterSearch: UISearchBar!
    @IBOutlet weak var statusSegment: UISegmentedControl!
    
    var titleData = String()
    var descriptionData = String()
    


    var toggle = Bool()
    
    


    override func viewDidAppear(_ animated: Bool) {
        //filterData = listOfObservationData
        



    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       

        
        //load the number of listing the user can actually make here:
        loadUserStats()
        
        //load observation data:
        loadSiteAuditData()
        
        //register cell
        tableView.register(cellData.self, forCellReuseIdentifier: "cellData")

        //conform to search bar delegate
        filterSearch?.delegate = self
        filterSearch.placeholder = "Search by observation title"
        
      
  
    }


    @objc func addItem(){
        
       self.performSegue(withIdentifier: "showEntries", sender: self);
        
    }
    
    //Search bar function
    @objc func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        // if the user does not search, the table does not update.
        if searchText == "" {
            filterData.removeAll()
            filterData = listOfObservationData


            tableView.reloadData()

        }
        //if the user decides to type, we update the table accordingly.
        else{
            filterData = listOfObservationData.filter(
                {return $0.auditTitle.localizedCaseInsensitiveContains(searchText)  ||  $0.auditDescription.localizedCaseInsensitiveContains(searchText) })


            //tableView.reloadData()
        }


    }
    @objc func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        filterSearch.endEditing(true)
        tableView.reloadData()
    }


    

   func loadSiteAuditData(){
     
           //if Auth.auth().currentUser != nil {
           
           SwiftLoader.show(title: "Loading Data", animated: true)
  
               Database.database().reference(withPath:"\(refData)/\(mainConsole.auditList!)")
                   .observe(.value, with: { [self] snapshot in

                var listOfObservationData: [auditSiteData] = []
                for child in snapshot.children {

                if let snapshot = child as? DataSnapshot,
                   let List = auditSiteData(snapshot: snapshot) {
                    listOfObservationData.append(List)

                }
                }

                self.listOfObservationData = listOfObservationData
                filterData = self.listOfObservationData
                       
                self.tableView.reloadData()
                       
                       
                checkUserStatus()
                       
     
                       
                
                  
               })


       }
    

//Load Data from Firebase, get max listing---------------------------------------------------------------------------------------------------------------------[START]
    func loadUserStats(){

        
        let mainConsole = CONSOLE()
        
        let uid = Auth.auth().currentUser?.uid
        
        
        if userUID != uid!{
            //This would be from a user that is collaborating
            statusSegment.isHidden = true
            let reftest = Database.database().reference()
                .child("\(mainConsole.prod!)")
                .child("\(mainConsole.post!)")
                .child(userUID)
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
            
        }else{
            //This would be user that is listing item
            statusSegment.isHidden = false
            
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
    }
    
    
    @IBAction func addObservation(_ sender: Any) {
        
        if listOfObservationData.count < listingData * mainConsole.observationMulti!{
            self.performSegue(withIdentifier: "addObservation", sender: self);
        }else{
            
            let Alert = UIAlertController(title: "You've reached your max project listing of:", message: "\(listingData * mainConsole.observationMulti!)", preferredStyle: .alert)
            
            let action1 = UIAlertAction(title: "Add More",style: .default) { (action:UIAlertAction!) in
                //save this for headerview in view item
               
            }
            
            let action3 = UIAlertAction(title: "Cancel",style: .cancel) { (action:UIAlertAction!) in}
            
            
            Alert.addAction(action1)
            Alert.addAction(action3)
        
            self.present(Alert, animated: true, completion: nil)
            
            
        }
    }
        
    
    
//Load Data from Firebase, get max listing---------------------------------------------------------------------------------------------------------------------[END]
        
        
    
    
//Load project data from Firebase---------------------------------------------------------------------------------------------------------------------[START]
        
         func checkUserStatus(){
               
             SwiftLoader.hide()
            
                  
                  let reftest = Database.database().reference(withPath:"\(refData)")

                  reftest.queryOrderedByKey()
                      .observe( .value, with: { snapshot in
                                guard let dict = snapshot.value as? [String:Any] else {
                                //error here
                                return
                                }

                                 let status = dict["status"] as? String
                                 print("status:\(status!)")
                                
                          
                           
                                  switch status{
                                  case self.mainConsole.progress!:
                                  self.statusSegment.selectedSegmentIndex = 0;
                                  break
                                  default:
                                  self.statusSegment.selectedSegmentIndex = 1;
                                  break
                                  }

                    })
                                     
                      
                }

          
                
        
        
//Load project data from Firebase---------------------------------------------------------------------------------------------------------------------[END]
        
    
//Change project Status---------------------------------------------------------------------------------------------------------------------[START]
            @IBAction func indexChanged(_ sender: Any) {
                switch statusSegment.selectedSegmentIndex {
           
                case 0:
                    print("In-Progress")
                    self.firebaseConsole.updateSiteProgress(siteStatus: mainConsole.progress!, auditID: "\(auditID)/\(mainConsole.siteList!)/\(siteID)")
       
                    break
                default:
                    print("Archieved")
                    
                    self.firebaseConsole.updateSiteProgress(siteStatus: mainConsole.archived!, auditID: "\(auditID)/\(mainConsole.siteList!)/\(siteID)")
                    
                    break
                }
        
            }
//Change project Status---------------------------------------------------------------------------------------------------------------------[END]
    
//Count number of observations----------------------------------------------------------------------------------------------------------------[START]


    
    func observationSnapshotCount(auditID: String, siteID : String){
    
        let uid = Auth.auth().currentUser?.uid
            //we want to get the database reference
        
        if self.userUID != uid{
            
            let reftest = Database.database().reference()
                .child("\(self.mainConsole.prod!)")
            let auditData = reftest
                .child("\(self.mainConsole.post!)")
                .child(self.userUID)
                .child("\(self.mainConsole.audit!)")
                .child("\(auditID)")
                .child("\(self.mainConsole.siteList!)")
                .child("\(siteID)")
                .child("\(self.mainConsole.auditList!)")
            
            print("obscount:\(auditData)")
            
            auditData.queryOrderedByKey()
                .observeSingleEvent(of: .value, with: { snapshot in
                    var listOfObservationData: [auditSiteData] = []
                    for child in snapshot.children {
                        if let snapshot = child as? DataSnapshot,
                           let listOfSites = auditSiteData(snapshot: snapshot) {
                            listOfObservationData.append(listOfSites)
                        }
                    }
                    
                    
                    self.listOfObservationData = listOfObservationData
                    print("obscount:\(self.listOfObservationData.count)")
                    SwiftLoader.hide()
                    
                    
                })
            
            
          }else{
                
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
                        var listOfObservationData: [auditSiteData] = []
                        for child in snapshot.children {
                            if let snapshot = child as? DataSnapshot,
                                let listOfSites = auditSiteData(snapshot: snapshot) {
                                listOfObservationData.append(listOfSites)
                            }
                        }
                    
                    
                        self.listOfObservationData = listOfObservationData
                        print("obscount:\(self.listOfObservationData.count)")
                        SwiftLoader.hide()

                   
                    })
            }

        }
    
//Count number of listings----------------------------------------------------------------------------------------------------------------[END]



    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let items = filterData[indexPath.row]
        let uid = Auth.auth().currentUser?.uid
        let item = UIContextualAction(style: .destructive, title: "Delete") { (contextualAction, view, boolValue) in
            //Write your code in here
            //self.firebaseConsole.updateObservationStatus(status: "false", ref: items.ref)
            
            let itemRef = Database.database().reference(withPath: "\(items.ref)")
            itemRef.removeValue()
            
            //1 load the obsevation count
            self.observationSnapshotCount(auditID: self.auditID, siteID: self.siteID)
            //2 save the key
            
            if self.userUID != uid{
                
//This would be from a user that is collaborating
            
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    self.firebaseConsole.updateObservationCount(count: "\(self.listOfObservationData.count)", auditID: self.auditID, siteID: self.siteID, userUID: self.userUID)

                    
                    
                    print("updated and saved observation")
                    SwiftLoader.hide()
                })
                
            }else{
                
//This would be user that is listing item
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    self.firebaseConsole.updateObservationCount(count: "\(self.listOfObservationData.count)", auditID: self.auditID, siteID: self.siteID, userUID: uid!)
                    
                    
 
                    
                    print("updated and saved observation")
                    SwiftLoader.hide()
                    
                })
            }
           
        }
     
        tableView.reloadData()
        let swipeActions = UISwipeActionsConfiguration(actions: [item])
        return swipeActions
    }
    
  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellData", for: indexPath) as! cellData
        
        
        let items = filterData[indexPath.row]
//        cell.textLabel?.text = items.auditTitle
//        cell.detailTextLabel?.text = items.siteID
        cell.siteName.text = items.auditTitle
        cell.auditDate.text = items.date
        cell.auditDescription.text = items.auditDescription
        let transforImageSize = SDImageResizingTransformer(size: CGSize(width: 150, height: 150), scaleMode: .fill)
        cell.siteImage.sd_setImage(with: URL(string:items.imageURL), placeholderImage: nil, context: [.imageTransformer:transforImageSize])
        
        cell.accessoryType = .disclosureIndicator
        


        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return filterData.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 120
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     if let destination4 = segue.destination as? addAuditSites {
            destination4.siteID = siteID
            destination4.auditID = auditID
            destination4.userUID = userUID

 
        
     }else if let destination6 = segue.destination as? buildReport {
          destination6.siteID = siteID
          destination6.auditID = auditID
          destination6.userUID = userUID
          destination6.refData = refData

       }
      

      else {
          
      }

          
          
    }

}
