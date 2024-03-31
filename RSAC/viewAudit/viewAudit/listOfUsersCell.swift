//
//  listOfUsersCell.swift
//  RSAC
//
//  Created by John on 22/3/2024.
//

import Foundation
import UIKit
import Firebase



class collectionOfUsers: UICollectionViewCell ,UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    
    var listOfObservationData: [listOfUsers] = []
    
    private let cellID = "list"
    private let joinID = "join"
    
    let mainConsole = CONSOLE()
    let extensConsole = extens()
    
    


    
    func loadData(auditID: String, userUID: String) {
        print("fire")
            
            let uid = Auth.auth().currentUser?.uid
            
            if userUID != uid!{
                
                let reftest = Database.database().reference()
                    .child("\(self.mainConsole.prod!)")
                let auditData = reftest
                    .child("\(self.mainConsole.post!)")
                    .child("\(userUID)")
                    .child("\(self.mainConsole.audit!)")
                    .child("\(auditID)")
                    .child("\(self.mainConsole.userCollaborationList!)")
                
                
               
                
                auditData.queryOrderedByKey()
                    .observe(.value, with: { snapshot in
                        
                        var listOfObservationData: [listOfUsers] = []
                        
                        for child in snapshot.children {
                            if let snapshot = child as? DataSnapshot,
                               let listOfUsers = listOfUsers(snapshot: snapshot) {
                                listOfObservationData.append(listOfUsers)
                                
                                print("protocolA:\(listOfObservationData)")
                                print("protocolA:\(userUID)")
                   
                            }
                        }
                        self.listOfObservationData = listOfObservationData
                        self.collectionView.reloadData()
                        
          
                        
                    })
                
            }else{
                
                let reftest = Database.database().reference()
                    .child("\(self.mainConsole.prod!)")
                let auditData = reftest
                    .child("\(self.mainConsole.post!)")
                    .child("\(uid!)")
                    .child("\(self.mainConsole.audit!)")
                    .child("\(auditID)")
                    .child("\(self.mainConsole.userCollaborationList!)")
                
          
              
                
                auditData.queryOrderedByKey()
                    .observe(.value, with: { snapshot in
                        
                        var listOfObservationData: [listOfUsers] = []
                        
                        for child in snapshot.children {
                            if let snapshot = child as? DataSnapshot,
                               let listOfUsers = listOfUsers(snapshot: snapshot) {
                                listOfObservationData.append(listOfUsers)
                                
                                print("protocolA:\(listOfObservationData)")
                                print("protocolA:\(userUID)")
          
                            }
                        }
                        self.listOfObservationData = listOfObservationData
                        self.collectionView.reloadData()
       
                        
                    })
            }
        
    }
    
    
  

    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: collectionView.frame.height)
    }
    
    

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        if listOfObservationData.count == 0 {
        return 1
            
        }else {
            
        return listOfObservationData.count
            
        }
     
       
    
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
 
        
        if indexPath.row  == listOfObservationData.count {
            let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: joinID, for: indexPath) as! JoinCell
            return cell
            
        }else{
            
            
            let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! cellData
            let items = listOfObservationData[indexPath.row]
            
            
            cell.userImage.layer.masksToBounds = true;
            cell.userImage.layer.cornerRadius = cell.userImage.frame.height/2
            
            cell.nameLabel.layer.masksToBounds = true;
            cell.nameLabel.layer.cornerRadius = cell.nameLabel.frame.height/2
            
            
            Database.database().reference(withPath:"\(items.userURL)")
                            .queryOrderedByKey()
                            .observe(.value, with: { snapshot in
            
                                guard let dict = snapshot.value as? [String:Any] else {
                                    print("Error")
                                    return
                                }
            
            
                                let displayURL = dict["DPimage"] as? String
                                let username = dict["Username"] as? String
            
            
            
                                //display product owner DP
                                cell.userImage.sd_setImage(with: URL(string:displayURL!))
                                cell.nameLabel.text = username
            
   
            
                               })
            
            
            
            return cell
        }
    }
        

    override init(frame: CGRect) {
        super .init(frame: frame)
        // initialise all objects
        loadListOfUserData(userUID:UserDefaults.standard.string(forKey: "userUID")!, auditID:UserDefaults.standard.string(forKey: "auditID")!)
        
       
    
        
        
        collectionView.register(cellData.self, forCellWithReuseIdentifier: cellID)
        collectionView.register(JoinCell.self, forCellWithReuseIdentifier: joinID)
        
        collectionView.dataSource = self
        collectionView.delegate = self
  

        collectionView.frame = CGRect(
            x: 0,
            y: 0,
            width: frame.width,
            height: frame.height)
       

        
        addSubview(collectionView)

    }
    
    func loadListOfUserData(userUID:String, auditID:String){
        
        let uid = Auth.auth().currentUser?.uid
        
        if userUID != uid!{
            
            let reftest = Database.database().reference()
                .child("\(self.mainConsole.prod!)")
            let auditData = reftest
                .child("\(self.mainConsole.post!)")
                .child("\(userUID)")
                .child("\(self.mainConsole.audit!)")
                .child("\(auditID)")
                .child("\(self.mainConsole.userCollaborationList!)")
            
            
           
            
            auditData.queryOrderedByKey()
                .observe(.value, with: { [self] snapshot in
                    
                    var listOfObservationData: [listOfUsers] = []
                    
                    for child in snapshot.children {
                        if let snapshot = child as? DataSnapshot,
                           let listOfUsers = listOfUsers(snapshot: snapshot) {
                            listOfObservationData.append(listOfUsers)
                            
               
                        }
                    }
                    self.listOfObservationData = listOfObservationData
                    collectionView.reloadData()
                    
      
                    
                })
            
        }else{
            
            let reftest = Database.database().reference()
                .child("\(self.mainConsole.prod!)")
            let auditData = reftest
                .child("\(self.mainConsole.post!)")
                .child("\(uid!)")
                .child("\(self.mainConsole.audit!)")
                .child("\(auditID)")
                .child("\(self.mainConsole.userCollaborationList!)")
            
      
          
            
            auditData.queryOrderedByKey()
                .observe(.value, with: { [self] snapshot in
                    
                    var listOfObservationData: [listOfUsers] = []
                    
                    for child in snapshot.children {
                        if let snapshot = child as? DataSnapshot,
                           let listOfUsers = listOfUsers(snapshot: snapshot) {
                            listOfObservationData.append(listOfUsers)
      
                        }
                    }
                    self.listOfObservationData = listOfObservationData
                    collectionView.reloadData()
                    
   
                    
                })
        }
        
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
    

    class JoinCell: UICollectionViewCell {
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            
            JoinJaffle.frame = CGRect(x:0, y: 0, width: frame.width, height: frame.width)
            //60
            JoinLabel.frame = CGRect(x: 0, y: frame.width , width: frame.width, height: 20)
            
          
            addSubview(JoinJaffle)
            addSubview(JoinLabel)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        
        let JoinJaffle: UIImageView = {
            let userStatus = UIImageView()
            if #available(iOS 13.0, *) {
                userStatus.image = UIImage(imageLiteralResourceName: "man")
            } else {
                // Fallback on earlier versions
            }
            userStatus.contentMode = .scaleAspectFill
            //userStatus.layer.cornerRadius = 17/2
            //userStatus.layer.masksToBounds = true
            userStatus.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            return userStatus
        }()
        
        let JoinLabel: UILabel = {
             let label = UILabel()
             label.text = "Join"
      
             label.numberOfLines = 2
             label.textAlignment = .center
        
             label.font = UIFont(name: "HelveticaNeue-Light", size: 10)
             return label
         }()
        
        
        
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
             label.numberOfLines = 1
             label.textAlignment = .center
             //label.backgroundColor = .gray
             //label.font = UIFont(name: "HelveticaNeue-Light", size: 10)
             return label
         }()
    
    }

}










