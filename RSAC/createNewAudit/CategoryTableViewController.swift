//
//  CategoryTableViewController.swift
//  dbtestswift
//
//  Created by macbook on 27/12/20.
//  Copyright © 2020 macbook. All rights reserved.
//

import UIKit



protocol auditStage {
    func finishPassing_category(saveCategory: String)
}



class CategoryTableViewController: UITableViewController {
    
    var delegate: auditStage?
    
    //this needs to be initialized before this view is loaded:
    var config = 0 // 0 - design stage, this will be default
                   // 1 - road condition
    
    let category:Array = ["strategic design",
                          "concept design ",
                          "detailed design",
                          "roadworks",
                          "pre-opening",
                          "finalisation",
                          "existing road"
    ]
    
    let roadConditionTypes:Array = [
        "clear",                // Road surface is dry, clean, and free of obstructions or weather-related issues. Ideal driving conditions.
        "wet",                  // Road surface is covered with water due to rain, snowmelt, or other sources. Can lead to hydroplaning.
        "icy",                  // Road surface is covered with ice. Extremely slippery and dangerous.
        "snowy",                // Road surface is covered with snow. Visibility may be reduced, and traction can be compromised.
        "slushy",               // A mixture of snow and water on the road surface, creating a slippery and uneven driving condition.
        "muddy",                // Road surface is covered with mud, often due to rain or construction activities. Slippery and reduces traction.
        "gravel",              // Road surface is covered with loose gravel. Affects vehicle control and increases stopping distances.
        "potholes",             // Presence of depressions or holes in the road surface caused by wear and tear or weather conditions.
        "construction Zone",    // Road area undergoing construction or maintenance. Includes lane closures and uneven surfaces.
        "uneven",              // Road surface is uneven due to wear, damage, or maintenance work. Can cause discomfort or handling issues.
        "frost",               // A thin layer of ice or frost on the road surface, usually in the early morning or late evening. Slippery.
        "flooded",             // Road surface is partially or completely covered with water due to heavy rainfall or flooding.
        "debris",              // Presence of objects or materials on the road surface, such as fallen branches, rocks, or litter.
        "oil Slick",           // Road surface is covered with a layer of oil, making it slippery and hazardous.
        "rough",               // Road surface is coarse or damaged, leading to a bumpy ride and potential vehicle wear.
        "closed",              // Road or section of road is closed to traffic due to accidents, roadwork, or other reasons.
        "under Repair",        // Road surface is being repaired or resurfaced. Temporary conditions include uneven surfaces and barriers.
        "compacted Snow",      // Snow that has been packed down by vehicle tires or weather conditions, leading to icy conditions.
        "loose Sand",          // Road surface is covered with loose sand, which can be challenging for vehicle traction.
        "black Ice"            // A thin, nearly invisible layer of ice on the road. Extremely dangerous due to low visibility and high slipperiness.
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        switch config {
            
        case 1:
            navigationItem.title = "Road Condition"

        default:
            navigationItem.title = "Design Stage"
          
        }

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
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch config {
            
        case 1:
            
            let indexCategory = roadConditionTypes[indexPath.row]
            
            self.delegate?.finishPassing_category(saveCategory: indexCategory)
            
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
//                self.navigationController?.popViewController(animated: true)
//                
//                //self.dismiss(animated: true, completion: nil)
//                
//                
//            })
            
        default:
            
            let indexCategory = category[indexPath.row]
            
            self.delegate?.finishPassing_category(saveCategory: indexCategory)
            
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
//                self.navigationController?.popViewController(animated: true)
//                
//                //self.dismiss(animated: true, completion: nil)
//                
//                
//            })
        }
 
        
    }
    


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
    
        switch config {
            
        case 1:
            
            return roadConditionTypes.count
        
            
        default:
            
            return category.count
        }
    }

 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch config {
            
        case 1:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = roadConditionTypes[indexPath.row]
            
            // Configure the cell...

            return cell
            
        default:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = category[indexPath.row]


            // Configure the cell...

            return cell
        }
    }



    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
