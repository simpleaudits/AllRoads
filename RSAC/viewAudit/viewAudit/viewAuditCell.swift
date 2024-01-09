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
     
 
        //60
        
        auditLabel.frame = CGRect(
            x: mapUI.frame.maxX + 10,
            y: 0,
            width: frame.width,
            height: 20)
        //60
        
        observationIcon.frame = CGRect(
            x: mapUI.frame.maxX + 10,
            y: auditLabel.frame.maxY + 10,
            width: 20,
            height: 20)
        
        observationCountLabel.frame = CGRect(
            x: observationIcon.frame.maxX + 10,
            y: auditLabel.frame.maxY + 10,
            width: frame.width,
            height: 20)
        
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
        contentView.addSubview(observationIcon)
        contentView.addSubview(observationCountLabel)
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
    
    
    let observationIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "camera.on.rectangle.fill")
        image.contentMode = .scaleAspectFill
        image.tintColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
//        image.layer.cornerRadius = 10
//        image.layer.masksToBounds = true
        //profile.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        //
        //profile.layer.borderWidth = 0.5
   
        return image
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
    let observationCountLabel: UILabel = {
        let label = UILabel()
        label.text = "Loading.."
        label.font = UIFont.systemFont(ofSize: 10)
        label.numberOfLines = 1
        label.textAlignment = .left
        //label.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        label.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
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
