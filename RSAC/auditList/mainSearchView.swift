//
//  mainSearchView.swift
//  dbtestswift
//
//  Created by macbook on 15/4/22.
//  Copyright © 2022 macbook. All rights reserved.
//

import UIKit
import Firebase
import MapKit
import SDWebImage
import SwiftLoader

 

class mainSearchView: UICollectionViewController,UICollectionViewDelegateFlowLayout,MKMapViewDelegate  {
    
    //Rows in each section, these are subject to change.
        var SectionCount:Int = 3

        var rowsInSection1:Int = 3
        var rowsInSection2:Int = 10
        var rowsInSection3:Int = 5
        var rowsInSection4:Int = 5
    //    var rowsInSection5:Int = 1
    //    var rowsInSection6:Int = 1
    
    

    var listingData = Int()
    var auditData: [newAuditDataset] = []
    var CompletedAuditsFilter: [newAuditDataset] = []
    var InProgressAuditsAuditsFilter: [newAuditDataset] = []
    var ArchievedAuditsFilter: [newAuditDataset] = []


    let mainConsole = CONSOLE()
    let extensConsole = extens()
    let firebaseConsole = saveLocal()

    
        var auditID = String()
        var projectName = String()

    
    @objc func action(sender: UIBarButtonItem) {
        // Function body goes here
    }
    
    
    
    func loadUserStats(){

        
                 let uid = Auth.auth().currentUser?.uid
                 let reftest = Database.database().reference()
                     .child("\(mainConsole.prod!)")
                     .child("\(mainConsole.post!)")
                     .child(uid!)
                     .child("\(mainConsole.userDetails!)")
                 
                 reftest.queryOrderedByKey()
                     .observe( .value, with: { snapshot in
                               guard let dict = snapshot.value as? [String:Any] else {
                               //error here
                               return
                               }

                                let listingMax = dict["listingMax"] as? Int
                                self.listingData = listingMax!
                  
                                
  
                   })
        
     
    }
    
    
    
    override func viewDidLoad() {
        

        //load the number of listing the user can actually make here:
        loadUserStats()
        
  
        

        
        loadAudits()
        
        collectionView?.register(auditCell.self, forCellWithReuseIdentifier: "auditCell")
        collectionView?.register(auditHeader.self, forSupplementaryViewOfKind: "auditHeader", withReuseIdentifier: "auditHeader")
        
        
        self.collectionView.collectionViewLayout = createLayout()
        
        
//        let scrollDirection = UICollectionViewFlowLayout()
//        scrollDirection.scrollDirection = .horizontal
//        self.collectionView.collectionViewLayout = scrollDirection
        
        super.viewDidLoad()
        
     
        

    }

    
    
    override func viewDidDisappear(_ animated: Bool) {

 
    }
    
