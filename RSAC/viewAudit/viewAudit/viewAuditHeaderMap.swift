//
//  headerName.swift
//  dbtestswift
//
//  Created by macbook on 16/4/22.
//  Copyright © 2022 macbook. All rights reserved.
//

import Foundation
import MapKit
//
//  Jafflers.swift
//  dbtestswift
//
//  Created by macbook on 28/6/20.
//  Copyright © 2020 macbook. All rights reserved.
//

import Foundation
import UIKit



class viewAuditHeaderMap: UICollectionViewCell{

    
    override init(frame: CGRect) {
        super .init(frame:frame)
        
        
        myLocations.frame = CGRect(
            x: 10,
            y: 10,
            width: frame.width - 20,
            height: frame.height - 10)
        
        headerName.frame = CGRect(
            x: 0,
            y: 0,
            width: frame.width ,
            height: frame.height)
        
        
        //addSubview(headerName)
        addSubview(myLocations)

    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

    
    
    let headerName: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "Your Audit Locations"
        label.numberOfLines = 1 // label height should be 50
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        //label.backgroundColor = .blue
        //label.backgroundColor = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
        return label
    }()
    
    
    
    let myLocations: MKMapView = {
        
        let maps = MKMapView()
        maps.mapType = MKMapType.standard
        maps.isZoomEnabled = true
        maps.isScrollEnabled = true
        maps.backgroundColor = .red
        //maps.showsUserLocation = true
        maps.layer.cornerRadius = 8
       // maps.layer.borderWidth = 1.0
    
        
        // Or, if needed, we can position map in the center of the view
        
        return maps
    }()
    

    
}



