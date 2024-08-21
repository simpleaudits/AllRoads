//
//  crashTypeTableViewController.swift
//  dbtestswift
//
//  Created by macbook on 27/12/20.
//  Copyright © 2020 macbook. All rights reserved.
//

import UIKit



protocol crashTypesFunc {
    func finishPassing_crashType(savecrashType: [String])
}




class crashTypes: UITableViewController {
    
    var crashDataArray = Array<String>()
    
    var delegate: crashTypesFunc?
    
    let crashType = [     "Rear end":"301-303",
                          "Opposing approach":"202-206",
                          "Adjacent approach":"100-109",
                          "Head on":"201,501",
                          "Pedestrian invovled":"001-009",
                          "Parallel turning involved":"308,309",
                          "Lane Change":"305-307,504",
                          "U-Turn":"207,304",
                          "Entering Road Way":"401,406-408",
                          "Hit Parked Vehicle":"402,404,601,602,604,608",
                          "Hit Train":"903",
                          
                          
    ]
    
    // Highlights crash type the user has selected vs all selected crash types
    var commonElements: Set<String> {
          return Set(Array(crashType.keys)).intersection(crashDataArray)
      }
    
    //if multiple selection, i.e if they double table rear-end, it wil only show 1.
    func removeAllDuplicates<T: Hashable>(from array: [T]) -> [T] {
        // Step 1: Count occurrences
        var counts = [T: Int]()
        for element in array {
            counts[element, default: 0] += 1
        }
        
        // Step 2: Filter elements to keep only those that appear exactly once
        let uniqueElements = array.filter { counts[$0] == 1 }
        
        return uniqueElements
    }
    
 
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        //create nav bar button:
        //navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneBtn))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(clearAll))
        
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    //    override func numberOfSections(in tableView: UITableView) -> Int {
    //        // #warning Incomplete implementation, return the number of sections
    //        return 0
    //    }
    
    
    @objc func clearAll(){
        crashDataArray.removeAll()
        
        self.delegate?.finishPassing_crashType(savecrashType: crashDataArray)
        
        tableView.reloadData()
    }
    
    @objc func doneBtn(){
        dismiss(animated: true)
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        let indexcrashType = Array(crashType.keys)[indexPath.row]
       
        //append each new did selected item
        crashDataArray.append(indexcrashType)
        
        //this allows us to select and deselect
        crashDataArray = removeAllDuplicates(from: crashDataArray)

        //based on single tap
        self.delegate?.finishPassing_crashType(savecrashType: crashDataArray)
        
        
  
        
        tableView.reloadData()
        

 
        
    }



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return crashType.count
    }

 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = Array(crashType.keys)[indexPath.row]
        cell.detailTextLabel?.text = Array(crashType.values)[indexPath.row]
        
        // Highlight cell if item is in commonElements
            if commonElements.contains(Array(crashType.keys)[indexPath.row]) {
                cell.backgroundColor = #colorLiteral(red: 1, green: 0.6645795107, blue: 0.2553189099, alpha: 1)
//                cell.layer.cornerRadius = 15
//                cell.layer.masksToBounds = true
                
        // Highlight color
            } else {
                cell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        // Default color
            }
        

        // Configure the cell...

        return cell
    }




}
