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
        profile.image = UIImage(systemName: "person.fill.badge.plus")
        profile.contentMode = .scaleAspectFit
        profile.layer.cornerRadius = 10
        profile.layer.masksToBounds = true
        profile.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        //
        //profile.layer.borderWidth = 0.5
   
        return profile
    }()

    let settingsLabel: UILabel = {
        let label = UILabel()
        label.text = "Loading.."
        label.font = UIFont.boldSystemFont(ofSize: 15)
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
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        //label.backgroundColor = .red
        return label
    }()
}


class settingsPage: UITableViewController,UISearchBarDelegate {

    
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
                cell.auditDescription.text = "Johns Audits"
                
                cell.settingsLabel.frame = CGRect(
                    x: 20,
                    y:  10,
                    width: cell.frame.width - 20,
                    height: 20)
                //60
                cell.auditDescription.frame = CGRect(
                    x: 20,
                    y: cell.settingsLabel.frame.maxY + 5,
                    width: cell.frame.width - 20,
                    height: 20 )
                
                
            }else  if indexPath.row == 1{
                cell.auditDescription.isHidden = true
                cell.siteImage.isHidden = false
                cell.settingsLabel.text = "Company Logo"
                
                cell.siteImage.frame = CGRect(
                    x: cell.contentView.frame.width - 60,
                    y:cell.frame.height/2 - 20,
                    width: 40,
                    height: 40)
                
                cell.settingsLabel.frame = CGRect(
                    x: 20, //siteImage.frame.maxX + 5,
                    y:  cell.frame.height/2 - 15,
                    width: cell.frame.width - 20,
                    height: 30)
                
                
            }else{
                cell.siteImage.isHidden = true
                cell.auditDescription.isHidden = true
                cell.settingsLabel.text = "Signature"
                
                cell.settingsLabel.frame = CGRect(
                    x: 20, //siteImage.frame.maxX + 5,
                    y:  cell.frame.height/2 - 15,
                    width: cell.frame.width - 20,
                    height: 30)
                
                
             
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
                width: cell.frame.width - 20,
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
       return 75
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

}
