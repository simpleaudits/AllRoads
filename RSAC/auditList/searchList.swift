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

class searchList: UITableViewController,UISearchBarDelegate {

    //properties
    var latData:Float?
    var longData:Float?
    var userName:String?
    var noteData:String?
    var itemReference:String?
    var auditID = String()
    var projectName = String()
    
    var ParentJSON = CONSOLE()

    
    var user: User!
    var itemsfeed: [newAuditDataset] = []
    var filterData: [newAuditDataset] = []

    @IBOutlet var filterSearch: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // conform to the uisearchbardelegate
        filterSearch?.delegate = self
        filterSearch.placeholder = "Search by Project Name name or Audit Ref."
  
        
        viewAuditData()
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func viewDidAppear(_ animated: Bool) {
        //filterData = itemsfeed
        tableView.reloadData()
    }






    //Search bar function
    @objc func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        // if the user does not search, the table does not update.
        if searchText == "" {

            
            filterData.removeAll()
            tableView.reloadData()
            
            print(filterData)
            
            
        }
        //if the user decides to type, we update the table accordingly.
        else{
            // this allows the user to search by either username or note.

            filterData = itemsfeed.filter(
                {return $0.projectName.localizedCaseInsensitiveContains(searchText)  ||  $0.auditReference.localizedCaseInsensitiveContains(searchText)  })
            print(filterData)
            
            
            
            tableView.reloadData()
        }


    }
    @objc func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filterData.removeAll()
        tableView.reloadData()
    }
    
    

    
    func viewAuditData(){
        
        //1)prod
        //2)post
        //3)skips UID
        //4)audit
        //skips AuditRef
        
        //--------------------------------
        //1)
        let reftest = Database.database().reference().child("\(self.ParentJSON.prod!)")
        //2)
        let auditDataList = reftest.child("\(self.ParentJSON.post!)")
        
        //3)
        auditDataList.observe(DataEventType .childAdded, with: { snapshot in
        //4), 5)
            for child in snapshot.childSnapshot(forPath: "\(self.ParentJSON.audit!)").children {
                    if let snapshot = child as? DataSnapshot,
                        let proditem = newAuditDataset(snapshot: snapshot) {
                        self.itemsfeed.append(proditem)
                        
                        print(proditem.projectName)
                        
                      

                    }
            }
        
            self.tableView.reloadData()
     
            })
        

               
}
    
    

    
    
  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        
        let items = filterData[indexPath.row]
        cell.textLabel?.text = items.projectName
        cell.detailTextLabel?.text = items.auditProgress
        

        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        
        return filterData.count
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
   
        let items = filterData[indexPath.row]

        itemReference = items.auditReference
        self.auditID = items.auditID
        self.projectName = items.projectName

        self.performSegue(withIdentifier: "viewItemDetailsFromSearch", sender: indexPath.row);
 

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
