//
//  myWatchListCell.swift
//  dbtestswift
//
//  Created by macbook on 5/10/19.
//  Copyright © 2019 macbook. All rights reserved.
//

import UIKit

class viewAuditCell: UICollectionViewCell {

    let mainConsole = CONSOLE()
    let mainFunction = extens()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
     
        auditImage.frame = CGRect(
            x: 0,
            y: 0,
            width: 100,
            height: 100)
        //60
        
        auditLabel.frame = CGRect(
            x: auditImage.frame.width + 10,
            y:  5,
            width: frame.width - (auditImage.frame.width + 30),
            height: 20)
        //60
        
        auditDate.frame = CGRect(
            x: auditImage.frame.width + 10,
            y: auditLabel.frame.maxY + 5,
            width: frame.width - (auditImage.frame.width + 10),
            height: 20)



        //
        
        
        contentView.addSubview(auditImage)
        contentView.addSubview(auditLabel)
        contentView.addSubview(auditDate)


        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 2
        return label
    }()
    
    let auditDate: UILabel = {
        let label = UILabel()
        label.text = "Loading.."
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 2
        return label
    }()
    
    
  
    
}
