//
//  detailsCell.swift
//  RoadSafetyAuditCloud
//
//  Created by John on 8/11/2023.
//

import Foundation
import UIKit




class detailsCell: UICollectionViewCell{
    
    override init(frame:CGRect){

        super.init(frame:frame)
  
        
        labelUI.frame = CGRect(
            x:0,
            y:0,
            width: frame.width ,
            height: frame.height
        )

        contentView.addSubview(labelUI)

      
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    


    

        let labelUI: UILabel = {
        //let placeHolderImage = UIImage(named: "yeezy.jpg")
        let labelUI = UILabel() // this allows us to assing images.
            //labelUI.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            //labelUI.layer.opacity = 0.5
            labelUI.text = "hello"
 
            
        return labelUI


        }()



    
    
    
}
