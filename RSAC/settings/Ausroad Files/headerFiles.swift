//
//  headerName.swift
//  dbtestswift
//
//  Created by macbook on 16/4/22.
//  Copyright © 2022 macbook. All rights reserved.
//

import Foundation
//
//  Jafflers.swift
//  dbtestswift
//
//  Created by macbook on 28/6/20.
//  Copyright © 2020 macbook. All rights reserved.
//

import Foundation
import UIKit



class cellFiles: UICollectionViewCell{
    
    
    override init(frame: CGRect) {
        super .init(frame:frame)
        
        categoryImage.frame = CGRect(
            x: 0,
            y: 0,
            width: frame.height,
            height: frame.height)
        
     contentView.addSubview(categoryImage)

        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let categoryImage: UIImageView = {
        let Image = UIImageView() // this allows us to assing images.
        Image.contentMode = UIView.ContentMode.scaleAspectFit
        //Image.backgroundColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        //Image.layer.cornerRadius = 30
        //Image.layer.masksToBounds = true
        //Image.contentMode = .scaleAspectFill
  
        return Image
    }()
    
  
  
    
}










class headerFiles: UICollectionReusableView{
    
    
    
    
    
    override init(frame: CGRect) {
        super .init(frame:frame)

        
        headerName.frame = CGRect(
            x: 0,
            y: 0,
            width: frame.width ,
            height: frame.height)
        
        
        addSubview(headerName)
   
        
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    

    
    
    let headerName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "headerName"
        label.numberOfLines = 1 // label height should be 50
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.adjustsFontSizeToFitWidth = true
        //label.backgroundColor = .blue
        //label.backgroundColor = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
        
        
        
        
        return label
        
    }()
    
    
    
    
    
    
    
}



