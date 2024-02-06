//
//  signUpControllerItems.swift
//  dbtestswift
//
//  Created by John on 10/3/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import Foundation
import UIKit



class SignUpItemsCell: UICollectionViewCell, UITextViewDelegate{
    
    var maxLength = 2
    
    override init(frame: CGRect){
  
        
        super.init(frame:frame)
        
        // this is where we size all the objects we will be adding.
        header0.frame = CGRect(
            x: 10,
            y: 0,
            width: frame.width,
            height: 40
        )
        QR.frame = CGRect(
            x: frame.midX - 90,
            y: header0.frame.maxY + 20,
            width: 180,
            height: 180
        )
        DP.frame = CGRect(
            x: frame.midX - 50,
            y: QR.frame.midY - 50,
            width: 100,
            height: 100
        )
        
        DPButton.frame = CGRect(
            x: 0,
            y: QR.frame.maxY + 10,
            width: frame.width,
            height: 30
        )
        
        

        
        
        lineDivider1.frame = CGRect(
            x: 10,
            y: DPButton.frame.maxY + 10,
            width: frame.width,
            height: 1
        )
        
        header1.frame = CGRect(
            x: 10,
            y: lineDivider1.frame.maxY + 10,
            width: frame.width,
            height: 40
        )

        Name.frame = CGRect(
            x: 10,
            y: header1.frame.maxY + 10,
            width: frame.width,
            height: 40
        )

        lineDivider2.frame = CGRect(
            x: 10,
            y: Name.frame.maxY + 10,
            width: frame.width,
            height: 1
        )
        
        
        header2.frame = CGRect(
            x: 10,
            y: lineDivider2.frame.maxY + 10,
            width: frame.width,
            height: 40
        )

        lastName.frame = CGRect(
            x: 10,
            y: header2.frame.maxY + 10,
            width: frame.width,
            height: 40
        )

        lineDivider3.frame = CGRect(
            x: 10,
            y: lastName.frame.maxY + 10,
            width: frame.width,
            height: 1
        )
        
        
        
        header3.frame = CGRect(
            x: 10,
            y: lineDivider3.frame.maxY + 10,
            width: frame.width,
            height: 40
        )

        userName.frame = CGRect(
            x: 10,
            y: header3.frame.maxY + 10,
            width: frame.width,
            height: 40
        )

        lineDivider4.frame = CGRect(
            x: 10,
            y: userName.frame.maxY + 10,
            width: frame.width,
            height: 1
        )
        
        
        header4.frame = CGRect(
            x: 10,
            y: lineDivider4.frame.maxY + 10,
            width: frame.width,
            height: 40
        )

        DoBDD.frame = CGRect(
            x: 0,
            y: header4.frame.maxY + 10,
            width: frame.width/3*0.9/2,
            height: 40
        )
        
        DoBMM.frame = CGRect(
            x: frame.width/3*0.9/2 + 10,
            y: header4.frame.maxY + 10,
            width: frame.width/3*0.9/2,
            height: 40
        )
        DoBYY.frame = CGRect(
            x: frame.width/3*0.9/2 + 10 + frame.width/3*0.9/2 + 10,
            y: header4.frame.maxY + 10,
            width: frame.width/3*0.9/2,
            height: 40
        )

        lineDivider5.frame = CGRect(
            x: 10,
            y: DoBDD.frame.maxY + 10,
            width: frame.width,
            height: 1
        )
        
        saveButton.frame = CGRect(
            x: frame.midX - (frame.width * 0.80)/2,
            y: frame.height - 80 ,
            width: frame.width * 0.80 - 5,
            height: 60
        )
        
        //Profile image settings
        contentView.addSubview(header0)
        //contentView.addSubview(QR)
        contentView.addSubview(DP)
        contentView.addSubview(DPButton)
        contentView.addSubview(lineDivider1)
        //First Name settings
        contentView.addSubview(header1)
        contentView.addSubview(Name)
        contentView.addSubview(lineDivider2)
        //Last Name settings
        contentView.addSubview(header2)
        contentView.addSubview(lastName)
        contentView.addSubview(lineDivider3)

        //Username settings
        contentView.addSubview(header3)
        contentView.addSubview(userName)
        contentView.addSubview(lineDivider4)

        //DOB settings
        //contentView.addSubview(header4)
        //contentView.addSubview(DoBDD)
        //contentView.addSubview(DoBMM)
        //contentView.addSubview(DoBYY)
        contentView.addSubview(lineDivider4)
        contentView.addSubview(saveButton)
        
        
        //---initial textview delagate
        
 

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    //programmically create the objects
    
    let header0:UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.numberOfLines = 1
        label.text = "Company Logo:"
       return label
    }()
    let DP:UIImageView = {
       let image = UIImageView()
        //image.layer.cornerRadius = 50
        //image.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.09803921569)
        //image.layer.borderWidth = 5
        //image.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        image.layer.masksToBounds = true
        image.image = UIImage(named: "man")
        return image
        
    }()
    let DPButton:UIButton = {
       let button = UIButton()
        button.setTitle("Upload Company Photo", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 8
        //button.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        //button.layer.borderWidth = 1
        return button
        
    }()
    
    
    let QR:UIImageView = {
       let image = UIImageView()
        image.layer.cornerRadius = 20
        image.layer.masksToBounds = true
        image.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.09803921569)
        //image.layer.borderWidth = 1
        //image.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        return image
        
    }()
    
