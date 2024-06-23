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
        label.font = UIFont(name:"Super Peach", size: 30.0)
        label.text = "headerName"
        label.numberOfLines = 1 // label height should be 50
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        //label.backgroundColor = .blue
        //label.backgroundColor = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
        
        
        
        
        return label
        
    }()
    
    
    
    
    
    
    
}



