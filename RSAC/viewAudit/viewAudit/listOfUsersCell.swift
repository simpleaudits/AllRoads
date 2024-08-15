//
//  listOfUsersCell.swift
//  RSAC
//
//  Created by John on 22/3/2024.
//

import Foundation
import UIKit
import Firebase


class shareButtonCell: UICollectionViewCell{
    
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        

    
        shareButton.frame = CGRect(
            x:0,
            y:0,
            width: frame.width ,
            height: frame.height
        )
        
     
  
        
        addSubview(shareButton)

       
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let shareButton: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .white
        return label
     }()
    
    
    
}




class collectionOfUsers: UICollectionViewCell ,UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    
    var listOfObservationData: [listOfUsers] = []
    
    private let cellID = "list"
    private let joinID = "join"
    
    let mainConsole = CONSOLE()
    let extensConsole = extens()
    
    


    
    func loadData(auditID: String, userUID: String) {
   
            
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
        return CGSize(width: 60, height: collectionView.frame.height)
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
            

            
            Database.database().reference(withPath:"\(items.userURL)")
                            .queryOrderedByKey()
                            .observe(.value, with: { snapshot in
            
                                guard let dict = snapshot.value as? [String:Any] else {
                                    print("Error")
                                    return
                                }
            
            
                                let displayURL = dict["DPimage"] as? String
                                let userName = dict["userName"] as? String
            
            
            
                                //display product owner DP
                                cell.userImage.sd_setImage(with: URL(string:displayURL!))
                                cell.nameLabel.text = userName
            
   
            
                               })
            
            
            
            return cell
        }
    }
        
    

//MARK: - Cell with cell
    

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
        
   
        
        // total height of the cell should be 80, have 10 for padding if need be so 90pt.
        
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
 
        collectionView.translatesAutoresizingMaskIntoConstraints = false
    
        return collectionView
    }()
    
    

    
    
    
    
    
    
    
    
    

    
//MARK: - Call this when no users join
    
    

    class JoinCell: UICollectionViewCell {
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            
            JoinJaffle.frame = CGRect(x:0, 
                                      y: 0,
                                      width: frame.width,
                                      height: frame.width)
            //60
            JoinLabel.frame = CGRect(x: 0, 
                                     y: frame.width ,
                                     width: frame.width,
                                     height: 20)
            
          
            addSubview(JoinJaffle)
            addSubview(JoinLabel)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        
        let JoinJaffle: UIImageView = {
            let userStatus = UIImageView()
            if #available(iOS 13.0, *) {
                userStatus.image = UIImage(systemName: "person.crop.circle.fill.badge.plus")
            } else {
                // Fallback on earlier versions
            }
            userStatus.contentMode = .scaleAspectFill
            userStatus.tintColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            //userStatus.layer.cornerRadius = 17/2
            //userStatus.layer.masksToBounds = true
   
            return userStatus
        }()
        
        let JoinLabel: UILabel = {
             let label = UILabel()
             label.text = "Join"
      
             label.numberOfLines = 2
             label.textAlignment = .center
            //label.backgroundColor = .gray
             label.font = UIFont.systemFont(ofSize: 10)
            //label.font = UIFont(name: "HelveticaNeue-Light", size: 10)
             return label
         }()
        
        
        
    }

    
    class cellData: UICollectionViewCell {
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            
            userImage.frame = CGRect(x:0, 
                                     y: 0,
                                     width: frame.width,
                                     height: frame.width)
            //60
            nameLabel.frame = CGRect(x: 0, 
                                     y: userImage.frame.maxY ,
                                     width: frame.width,
                                     height: 20)
   
            addSubview(userImage)
            addSubview(nameLabel)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        
        let userImage: UIImageView = {
            let userStatus = UIImageView()
            if #available(iOS 13.0, *) {
                userStatus.image = UIImage(systemName: "person.crop.circle.fill.badge.plus")
            } else {
                // Fallback on earlier versions
            }
            userStatus.contentMode = .scaleToFill
            userStatus.tintColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            userStatus.layer.cornerRadius = 20
            userStatus.layer.masksToBounds = true
    
            return userStatus
        }()
        
        let nameLabel: UILabel = {
             let label = UILabel()
             label.text = "Join"
             label.numberOfLines = 1
             label.adjustsFontSizeToFitWidth = false
             label.textAlignment = .center
             //label.backgroundColor = .gray
             label.font = UIFont.systemFont(ofSize: 10)
             //label.font = UIFont(name: "HelveticaNeue-Light", size: 10)
             return label
         }()
    
    }

}










