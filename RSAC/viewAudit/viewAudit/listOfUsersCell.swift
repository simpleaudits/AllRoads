//
//  listOfUsersCell.swift
//  RSAC
//
//  Created by John on 22/3/2024.
//

import Foundation
import UIKit


class collectionOfUsers: UICollectionViewCell ,UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    
    var listOfObservationData: [auditSiteData] = []
 
    override init(frame: CGRect) {
        super .init(frame: frame)
        // initialise all objects
        
     

        collectionView.frame = CGRect(
            x: 0,
            y: 0,
            width: frame.width,
            height: frame.height)
       
        
        contentView.addSubview(collectionView)
        
        collectionView.register(cellData.self, forCellWithReuseIdentifier: "cellData")
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // collectionview here
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: collectionView.frame.height)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
//        if listOfObservationData.count == 0 {
//        return 3
//
//        }else {
//
//        return listOfObservationData.count
//
//        }
        return 16
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
 
        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellData", for: indexPath) as! cellData
      
//            cell.imageView.layer.masksToBounds = true;
//            cell.imageView.layer.cornerRadius = cell.imageView.frame.height/2
//
//            cell.usernameLabel.layer.masksToBounds = true;
//            cell.usernameLabel.layer.cornerRadius = cell.usernameLabel.frame.height/2
        
//            let UserList = listOfObservationData[indexPath.row]
//
//            Database.database().reference(withPath:"\(ParentJSON.Parent!)/\(UserList.SlotUser)")
//                .queryOrderedByKey()
//                .observeSingleEvent(of: .value, with: { snapshot in
//
//                    guard let dict = snapshot.value as? [String:Any] else {
//                        print("Error")
//                        return
//                    }
//
//
//                    let displayURL = dict["DPimage"] as? String
//                    let userStatusString = dict["userStatusString"] as? String
//                    let username = dict["UsernameString"] as? String
//
//
//
//                    //display product owner DP
//                    cell.imageView.sd_setImage(with: URL(string:displayURL!))
//                    cell.usernameLabel.text = username!
//
//
//
//
//
//
//                   })
    

  
        return cell
        }
        
    
    
    
    
    class cellData: UICollectionViewCell {
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            
            userImage.frame = CGRect(x:0, y: 0, width: frame.width, height: frame.width)
            //60
            nameLabel.frame = CGRect(x: 0, y: frame.width , width: frame.width, height: 20)
   
            addSubview(userImage)
            addSubview(nameLabel)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        
        let userImage: UIImageView = {
            let userStatus = UIImageView()
            if #available(iOS 13.0, *) {
                userStatus.image = UIImage(imageLiteralResourceName: "man")
            } else {
                // Fallback on earlier versions
            }
            userStatus.contentMode = .scaleAspectFit
            //userStatus.layer.cornerRadius = 17/2
            //userStatus.layer.masksToBounds = true
            userStatus.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            return userStatus
        }()
        
        let nameLabel: UILabel = {
             let label = UILabel()
             label.text = "Join"
      
             label.numberOfLines = 2
             label.textAlignment = .center
             //label.backgroundColor = .gray
             //label.font = UIFont(name: "HelveticaNeue-Light", size: 10)
             return label
         }()
    
    }

}










