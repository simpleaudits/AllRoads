//
//  myWatchListCell.swift
//  dbtestswift
//
//  Created by macbook on 5/10/19.
//  Copyright © 2019 macbook. All rights reserved.
//

import UIKit
import MapKit

class viewAuditCell: UICollectionViewCell {

    let mainConsole = CONSOLE()
    let mainFunction = extens()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        mapUI.frame = CGRect(
            x:0,
            y:0,
            width: 80 ,
            height: 80
        )
     
        auditImage.frame = CGRect(
            x: 0,
            y: 0,
            width: 100,
            height: 100)
        //60
        
        auditLabel.frame = CGRect(
            x: mapUI.frame.maxX + 10,
            y: 0,
            width: frame.width,
            height: 20)
        //60
        
        auditDate.frame = CGRect(
            x: mapUI.frame.maxX + 10,
            y: mapUI.frame.maxY - 20,
            width: frame.width,
            height: 20)

        lineDivider1.frame = CGRect(
            x:0,
            y:mapUI.frame.maxY + 1,
            width: frame.width,
            height: 1
        )

        //
        
        contentView.addSubview(mapUI)
        contentView.addSubview(auditImage)
        contentView.addSubview(auditLabel)
        contentView.addSubview(auditDate)
        //contentView.addSubview(lineDivider1)

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let mapUI: MKMapView = {
    //let placeHolderImage = UIImage(named: "yeezy.jpg")
    let mapViewUI = MKMapView() // this allows us to assing images.
    mapViewUI.mapType = .satelliteFlyover
    mapViewUI.isUserInteractionEnabled = false

    return mapViewUI


    }()
    
    let lineDivider1: UIView = {
        let Line = UIView() // this allows us to assing images.
        Line.backgroundColor =  #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)

        return Line
      }()
    
    
    let auditImage: UIImageView = {
        let profile = UIImageView()
        //profile.image = UIImage(named: "frozen")
        profile.contentMode = .scaleAspectFill
        profile.layer.cornerRadius = 10
        profile.layer.masksToBounds = true
        //profile.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        //
        //profile.layer.borderWidth = 0.5
   
        return profile
    }()

    let auditLabel: UILabel = {
        let label = UILabel()
        label.text = "Loading.."
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.numberOfLines = 1
        label.textAlignment = .left
        //label.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    let auditDate: UILabel = {
        let label = UILabel()
        label.text = "Loading.."
        label.font = UIFont.systemFont(ofSize: 10)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        return label
    }()
    
    
  
    
}
