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

 

class mainSearchView: UICollectionViewController,UICollectionViewDelegateFlowLayout,MKMapViewDelegate  {
    
    //Rows in each section, these are subject to change.
        var SectionCount:Int = 3

        var rowsInSection1:Int = 3
        var rowsInSection2:Int = 10
        var rowsInSection3:Int = 5
        var rowsInSection4:Int = 5
    //    var rowsInSection5:Int = 1
    //    var rowsInSection6:Int = 1
    

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
    
    
    
    override func viewDidLoad() {
        

        
        collectionView?.register(auditCell.self, forCellWithReuseIdentifier: "auditCell")
        collectionView?.register(auditHeader.self, forSupplementaryViewOfKind: "auditHeader", withReuseIdentifier: "auditHeader")
        
        
        self.collectionView.collectionViewLayout = createLayout()
        
        
//        let scrollDirection = UICollectionViewFlowLayout()
//        scrollDirection.scrollDirection = .horizontal
//        self.collectionView.collectionViewLayout = scrollDirection
        
        super.viewDidLoad()
        
        loadAudits()
        

    }

    override func viewDidDisappear(_ animated: Bool) {
        print("YES")
        auditData.removeAll()

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
        
           
            
            //map reference
            let annotation = MKPointAnnotation()
            let centerCoordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(auditData.lat), longitude:CLLocationDegrees(auditData.long))
            annotation.coordinate = centerCoordinate
            //annotation.title = ItemName
            //cell.mapUI.addAnnotation(annotation)
            
            let mapCenter = CLLocationCoordinate2DMake(CLLocationDegrees(auditData.lat), CLLocationDegrees(auditData.long))
            let span = MKCoordinateSpan.init(latitudeDelta: 0.001, longitudeDelta: 0.001)
            let region = MKCoordinateRegion.init(center: mapCenter, span: span)
            //mapview.region = region
            cell.mapUI.setRegion(region, animated: false)
            
            
            
            cell.layer.cornerRadius = 8
            cell.layer.masksToBounds = true
            return cell
            
            
        }else if indexPath.section  == 1 {
            let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: "auditCell", for: indexPath) as! auditCell
            
            let auditData = InProgressAuditsAuditsFilter[indexPath.row]
            cell.projectName.text = auditData.projectName
        
           
            
            //map reference
            let annotation = MKPointAnnotation()
            let centerCoordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(auditData.lat), longitude:CLLocationDegrees(auditData.long))
            annotation.coordinate = centerCoordinate
            //annotation.title = ItemName
            //cell.mapUI.addAnnotation(annotation)
            
            let mapCenter = CLLocationCoordinate2DMake(CLLocationDegrees(auditData.lat), CLLocationDegrees(auditData.long))
            let span = MKCoordinateSpan.init(latitudeDelta: 0.001, longitudeDelta: 0.001)
            let region = MKCoordinateRegion.init(center: mapCenter, span: span)
            //mapview.region = region
            cell.mapUI.setRegion(region, animated: true)
            
            
            
            cell.layer.cornerRadius = 8
            cell.layer.masksToBounds = true
            
            return cell
            
            
        }else{
        
            let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: "auditCell", for: indexPath) as! auditCell
            
            let auditData = ArchievedAuditsFilter[indexPath.row]
            cell.projectName.text = auditData.projectName
        
           
            
            //map reference
            let annotation = MKPointAnnotation()
            let centerCoordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(auditData.lat), longitude:CLLocationDegrees(auditData.long))
            annotation.coordinate = centerCoordinate
            //annotation.title = ItemName
            //cell.mapUI.addAnnotation(annotation)
            
            let mapCenter = CLLocationCoordinate2DMake(CLLocationDegrees(auditData.lat), CLLocationDegrees(auditData.long))
            let span = MKCoordinateSpan.init(latitudeDelta: 0.001, longitudeDelta: 0.001)
            let region = MKCoordinateRegion.init(center: mapCenter, span: span)
            //mapview.region = region
            cell.mapUI.setRegion(region, animated: true)
            
            
            
            cell.layer.cornerRadius = 8
            cell.layer.masksToBounds = true
            
            return cell
            
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      


        
       // DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {self.performSegue(withIdentifier: "gameSettings", sender: indexPath.row);}
        
        if indexPath.section  == 0 {
         
            let auditData = CompletedAuditsFilter[indexPath.row]
            
            let Alert = UIAlertController(title: "You have selected:/n\(auditData.projectName)", message: "ref\(auditData.auditID)", preferredStyle: .alert)
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
           

            Alert.addAction(action1)
            Alert.addAction(action2)
            Alert.addAction(action3)
            Alert.addAction(action4)
            Alert.addAction(action5)

            self.present(Alert, animated: true, completion: nil)
            self.auditID = auditData.auditID
            self.projectName = auditData.projectName
    
            
        }else if indexPath.section == 1{
            
            let auditData = InProgressAuditsAuditsFilter[indexPath.row]
            
            let Alert = UIAlertController(title: "You have selected", message: "\(auditData.projectName)", preferredStyle: .alert)
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
           
            Alert.addAction(action1)
            Alert.addAction(action2)
            Alert.addAction(action3)
            Alert.addAction(action4)
            Alert.addAction(action5)

            self.present(Alert, animated: true, completion: nil)
            self.auditID = auditData.auditID
            self.projectName = auditData.projectName
            
        }else if indexPath.section == 2{
            
            let auditData = ArchievedAuditsFilter[indexPath.row]
            
            let Alert = UIAlertController(title: "You have selected", message: "\(auditData.projectName)", preferredStyle: .alert)
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
           

            Alert.addAction(action1)
            Alert.addAction(action2)
            Alert.addAction(action3)
            Alert.addAction(action4)
            Alert.addAction(action5)

            self.present(Alert, animated: true, completion: nil)
            self.auditID = auditData.auditID
            self.projectName = auditData.projectName

            
        }else{
            
        }
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
             if let viewInfoView = segue.destination as?  viewAuditList{

                 if auditID != ""{
                     viewInfoView.auditID = auditID
                     viewInfoView.projectName  = projectName
                 }else{
                     
                 }

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
