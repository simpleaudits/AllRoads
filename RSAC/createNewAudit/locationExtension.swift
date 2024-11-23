//
//  locationExtension.swift
//  RoadSafetyAuditCloud
//
//  Created by John on 19/10/2023.
//
//GITPUSH123

import Foundation
import UIKit
import CoreLocation
import MapKit


protocol locationDecriptionString{
    func finishPassing_location(saveLocation: String,lat:CGFloat,long:CGFloat)
}

extension locationView {
    
    

    
    // get upload location
    //function calls the location
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
    // Handle tap on the map
     @objc func handleMapTap(_ gesture: UITapGestureRecognizer) {
         let location = gesture.location(in: mapViewUI)
         let coordinate = mapViewUI.convert(location, toCoordinateFrom: mapViewUI)
         
         // Update the pin's coordinate
         movePinToNewLocation(coordinate)
         
         self.lat = Float(CLLocationDegrees(coordinate.latitude))
         self.long = Float(CLLocationDegrees(coordinate.longitude))
         

         print(lat)
         print(long)
    
     }
    
    // Move the pin to a new location
    func movePinToNewLocation(_ coordinate: CLLocationCoordinate2D) {
        // Update the pin's coordinate
        pinAnnotation.coordinate = coordinate
        
        self.lat = Float(coordinate.latitude)
        self.long = Float(coordinate.longitude)

        
        // Optionally animate the map to the new location
        let region = MKCoordinateRegion(center: coordinate, span: mapViewUI.region.span)
        mapViewUI.setRegion(region, animated: true)
        
        
        
        fetchCityAndCountry(from: CLLocation(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(long))) { [self] city, country, error in
            guard let city = city, let country = country, error == nil else { return }
            self.location = "\(city), \(country)"
            
            locationLabel.text = "\(self.location)\nLatitude:\(lat),\nLongitude:\(long)"
            self.delegate?.finishPassing_location(saveLocation: locationLabel.text ?? "", lat: CGFloat(self.lat), long:CGFloat(self.long))
  
        
        }
    }
    
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002))
        
        self.mapViewUI.setRegion(region, animated: true)
        // Create and add the pin
        
        self.lat = Float(region.center.latitude)
        self.long = Float(region.center.longitude)
        
        
        pinAnnotation = MKPointAnnotation()
        pinAnnotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(long))
        pinAnnotation.title = "You are here"
        mapViewUI.addAnnotation(pinAnnotation)
        
        
        fetchCityAndCountry(from: CLLocation(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(long))) { [self] city, country, error in
            guard let city = city, let country = country, error == nil else { return }
            self.location = "\(city), \(country)"
            
            locationLabel.text = "\(self.location)\nLatitude:\(lat),\nLongitude:\(long)"
            self.delegate?.finishPassing_location(saveLocation: locationLabel.text ?? "", lat: CGFloat(self.lat), long:CGFloat(self.long))
  
        
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
