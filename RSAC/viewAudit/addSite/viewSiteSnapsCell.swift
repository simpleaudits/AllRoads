//
//  myWatchListCell.swift
//  dbtestswift
//
//  Created by macbook on 5/10/19.
//  Copyright © 2019 macbook. All rights reserved.
//

import UIKit
import MapKit

class viewSiteSnapsCell: UICollectionViewCell {

    let mainConsole = CONSOLE()
    let mainFunction = extens()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        mapUI.frame = CGRect(
            x:0,
            y:0,
            width: frame.width ,
            height: frame.height
        )
     
        siteImage.frame = CGRect(
            x: 0,
            y: 0,
            width: 100,
            height: 100)
        //60
        
        siteName.frame = CGRect(
            x: siteImage.frame.maxX + 5,
            y:  0,
            width: frame.width - (siteImage.frame.maxX + 5),
            height: 20)
        //60
        
        auditDate.frame = CGRect(
            x: siteImage.frame.maxX + 5,
            y: siteName.frame.maxY + 5,
            width: frame.width - (siteImage.frame.maxX + 5),
            height: 20)



        //
        
        //contentView.addSubview(mapUI)
        contentView.addSubview(siteImage)
        contentView.addSubview(siteName)
        contentView.addSubview(auditDate)
       

        
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

    
    let siteImage: UIImageView = {
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

    let siteName: UILabel = {
        let label = UILabel()
        label.text = "Loading.."
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 1
        label.textAlignment = .left
//label.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    let auditDate: UILabel = {
        let label = UILabel()
        label.text = "Loading.."
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    
  
    
}
