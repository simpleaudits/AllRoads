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
            y:  0,
            width: frame.width - (siteImage.frame.maxX + 5),
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
    
    var auditID = String()
    var siteID = String()
    var listOfSitesData: [auditSiteData] = []
    var filterData: [auditSiteData] = []
    
    @IBOutlet var filterSearch: UISearchBar!
    @IBOutlet weak var segmentControlOutlet: UISegmentedControl!
    
    var titleData = String()
    var descriptionData = String()
    


    var toggle = Bool()
    
    


    override func viewDidAppear(_ animated: Bool) {
        //filterData = listOfSitesData
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //load observation data:
        loadSiteAuditData()
        
        //register cell
        tableView.register(cellData.self, forCellReuseIdentifier: "cellData")

        //conform to search bar delegate
        filterSearch?.delegate = self
        filterSearch.placeholder = "Search by observation title"
        
      
  
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

    //Search bar function
    @objc func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        // if the user does not search, the table does not update.
        if searchText == "" {
            filterData.removeAll()
            filterData = listOfSitesData


            tableView.reloadData()

        }
        //if the user decides to type, we update the table accordingly.
        else{
            filterData = listOfSitesData.filter(
                {return $0.auditTitle.localizedCaseInsensitiveContains(searchText)  ||  $0.auditDescription.localizedCaseInsensitiveContains(searchText) })


            //tableView.reloadData()
        }


    }
    @objc func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        filterSearch.endEditing(true)
        tableView.reloadData()
    }


    
    
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

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let items = filterData[indexPath.row]
        
        let item = UIContextualAction(style: .destructive, title: "Delete") { (contextualAction, view, boolValue) in
            //Write your code in here
            //self.firebaseConsole.updateObservationStatus(status: "false", ref: items.ref)
            
            let itemRef = Database.database().reference(withPath: "\(items.ref)")
            itemRef.removeValue()
            
            
           
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

        
     }else if let destination5 = segue.destination as? viewPDF {
         destination5.refData = refData

      }
      

      else {
          
      }

          
          
    }

}