    let lineDivider1: UIView = {
        let Line = UIView() // this allows us to assing images.
        Line.backgroundColor =  #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)

        return Line
      }()
    
    
    let header1:UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.numberOfLines = 1
        label.text = "Company Name:"
       return label
    }()
    
    let Name:UITextField = {
       let label = UITextField()
        label.font = UIFont.systemFont(ofSize: 30)
        label.placeholder = "e.g. WSJ"
        label.textAlignment = .left
        return label
        
    }()
    let lineDivider2: UIView = {
        let Line = UIView() // this allows us to assing images.
        Line.backgroundColor =  #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)

        return Line
      }()
    
    
    let header2:UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.numberOfLines = 1
        label.text = "Organisation Type:"

       return label
    }()
    
    let lastName:UITextField = {
       let label = UITextField()
        label.font = UIFont.systemFont(ofSize: 30)
        label.textAlignment = .left
        label.placeholder = "e.g. Ng"
        return label 
        
    }()
    
    let lineDivider3: UIView = {
        let Line = UIView() // this allows us to assing images.
        Line.backgroundColor =  #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)
        return Line
      }()
    
    let header3:UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.numberOfLines = 1
        label.text = "Username:"
       return label
    }()
    
    let userName:UITextField = {
       let label = UITextField()
        label.font = UIFont.systemFont(ofSize: 30)
        label.textAlignment = .left
        label.placeholder = "e.g. JohnNG94"
        return label
        
    }()
    
    let lineDivider4: UIView = {
        let Line = UIView() // this allows us to assing images.
        Line.backgroundColor =  #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)

        return Line
      }()
    
    
    
    let header4:UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.numberOfLines = 1
        label.text = "Date of Birth:"
       return label
    }()
    
    let DoBDD:UITextField = {
       let label = UITextField()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .left
        label.placeholder = "DD"
        label.borderStyle = .roundedRect
        label.keyboardType = .numberPad
        
        return label
        
    }()
    let DoBMM:UITextField = {
       let label = UITextField()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .left
        label.placeholder = "MM"
        label.borderStyle = .roundedRect
        label.keyboardType = .numberPad
        return label
        
    }()
    
    let DoBYY:UITextField = {
       let label = UITextField()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .left
        label.placeholder = "YY"
        label.borderStyle = .roundedRect
        label.keyboardType = .numberPad

        return label
        
    }()
    
    
    let lineDivider5: UIView = {
        let Line = UIView() // this allows us to assing images.
        Line.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)

        return Line
      }()
    
    let saveButton:UIButton = {
       let button = UIButton()
        button.setTitle("Update", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.1218188778, green: 0.5034164786, blue: 0.9990965724, alpha: 1)
        button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)

        //button.layer.borderWidth = 1
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 30
        return button
        
    }()
    


    
}




