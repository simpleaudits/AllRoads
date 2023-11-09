//
//  addLocation.swift
//  RoadSafetyAuditCloud
//
//  Created by John on 29/10/2023.
//

import Foundation
import MapKit

extension addAudit{
    
    func findlocation(){
        
        if CLLocationManager.locationServicesEnabled() == true {
            
            if CLLocationManager.authorizationStatus() == .restricted || CLLocationManager.authorizationStatus() == .denied || CLLocationManager.authorizationStatus() == .notDetermined {
                
                locationManager.requestWhenInUseAuthorization()
            }else{
                locationManager.desiredAccuracy = 1
                locationManager.delegate = self
                locationManager.startUpdatingLocation()
                
                
            }
            
            
        } else {
            print("PLease turn on location services or GPS")
            
        }
        
        
    }
    
    func fetchCityAndCountry(from location: CLLocation, completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            completion(placemarks?.first?.locality,
                       placemarks?.first?.country,
                       error)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002))
        
        //self.mapViewUI.setRegion(region, animated: true)
        
        
        self.lat = CGFloat(region.center.latitude)
        self.long = CGFloat(region.center.longitude)
        let retrievedLocation = CLLocation(latitude:CLLocationDegrees(lat), longitude:CLLocationDegrees(long))
        
        fetchCityAndCountry(from: retrievedLocation) { [self] city, country, error in
            guard let city = city, let country = country, error == nil else { return }
            self.location = "\(city), \(country)"
     
            
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location is switched to NEVER")
        
        
        self.AlertLocation(errorMessage: "Location was set to NEVER", subtitle: "Settings>Locations Services>Jaffle")
    }
    
    
    func AlertLocation(errorMessage:String,subtitle:String){
        
        let Alert = UIAlertController(title: "\(errorMessage)", message: "\(subtitle)", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "Enable Location",style: .default) { (action:UIAlertAction!) in
            
            
            //opens location services from app
            if let bundleId = Bundle.main.bundleIdentifier,
               let url = URL(string: "\(UIApplication.openSettingsURLString)&path=location_services/\(bundleId)")
            {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
            
        }
        
        
        Alert.addAction(action1)
        // change the background color
        
        self.present(Alert, animated: true, completion: nil)
    }
}
