//
//  myWatchListCell.swift
//  dbtestswift
//
//  Created by macbook on 5/10/19.
//  Copyright © 2019 macbook. All rights reserved.
//

import UIKit
import MapKit

import Firebase


class viewAuditCell: UICollectionViewCell {

    let mainConsole = CONSOLE()
    let mainFunction = extens()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        imageUI.frame = CGRect(
            x:10,
            y:10,
            width: 70 ,
            height: frame.height - 20
        )
     
        
        auditLabel.frame = CGRect(
            x: imageUI.frame.maxX + 10 + 10,
            y: imageUI.frame.minY,
            width: frame.width - (imageUI.frame.maxX + 10 + 20),
            height: 20)
        //60
        
        observationIcon.frame = CGRect(
            x: imageUI.frame.maxX + 10 + 10,
            y: auditLabel.frame.maxY + 10,
            width: 20,
            height: 20)
        
        observationCountLabel.frame = CGRect(
            x: observationIcon.frame.maxX + 10,
            y: auditLabel.frame.maxY + 10,
            width: frame.width - (observationIcon.frame.maxX + 20),
            height: 20)
        
        auditDate.frame = CGRect(
            x: imageUI.frame.maxX + 10 + 10,
            y: imageUI.frame.maxY - 20,
            width: frame.width - (imageUI.frame.maxX + 10 + 20),
            height: 20)

        lineDivider1.frame = CGRect(
            x:0,
            y:imageUI.frame.maxY + 1,
            width: frame.width,
            height: 1
        )

        //
        
        contentView.addSubview(imageUI)
        contentView.addSubview(observationIcon)
        contentView.addSubview(observationCountLabel)
        contentView.addSubview(auditLabel)
        contentView.addSubview(auditDate)
        //contentView.addSubview(lineDivider1)

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let imageUI: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 10
        //image.layer.borderWidth = 0.5
        image.layer.masksToBounds = true
        
    return image


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
        image.tintColor = #colorLiteral(red: 1, green: 0.5843137255, blue: 0, alpha: 1)

   
        return image
    }()

    let auditLabel: UILabel = {
        let label = UILabel()
        label.text = "Loading.."
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 1
        label.textAlignment = .left
        //label.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    let observationCountLabel: UILabel = {
        let label = UILabel()
        label.text = "Loading.."
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.numberOfLines = 1
        label.textAlignment = .left
        //label.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        label.textColor = #colorLiteral(red: 1, green: 0.5843137255, blue: 0, alpha: 1)
        return label
    }()
    
    let auditDate: UILabel = {
        let label = UILabel()
        label.text = "Loading.."
        label.font = UIFont.systemFont(ofSize: 10)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        //label.backgroundColor =  #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)
        return label
    }()
    
    
  
    
}
