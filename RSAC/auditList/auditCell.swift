//
//  BumperCell.swift
//  dbtestswift
//
//  Created by macbook on 26/8/20.
//  Copyright © 2020 macbook. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class auditCell:UICollectionViewCell{
    

    override init(frame:CGRect){


        super.init(frame:frame)
  
        mapUI.frame = CGRect(
            x:0,
            y:0,
            width: frame.width ,
            height: frame.height
        )
        
        labelUI.frame = CGRect(
            x:0,
            y:frame.height * 0.7,
            width: frame.width ,
            height: frame.height * 0.3
        )
        
        projectName.frame = CGRect(
            x:5,
            y:frame.height * 0.7,
            width: frame.width - 5 ,
            height: frame.height * 0.3
        )
  
        contentView.addSubview(mapUI)
        contentView.addSubview(labelUI)
        contentView.addSubview(projectName)
      
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

        let mapUI: MKMapView = {
        //let placeHolderImage = UIImage(named: "yeezy.jpg")
        let mapViewUI = MKMapView() // this allows us to assing images.
        mapViewUI.mapType = .satelliteFlyover
        mapViewUI.isUserInteractionEnabled = false

        return mapViewUI


        }()
    

        let labelUI: UILabel = {
        //let placeHolderImage = UIImage(named: "yeezy.jpg")
        let labelUI = UILabel() // this allows us to assing images.
            labelUI.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            labelUI.layer.opacity = 0.5
 
            
        return labelUI


        }()
    
        let projectName: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "CN-54654"
        label.numberOfLines = 2 // label height should be 50
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.backgroundColor = .clear
        return label



        }()


    
    
    
}
