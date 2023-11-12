//
//  extensionFiles.swift
//  waiter+
//
//  Created by John on 6/9/2023.
//

import Foundation
import UIKit



class extens: UIViewController {
    //this function is fetching the json from URL
    func timeStamp() -> String{
        //creating a NSURL
        
        
        let date = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        print(dateFormatter.string(from: date as Date))
        let dateNow = date.timeIntervalSince1970
        let UNIXInt = Int(dateNow)
        print("Unix Date" + "\(UNIXInt)")
        
        
        return String(dateFormatter.string(from: date as Date))
    }
    
    func auditID() -> String{
        //creating a NSURL
        let uuid = UUID().uuidString

        
        return String(uuid)
    }
    
    
    
  
    func localAlert(message:String,submessage:String){
        
        let alertController = UIAlertController(title: message, message: submessage, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK",style: .default) { (action:UIAlertAction!) in
            // Perform action

        }
        let cancel = UIAlertAction(title: "Cancel",style: .cancel) { (action:UIAlertAction!) in
            // Perform action

        }
        alertController.addAction(action)
        alertController.addAction(cancel)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func successUpload(Message:String,subtitle:String){
        
        // we want to close any activity loading


        
        let Alert = UIAlertController(title: Message, message: subtitle, preferredStyle: .alert)
        let action1 = UIAlertAction(title: "OK",style: .default) { (action:UIAlertAction!) in
            
       
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "mainView")
            self.present(controller, animated: true, completion: nil)
            
     
        }
        
        
        Alert.addAction(action1)
        self.present(Alert, animated: true, completion: nil)
        
    }
    
    func errorUpload(errorMessage:String,subtitle:String){
        
        // we want to close any activity loading
        //IHProgressHUD.dismiss()
        

        
        let Alert = UIAlertController(title: "\(errorMessage)", message: "\(subtitle)", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "OK",style: .default) { (action:UIAlertAction!) in
            
            
        }
        
        
        Alert.addAction(action1)
        self.present(Alert, animated: true, completion: nil)
        
    }
    
    
    
}


class CONSOLE: UIViewController {
    var prod:String? = "prod"
    var post:String? = "post"  // "\(ParentJSON.Parent!)"
    var audit:String? = "audit" // "\(ParentJSON.Parent_child!)"
    var auditList:String? = "auditList" // "\(ParentJSON.Parent_child!)"
    var userDetails:String? = "userDetails" // "\(ParentJSON.User_Details!)"
    var profileImage: String? = "profileImage"
    var listingImage: String? = "listingImage"
    var auditProductList:String? = "auditProductList" // "\(ParentJSON.ProductList!)"
    
 
    
