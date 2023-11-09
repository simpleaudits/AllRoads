//
//  locationView.swift
//  RoadSafetyAuditCloud
//
//  Created by John on 18/10/2023.
//

import UIKit
import MapKit




class locationView: UIViewController,UISearchBarDelegate,UITextFieldDelegate, MKMapViewDelegate,CLLocationManagerDelegate {
    

    //map delcaration
    var lat = Float()
    var long = Float()
    var location = String()
    var locationManager = CLLocationManager()
    
    //contents
    var locationLabel = UILabel()
    var mapViewUI = MKMapView()
    var buttonUI = UIButton()
    var delegate: locationDecriptionString?
    
    override func viewDidLoad() {
        super.viewDidLoad()


        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        


        
        
        // Do any additional setup after loading the view.
        
        locationLabel = UILabel(frame: CGRect(x: 0, y:  (navigationController?.navigationBar.frame.maxY)!, width: view.frame.width, height: 50))
        locationLabel.text = "Your location Here"
        locationLabel.font = UIFont.boldSystemFont(ofSize: 20)
        self.view.addSubview(locationLabel)
        
        let x = Int(view.frame.height) - Int(locationLabel.frame.maxY) - Int((tabBarController?.tabBar.frame.size.height)!)
        mapViewUI = MKMapView(frame: CGRect(x: 0, y: Int(locationLabel.frame.maxY), width: Int(view.frame.width), height: x ))
        mapViewUI.mapType = .satelliteFlyover
        self.view.addSubview(mapViewUI)
        
        buttonUI = UIButton(frame: CGRect(x: view.frame.width/2 - 100, y:  mapViewUI.frame.maxY - 50 - 10, width: 200, height: 50))
        buttonUI.setTitleColor(UIColor.white, for: .normal)
        buttonUI.setTitle("My Location", for: .normal)
        buttonUI.backgroundColor = .systemBlue
        buttonUI.layer.cornerRadius = 25
        buttonUI.layer.masksToBounds = true
        buttonUI.addTarget(self, action: #selector(findMyLocation(_:)), for: .touchUpInside)
        self.view.addSubview(buttonUI)
       
        
    }
    
    @objc func findMyLocation(_ sender: UIButton) {
       // do your stuff here
      print("you clicked on button \(sender.tag)")
        findlocation()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
