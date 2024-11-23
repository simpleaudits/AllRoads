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
    var pinAnnotation: MKPointAnnotation!
    var buttonUI = UIButton()
    var delegate: locationDecriptionString?
    
    override func viewDidLoad() {
        super.viewDidLoad()


        
    }
    
    @IBAction func locateMe(_ sender: Any) {
        findMyLocation()
        
    }
    override func viewDidAppear(_ animated: Bool) {
     
        // Do any additional setup after loading the view.
        
        locationLabel = UILabel(frame: CGRect(x: 0, y:  (navigationController?.navigationBar.frame.maxY)!, width: view.frame.width, height: 100))
        locationLabel.text = "Your location Here"
        locationLabel.font = UIFont.boldSystemFont(ofSize: 15)
        locationLabel.numberOfLines = 3
        self.view.addSubview(locationLabel)
        
        let x = Int(view.frame.height) - Int(locationLabel.frame.maxY) - Int((tabBarController?.tabBar.frame.size.height)!)
        mapViewUI = MKMapView(frame: CGRect(x: 0, y: Int(locationLabel.frame.maxY), width: Int(view.frame.width), height: x ))
        mapViewUI.mapType = .satelliteFlyover
        self.view.addSubview(mapViewUI)
        

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleMapTap(_:)))
        mapViewUI.addGestureRecognizer(tapGesture)
        
        
        //pre load location if the user returns to this page:
        let initialLocation = CLLocationCoordinate2D(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(long)) // San Francisco
        let span = MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002) // Zoom level
        let region = MKCoordinateRegion(center: initialLocation, span: span)
        mapViewUI.setRegion(region, animated: true)
        
        pinAnnotation = MKPointAnnotation()
        pinAnnotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(long))
        pinAnnotation.title = "You are here"
        mapViewUI.addAnnotation(pinAnnotation)

    }
    
    func findMyLocation() {
       // do your stuff here
        findlocation()
    }
    

}