    override func viewDidAppear(_ animated: Bool) {


 
        
        
    }
    // MARK: UICollectionViewDataSource

    

    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return SectionCount
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        switch section {
            case 0:
            //family
            return CompletedAuditsFilter.count

            case 1:
            //music
            return InProgressAuditsAuditsFilter.count
       
            case 2:
            //movies
       
            return ArchievedAuditsFilter.count


            default:
            return 0

        }
    }



    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        if indexPath.section == 0{
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "auditHeader", for: indexPath) as! auditHeader

            sectionHeader.headerName.text =  mainConsole.complete
     
            return sectionHeader
     
        }else if indexPath.section == 1 {
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "auditHeader", for: indexPath) as! auditHeader

            sectionHeader.headerName.text = mainConsole.progress
       
            return sectionHeader
            
     
        }else{
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "auditHeader", for: indexPath) as! auditHeader

            sectionHeader.headerName.text = mainConsole.archived
   
            return sectionHeader
                                
 
        }
        
    }

    

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
  
        if indexPath.section  == 0 {
            let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: "auditCell", for: indexPath) as! auditCell
            
        
            let auditData = CompletedAuditsFilter[indexPath.row]
            cell.projectName.text = auditData.projectName
        
            let transforImageSize = SDImageResizingTransformer(size: CGSize(width: 500, height: 500), scaleMode: .fill)
            cell.imageUI.sd_setImage(with: URL(string:auditData.locationImageURL), placeholderImage: nil, context: [.imageTransformer:transforImageSize])
    
            
            cell.layer.cornerRadius = 8
            cell.layer.masksToBounds = true
            return cell
            
            
        }else if indexPath.section  == 1 {
            let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: "auditCell", for: indexPath) as! auditCell
            
            let auditData = InProgressAuditsAuditsFilter[indexPath.row]
            cell.projectName.text = auditData.projectName
            
            
            let transforImageSize = SDImageResizingTransformer(size: CGSize(width: 500, height: 500), scaleMode: .fill)
            cell.imageUI.sd_setImage(with: URL(string:auditData.locationImageURL), placeholderImage: nil, context: [.imageTransformer:transforImageSize])
          
            
            cell.layer.cornerRadius = 8
            cell.layer.masksToBounds = true
            
            return cell
            
            
        }else{
        
            let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: "auditCell", for: indexPath) as! auditCell
            
            let auditData = ArchievedAuditsFilter[indexPath.row]
            cell.projectName.text = auditData.projectName
              
            
            let transforImageSize = SDImageResizingTransformer(size: CGSize(width: 150, height: 150), scaleMode: .fill)
            cell.imageUI.sd_setImage(with: URL(string:auditData.locationImageURL), placeholderImage: nil, context: [.imageTransformer:transforImageSize])
            
            cell.layer.cornerRadius = 8
            cell.layer.masksToBounds = true
            
            return cell
            
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      
        if indexPath.section  == 0 {
         
            let auditData = CompletedAuditsFilter[indexPath.row]
            
            let Alert1 = UIAlertController(title: "Audit Name:\n\(auditData.projectName)", message: "Audit Reference:\n\(auditData.auditID)", preferredStyle: .actionSheet)
                        let action1 = UIAlertAction(title: "View audit",style: .default) { (action:UIAlertAction!) in
                            //save this for headerview in view item
                            self.performSegue(withIdentifier: "viewItemDetails", sender: indexPath.row);

                        }
            let action2 = UIAlertAction(title: "Mark As Archived",style: .default) { [self] (action:UIAlertAction!) in
                            //save this for headerview in view item
                            self.firebaseConsole.updateAuditProgress(auditProgress: mainConsole.archived!, auditID: auditID)

                        }
            let action4 = UIAlertAction(title: "Mark As In-Progress",style: .default) { [self] (action:UIAlertAction!) in
                            //save this for headerview in view item
                            self.firebaseConsole.updateAuditProgress(auditProgress: mainConsole.progress!, auditID: auditID)
                            
                        }
            let action5 = UIAlertAction(title: "Mark As Complete",style: .default) { [self] (action:UIAlertAction!) in
                            //save this for headerview in view item
                            self.firebaseConsole.updateAuditProgress(auditProgress: mainConsole.complete!, auditID: auditID)
                            
                        }
            
                            let action3 = UIAlertAction(title: "Cancel",style: .cancel) { (action:UIAlertAction!) in
                        }
           

            Alert1.addAction(action1)
            Alert1.addAction(action2)
            Alert1.addAction(action3)
            Alert1.addAction(action4)
            Alert1.addAction(action5)

            self.present(Alert1, animated: true, completion: nil)
            self.auditID = auditData.auditID
            self.projectName = auditData.projectName
            
            let uid = Auth.auth().currentUser?.uid
            UserDefaults.standard.set(  self.auditID, forKey: "auditID") //setObject
            UserDefaults.standard.set(  uid, forKey: "userUID") //setObject

    
            
        }else if indexPath.section == 1{
            
            let auditData = InProgressAuditsAuditsFilter[indexPath.row]
            
            let Alert2 = UIAlertController(title: "Audit Name:\n\(auditData.projectName)", message: "Audit Reference:\n\(auditData.auditID)", preferredStyle: .actionSheet)
                        let action1 = UIAlertAction(title: "View audit",style: .default) { (action:UIAlertAction!) in
                            //save this for headerview in view item
                            self.performSegue(withIdentifier: "viewItemDetails", sender: indexPath.row);

                        }
            let action2 = UIAlertAction(title: "Mark As Archived",style: .default) { [self] (action:UIAlertAction!) in
                            //save this for headerview in view item
                            self.firebaseConsole.updateAuditProgress(auditProgress: mainConsole.archived!, auditID: auditID)
                
                        }
            let action4 = UIAlertAction(title: "Mark As In-Progress",style: .default) { [self] (action:UIAlertAction!) in
                            //save this for headerview in view item
                            self.firebaseConsole.updateAuditProgress(auditProgress: mainConsole.progress!, auditID: auditID)
                            
                        }
            let action5 = UIAlertAction(title: "Mark As Complete",style: .default) { [self] (action:UIAlertAction!) in
                            //save this for headerview in view item
                            self.firebaseConsole.updateAuditProgress(auditProgress: mainConsole.complete!, auditID: auditID)
                            
                        }
            
                            let action3 = UIAlertAction(title: "Cancel",style: .cancel) { (action:UIAlertAction!) in
                        }
           
            Alert2.addAction(action1)
            Alert2.addAction(action2)
            Alert2.addAction(action3)
            Alert2.addAction(action4)
            Alert2.addAction(action5)

            self.present(Alert2, animated: true, completion: nil)
            self.auditID = auditData.auditID
            self.projectName = auditData.projectName
            
            let uid = Auth.auth().currentUser?.uid
            UserDefaults.standard.set(  self.auditID, forKey: "auditID") //setObject
            UserDefaults.standard.set(  uid, forKey: "userUID") //setObject

            
        }else{
            
            let auditData = ArchievedAuditsFilter[indexPath.row]
            
            let Alert3 = UIAlertController(title: "Audit Name:\n\(auditData.projectName)", message: "Audit Reference:\n\(auditData.auditID)", preferredStyle: .actionSheet)
                        let action1 = UIAlertAction(title: "View audit",style: .default) { (action:UIAlertAction!) in
                            //save this for headerview in view item
                            self.performSegue(withIdentifier: "viewItemDetails", sender: indexPath.row);

                        }
            let action2 = UIAlertAction(title: "Mark As Archived",style: .default) { [self] (action:UIAlertAction!) in
                            //save this for headerview in view item
                            self.firebaseConsole.updateAuditProgress(auditProgress: mainConsole.archived!, auditID: auditID)
                
                        }
            let action4 = UIAlertAction(title: "Mark As In-Progress",style: .default) { [self] (action:UIAlertAction!) in
                            //save this for headerview in view item
                            self.firebaseConsole.updateAuditProgress(auditProgress: mainConsole.progress!, auditID: auditID)
                            
                        }
            let action5 = UIAlertAction(title: "Mark As Complete",style: .default) { [self] (action:UIAlertAction!) in
                            //save this for headerview in view item
                            self.firebaseConsole.updateAuditProgress(auditProgress: mainConsole.complete!, auditID: auditID)
                            
                        }
            
                            let action3 = UIAlertAction(title: "Cancel",style: .cancel) { (action:UIAlertAction!) in
                        }
           
            Alert3.addAction(action1)
            Alert3.addAction(action2)
            Alert3.addAction(action3)
            Alert3.addAction(action4)
            Alert3.addAction(action5)

            self.present(Alert3, animated: true, completion: nil)
            self.auditID = auditData.auditID
            self.projectName = auditData.projectName
            
            let uid = Auth.auth().currentUser?.uid
            UserDefaults.standard.set(  self.auditID, forKey: "auditID") //setObject
            UserDefaults.standard.set(  uid, forKey: "userUID") //setObject
      

            
        }
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let uid = Auth.auth().currentUser?.uid
        // Since this is the registered user, we will apply this nsuserdeful directly
        print("NSUSER_AuditID_enter:\(UserDefaults.standard.string(forKey: "auditID")!)")
        print("NSUSER_userUID_enter:\(UserDefaults.standard.string(forKey: "userUID")!)")

        
             if let viewInfoView = segue.destination as?  viewAuditList{

                 if auditID != ""{
               
                     viewInfoView.auditID = auditID
                     viewInfoView.projectName  = projectName
                     viewInfoView.userUID = "\(uid!)"
                     
          
                 
                     
                 }else{
                     
                 }

             }
         }
    
    
    
    
    @IBAction func addProject(_ sender: Any) {
        
        if auditData.count < listingData{
            self.performSegue(withIdentifier: "addProject", sender: self);
        }else{
            
            let Alert = UIAlertController(title: "One second..", message: "You've reached your max project listing of: \(listingData)", preferredStyle: .alert)
            
            let action1 = UIAlertAction(title: "OK",style: .default) { (action:UIAlertAction!) in
                //save this for headerview in view item
               
            }
            
            
            let action3 = UIAlertAction(title: "Cancel",style: .cancel) { (action:UIAlertAction!) in}
            
            
            Alert.addAction(action1)
            Alert.addAction(action3)
        
            self.present(Alert, animated: true, completion: nil)
            
            
        }
    }
        
 
    
    
    
    
    

    func createLayout() -> UICollectionViewCompositionalLayout{
        //Compositional layout
        let layout = UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            
            if sectionNumber  == 0 {
                
               
                    let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1/2), heightDimension: .fractionalHeight(1)))
                        item.contentInsets.trailing = 20
                        item.contentInsets.leading = 20
                        //item.contentInsets.top = 20
                    let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .absolute(200)),
                        subitems: [item])
            

                        let section = NSCollectionLayoutSection(group: group)
                        section.orthogonalScrollingBehavior = .groupPaging
                
                
                        section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension:.absolute(50) ), elementKind: "auditHeader", alignment: .topLeading)]
                
                        section.contentInsets.leading = 10
                
                
                        return section

            }else if sectionNumber  == 1 {
                
                
                     let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1/2), heightDimension: .fractionalHeight(1)))
                         item.contentInsets.trailing = 20
                         item.contentInsets.leading = 20
                         //item.contentInsets.top = 20
                     let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(
                         widthDimension: .fractionalWidth(1),
                         heightDimension: .absolute(200)),
                         subitems: [item])
             

                         let section = NSCollectionLayoutSection(group: group)
                         section.orthogonalScrollingBehavior = .groupPaging
                 
                 
                         section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension:.absolute(50) ), elementKind: "auditHeader", alignment: .topLeading)]
                 
                         section.contentInsets.leading = 10
                 
                 
                         return section

            }else if sectionNumber == 2 {
                
                
                     let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1/2), heightDimension: .fractionalHeight(1)))
                         item.contentInsets.trailing = 20
                         item.contentInsets.leading = 20
                         //item.contentInsets.top = 20
                     let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(
                         widthDimension: .fractionalWidth(1),
                         heightDimension: .absolute(200)),
                         subitems: [item])
             

                         let section = NSCollectionLayoutSection(group: group)
                         section.orthogonalScrollingBehavior = .groupPaging
                 
                 
                         section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension:.absolute(50) ), elementKind: "auditHeader", alignment: .topLeading)]
                 
                         section.contentInsets.leading = 10
                 
                 
                         return section

            }else{
                
                
                     let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1/2), heightDimension: .fractionalHeight(1)))
                         item.contentInsets.trailing = 20
                         item.contentInsets.leading = 20
                         //item.contentInsets.top = 20
                     let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(
                         widthDimension: .fractionalWidth(1),
                         heightDimension: .absolute(200)),
                         subitems: [item])
             

                         let section = NSCollectionLayoutSection(group: group)
                         section.orthogonalScrollingBehavior = .groupPaging
                 
                 
                         section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension:.absolute(50) ), elementKind: "auditHeader", alignment: .topLeading)]
                 
                         section.contentInsets.leading = 10
                 
                 
                         return section
       }
        }
            
        return layout
    }

}
