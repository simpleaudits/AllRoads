//
//  crashTypeTableViewController.swift
//  dbtestswift
//
//  Created by macbook on 27/12/20.
//  Copyright © 2020 macbook. All rights reserved.
//

import UIKit



protocol crashTypesFunc {
    func finishPassing_crashType(savecrashType: Array<Any>)
}



class crashTypes: UITableViewController {
    
    var crashDataArray = Array<Any>()
    
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
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        //create nav bar button:
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(clearAll))
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
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        let indexcrashType = Array(crashType.keys)[indexPath.row]
       
        //append each new did selected item
        crashDataArray.append(indexcrashType)

        self.delegate?.finishPassing_crashType(savecrashType: crashDataArray)
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
//
//        
//    
//        })
        
 
        
    }
    


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return crashType.count
    }

 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = Array(crashType.keys)[indexPath.row]
        cell.detailTextLabel?.text = Array(crashType.values)[indexPath.row]
        
        

        // Configure the cell...

        return cell
    }




}