    var complete: String? = "Completed Audits"
    var progress: String? = "In-Progress Audits"
    var archived: String? = "Archived"
    
    

    
    
    
    var listOfData = [
        "Inadequate road signage for upcoming hazards.",
        "Poorly marked or faded road markings.",
        "Insufficient lighting at intersections.",
        "Lack of pedestrian crosswalks.",
        "Absence of speed limit signage.",
        "Unmarked or hidden driveways.",
        "Inconsistent lane width.",
        "Overgrown vegetation obstructing signs.",
        "Absence of pedestrian-friendly infrastructure.",
        "Lack of bicycle lanes or paths.",
        "Inadequate signage for school zones.",
        "Poorly designed or marked roundabouts.",
        "Limited visibility at railway crossings.",
        "Insufficient road maintenance causing potholes.",
        "Lack of emergency pull-off areas.",
        "Obstructed sightlines at intersections.",
        "Inconsistent application of speed humps.",
        "Absence of proper drainage causing water accumulation.",
        "Insufficient clearance for overheight vehicles.",
        "Lack of road markings indicating pedestrian right-of-way.",
        "Inadequate enforcement of traffic laws.",
        "Insufficient warning signs for upcoming curves.",
        "Absence of countdown timers for pedestrian crossings.",
        "Poorly designed transitions between different road types.",
        "Lack of tactile markings for visually impaired pedestrians.",
        "Inconsistent or confusing road numbering.",
        "Absence of reflective paint on road surfaces.",
        "Limited access for emergency vehicles.",
        "Inadequate delineation of bike paths at intersections.",
        "Lack of enforcement of no-parking zones.",
        "Insufficient separation between pedestrian and vehicular traffic.",
        "Absence of proper bus stops or shelters.",
        "Overhead obstacles limiting vertical clearance.",
        "Poorly designed traffic signal phasing.",
        "Lack of wildlife crossing signage in rural areas.",
        "Insufficient road width for safe overtaking.",
        "Inadequate turning radii for large vehicles.",
        "Absence of warning signs for animal crossings.",
        "Limited provision for emergency vehicle turnarounds.",
        "Lack of road safety education campaigns.",
        "Inconsistent application of road calming measures.",
        "Absence of rumble strips in appropriate locations.",
        "Inadequate maintenance of road shoulders.",
        "Poorly designed transition zones between urban and rural areas.",
        "Absence of designated parking areas.",
        "Inconsistent application of stop lines at intersections.",
        "Lack of advanced warning signs for upcoming intersections.",
        "Inadequate provision for winter road maintenance.",
        "Absence of guardrails on high embankments.",
        "Poorly marked or unmarked pedestrian refuge islands.",
        "Inconsistent application of pedestrian countdown signals.",
        "Lack of signage for scenic viewpoints or pull-offs.",
        "Insufficient illumination of pedestrian pathways.",
        "Inadequate provision for school bus stops.",
        "Absence of proper markings for speed bumps.",
        "Limited provision for emergency escape routes.",
        "Poorly marked or confusing detour routes.",
        "Inconsistent placement of roadside mirrors.",
        "Absence of signage for no-passing zones.",
        "Inadequate road design for adverse weather conditions.",
        "Lack of designated bicycle parking areas.",
        "Overhead wires obstructing vertical clearance.",
        "Inconsistent application of turning lanes at intersections.",
        "Absence of warning signs for potential wildlife on the road.",
        "Inadequate provision for emergency vehicle preemption at signals.",
        "Limited provision for roadside assistance pull-offs.",
        "Poorly designed or missing exit ramps on highways.",
        "Absence of designated truck lanes on steep gradients.",
        "Inconsistent application of road narrowing signage.",
        "Lack of proper markings for pedestrian overpasses.",
        "Insufficient road width for safe merging.",
        "Poorly marked or confusing one-way streets.",
        "Limited provision for safe U-turns.",
        "Inadequate provision for dynamic message signs.",
        "Absence of signage for upcoming road maintenance work.",
        "Insufficient turning radii for emergency vehicles.",
        "Poorly marked or unmarked school zones.",
        "Lack of road markings indicating bus lanes.",
        "Inconsistent application of no-overtaking zones.",
        "Absence of proper markings for pedestrian tunnels.",
        "Inadequate provision for emergency vehicle access to buildings.",
        "Limited provision for emergency vehicle parking.",
        "Poorly marked or unmarked crosswalks at mid-block locations.",
        "Lack of proper markings for speed advisory signs.",
        "Insufficient road width for safe pedestrian movement.",
        "Inconsistent application of yield signs.",
        "Absence of proper markings for traffic calming measures.",
        "Limited provision for rest areas on long stretches of road.",
        "Inadequate provision for emergency vehicle turnaround at dead ends.",
        "Poorly designed or missing yield-controlled intersections.",
        "Lack of proper markings for emergency vehicle lanes.",
        "Inconsistent placement of pedestrian crossing signs.",
        "Absence of signage for upcoming changes in road conditions.",
        "Insufficient road width for safe bicycle movement.",
        "Limited provision for emergency vehicle staging areas.",
        "Poorly marked or unmarked shared bicycle and pedestrian pathways.",
        "Lack of proper markings for bicycle boxes at intersections.",
        "Inadequate provision for emergency vehicle access to tunnels.",
        "Absence of proper markings for raised crosswalks.",
        "Insufficient provision for emergency vehicle access to bridges.",
    ]
    
    

}