//
//  listOfUsersCell.swift
//  dbtestswift
//
//  Created by macbook on 19/11/19.
//  Copyright © 2019 macbook. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class viewSiteStage: UICollectionViewCell ,UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    private let cellID = "cell"
    
    let stage = ["a","b"]
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 40, height: frame.height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return stage.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row  == 1 {
            let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! statusCell
            let data = stage[indexPath.row]
            cell.backgroundColor = .red
            cell.statusLabel.text = data
            
            return cell
        }else{
            let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! statusCell
            cell.backgroundColor = .red
            return cell
        }
        
        
        
    }


    
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        statusCollectionView.register(statusCell.self, forCellWithReuseIdentifier: cellID)
        
        statusCollectionView.dataSource = self
        statusCollectionView.delegate = self
    
        dividerLineView.frame = CGRect(
            x:0,
            y:0,
            width: frame.width ,
            height: 1
        )
        
     
        statusCollectionView.frame = CGRect(
            x:0,
            y:0,
            width: frame.width ,
            height: frame.height
        )
 
        
        addSubview(statusCollectionView)

       
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    //lets create the collectionview for this cell.
    let statusCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView

    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()


    
    
}

    
class statusCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)

        statusLabel.frame = CGRect(
            x: 0,
            y: frame.height/2 + 35,
            width: frame.width,
            height: frame.height)

        addSubview(statusLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    let statusLabel: UILabel = {
         let label = UILabel()
         label.text = "1"
         label.numberOfLines = 2
         label.textAlignment = .center
         label.font = UIFont(name: "HelveticaNeue-Light", size: 10)
         return label
     }()
    
    
    
}

    

 
    
    



    
    
    
    

