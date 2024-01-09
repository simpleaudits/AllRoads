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
import SwiftLoader
 

class viewAuditList: UICollectionViewController,UICollectionViewDelegateFlowLayout,MKMapViewDelegate  {
    
    // configure the section
    let mapSection = 0
    let auditListSection = 1
    let archievedSection = 2
    
    //Rows in each section, these are subject to change.
        var SectionCount:Int = 3

        var rowsInSection1:Int = 3
        var rowsInSection2:Int = 10
        var rowsInSection3:Int = 5
        var rowsInSection4:Int = 5



        var CellHeight: CGFloat = 80
        var padding: CGFloat = 16

        var auditID = String()
        var siteID = String()
        var projectName = String()
        var refData = String()
    
    
    
        let mainConsole = CONSOLE()
        let extensConsole = extens()
        let firebaseConsole = saveLocal()
        var listOfSites: [createSiteData] = [] // for the favourites
        var CompletedAuditsFilter: [createSiteData] = []
        var ArchievedAuditsFilter: [createSiteData] = []
    
    
        var listOfSitesData: [auditSiteData] = []
    
    
    override func viewDidLoad() {

        super.viewDidLoad()
        
        loadAuditSnapshots()

 
        self.collectionView?.register(auditHeader.self, forSupplementaryViewOfKind: "auditHeader", withReuseIdentifier: "auditHeader")
        self.collectionView?.register(viewAuditCell.self, forCellWithReuseIdentifier: "viewAuditCell")
        self.collectionView?.register(viewAuditHeaderMap.self, forCellWithReuseIdentifier: "viewAuditHeaderMap")
        
        
        self.collectionView.collectionViewLayout = createLayout()
        
        self.navigationItem.title = projectName


    }
    
    
    
    //Get data from the favourites list
    //---------------------------------------------------------------------------------------------------------------------

        func loadAuditSnapshots(){
            
            SwiftLoader.show(title: "Loading Data", animated: true)
            
            let uid = Auth.auth().currentUser?.uid
            
                //we want to get the database reference
                let reftest = Database.database().reference()
                    .child("\(self.mainConsole.prod!)")
                let auditData = reftest
                    .child("\(self.mainConsole.post!)")
                    .child(uid!)
                    .child("\(self.mainConsole.audit!)")
                    .child("\(auditID)")
                    .child("\(self.mainConsole.siteList!)")
            
            
            auditData.queryOrderedByKey()
                .observe(.value, with: { [self] snapshot in
                        
                    var NewlistOfSites: [createSiteData] = []
                        
                        for child in snapshot.children {
                            if let snapshot = child as? DataSnapshot,
                                let listOfSites = createSiteData(snapshot: snapshot) {
                                NewlistOfSites.append(listOfSites)
                           

            
                            }
                        }
                        self.listOfSites = NewlistOfSites
                        SwiftLoader.hide()
                        
                        //all true completed
                        self.CompletedAuditsFilter = self.listOfSites.filter(
                            {return $0.status.localizedCaseInsensitiveContains("In-Progress Audits") })
                        print("CompletedAuditsFilter:\(self.CompletedAuditsFilter.count)")

                        //all false completed
                        self.ArchievedAuditsFilter = self.listOfSites.filter(
                            {return $0.status.localizedCaseInsensitiveContains("Archived") })
                        print("ArchievedAuditsFilter:\(self.ArchievedAuditsFilter.count)")
                        
                        self.collectionView.reloadData()
          
                        
             
             
                    })
                
        
            }
    
    func observationSnapshotCount(auditID: String, siteID : String) -> Int{
    
        let uid = Auth.auth().currentUser?.uid
            //we want to get the database reference
            let reftest = Database.database().reference()
                .child("\(self.mainConsole.prod!)")
            let auditData = reftest
                .child("\(self.mainConsole.post!)")
                .child(uid!)
                .child("\(self.mainConsole.audit!)")
                .child("\(auditID)")
                .child("\(self.mainConsole.siteList!)")
                .child("\(siteID)")
                .child("\(self.mainConsole.auditList!)")
        
        auditData.queryOrderedByKey()
            .observeSingleEvent(of: .value, with: { snapshot in
                    var listOfSitesData: [auditSiteData] = []
                    for child in snapshot.children {
                        if let snapshot = child as? DataSnapshot,
                            let listOfSites = auditSiteData(snapshot: snapshot) {
                            listOfSitesData.append(listOfSites)
                        }
                    }
                    self.listOfSitesData = listOfSitesData
                    
                    SwiftLoader.hide()
                    self.collectionView.reloadData()
      
                
                })
            
        return self.listOfSitesData.count
        }
        
            

    override func viewDidDisappear(_ animated: Bool) {
        print("YES")


    }
    
    override func viewDidAppear(_ animated: Bool) {

      
        
     

 
        
        
    }
 


    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return SectionCount
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        switch section {
            case mapSection:
            //family
            return 1
            
            case auditListSection:
            //music
            return CompletedAuditsFilter.count
            
            case archievedSection:
            //music
            return ArchievedAuditsFilter.count
        
            default:
            return 0

        }
    }



    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        if indexPath.section == auditListSection{
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "auditHeader", for: indexPath) as! auditHeader
            sectionHeader.headerName.text =  "Site Locations"
            return sectionHeader
     
        }else if indexPath.section == mapSection {
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "auditHeader", for: indexPath) as! auditHeader

            sectionHeader.headerName.text =  "Map"
            return sectionHeader
     
        }else if indexPath.section == archievedSection {
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "auditHeader", for: indexPath) as! auditHeader
            sectionHeader.headerName.text = mainConsole.archived
            return sectionHeader
     
        }else{
            
            //empty

            return UICollectionReusableView()
                                
 
        }
        
    }
    

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
  
        if indexPath.section  == auditListSection {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "viewAuditCell", for: indexPath) as! viewAuditCell
             
            let siteItems = CompletedAuditsFilter[indexPath.row]
       
            
            cell.auditLabel.text = siteItems.siteName
            cell.auditDate.text = siteItems.date
            cell.lineDivider1.isHidden = false
            
            
//            for x in siteItems.siteID{
//
//                let obsCount = self.observationSnapshotCount(auditID: self.auditID, siteID:"\(x)")
//                cell.observationCountLabel.text = "\(obsCount)"
//
//            }

            
            //map reference
            let annotation = MKPointAnnotation()
            let centerCoordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(siteItems.lat), longitude:CLLocationDegrees(siteItems.long))
            annotation.coordinate = centerCoordinate
            //annotation.title = ItemName
            //cell.mapUI.addAnnotation(annotation)
            
            let mapCenter = CLLocationCoordinate2DMake(CLLocationDegrees(siteItems.lat), CLLocationDegrees(siteItems.long))
            let span = MKCoordinateSpan.init(latitudeDelta: 0.001, longitudeDelta: 0.001)
            let region = MKCoordinateRegion.init(center: mapCenter, span: span)
            //mapview.region = region
            cell.mapUI.setRegion(region, animated: false)
            
            // load and show the observation count
     
            
        return cell

            
        }else if indexPath.section  == mapSection {
            let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: "viewAuditHeaderMap", for: indexPath) as! viewAuditHeaderMap
            
    
            for x in CompletedAuditsFilter{
            
                
        //map reference
                let annotation = MKPointAnnotation()
                let centerCoordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(x.lat), longitude:CLLocationDegrees(x.long))
                annotation.coordinate = centerCoordinate
                annotation.title = x.siteName
                cell.myLocations.addAnnotation(annotation)

                
                
                
                let mapCenter = CLLocationCoordinate2DMake(CLLocationDegrees(x.lat), CLLocationDegrees(x.long))
                let span = MKCoordinateSpan.init(latitudeDelta: 0.01, longitudeDelta: 0.01)
                
                let region = MKCoordinateRegion.init(center: mapCenter, span: span)
                cell.myLocations.region = region
                
            
            }
            
            return cell
            
            
        }else if indexPath.section  == archievedSection{
        //Archieved section
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "viewAuditCell", for: indexPath) as! viewAuditCell
             
            let siteItems = ArchievedAuditsFilter[indexPath.row]

            
            //cell.auditImage.sd_setImage(with: URL(string:audititems.imageURL))
            //cell.auditDate.text = audititems.date
            cell.auditLabel.text = siteItems.siteName
            cell.auditDate.text = siteItems.date
            cell.lineDivider1.isHidden = true
//
            
            //map reference
            let annotation = MKPointAnnotation()
            let centerCoordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(siteItems.lat), longitude:CLLocationDegrees(siteItems.long))
            annotation.coordinate = centerCoordinate
            //annotation.title = ItemName
            //cell.mapUI.addAnnotation(annotation)
            
            let mapCenter = CLLocationCoordinate2DMake(CLLocationDegrees(siteItems.lat), CLLocationDegrees(siteItems.long))
            let span = MKCoordinateSpan.init(latitudeDelta: 0.001, longitudeDelta: 0.001)
            let region = MKCoordinateRegion.init(center: mapCenter, span: span)
            //mapview.region = region
            cell.mapUI.setRegion(region, animated: false)
            
            
            

            return cell
        }else{
            return UICollectionReusableView() as! UICollectionViewCell
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

       // DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {self.performSegue(withIdentifier: "gameSettings", sender: indexPath.row);}

        if indexPath.section  == mapSection {
            //Map view


        }else if indexPath.section == auditListSection{
            // List of audits
            
            let auditData = CompletedAuditsFilter[indexPath.row]
            
            let Alert3 = UIAlertController(title: "Site Name", message: "\(auditData.siteName)", preferredStyle: .actionSheet)
                        let action1 = UIAlertAction(title: "View audit",style: .default) { (action:UIAlertAction!) in
                            //save this for headerview in view item
                            self.performSegue(withIdentifier: "viewAuditList", sender: self)

                        }
            let action2 = UIAlertAction(title: "Mark As Archived",style: .default) { [self] (action:UIAlertAction!) in
                            //save this for headerview in view item
                self.firebaseConsole.updateSiteProgress(siteStatus: mainConsole.archived!, auditID: "\(auditID)/\(mainConsole.siteList!)/\(auditData.siteID)")
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    
                }
                
                        }
//            let action4 = UIAlertAction(title: "Mark As In-Progress",style: .default) { [self] (action:UIAlertAction!) in
//                            //save this for headerview in view item
//                self.firebaseConsole.updateSiteProgress(siteStatus: mainConsole.progress!, auditID: "\(auditID)/\(mainConsole.siteList!)/\(auditData.siteID)")
//
//                DispatchQueue.main.async {
//                    self.collectionView.reloadData()
//
//                }
//
//                        }

            
                            let action3 = UIAlertAction(title: "Cancel",style: .cancel) { (action:UIAlertAction!) in
                        }
           
            Alert3.addAction(action1)
            Alert3.addAction(action2)
            Alert3.addAction(action3)
            //Alert3.addAction(action4)
   

            
            //archieved
            self.present(Alert3, animated: true, completion: nil)
            self.refData = "\(CompletedAuditsFilter[indexPath.row].ref)"
            self.siteID = "\(CompletedAuditsFilter[indexPath.row].siteID)"
            print(self.refData )
            
  

        }else if indexPath.section == archievedSection{
    
            let auditData = ArchievedAuditsFilter[indexPath.row]
            let Alert3 = UIAlertController(title: "Site Name", message: "\(auditData.siteName)", preferredStyle: .actionSheet)
                        let action1 = UIAlertAction(title: "View audit",style: .default) { (action:UIAlertAction!) in
                            //save this for headerview in view item
                            self.performSegue(withIdentifier: "viewAuditList", sender: self)

                        }
//            let action2 = UIAlertAction(title: "Mark As Archived",style: .default) { [self] (action:UIAlertAction!) in
//                            //save this for headerview in view item
//                self.firebaseConsole.updateSiteProgress(siteStatus: mainConsole.archived!, auditID: "\(auditID)/\(mainConsole.siteList!)/\(auditData.siteID)")
//
//                DispatchQueue.main.async {
//                    self.collectionView.reloadData()
//
//                }
//
//                        }
            let action4 = UIAlertAction(title: "Mark As In-Progress",style: .default) { [self] (action:UIAlertAction!) in
                            //save this for headerview in view item
                self.firebaseConsole.updateSiteProgress(siteStatus: mainConsole.progress!, auditID: "\(auditID)/\(mainConsole.siteList!)/\(auditData.siteID)")
                
                DispatchQueue.main.async {
                   
                    self.collectionView.reloadData()
                    
                }
                            
                        }

            
                            let action3 = UIAlertAction(title: "Cancel",style: .cancel) { (action:UIAlertAction!) in
                        }
           
            Alert3.addAction(action1)
           // Alert3.addAction(action2)
            Alert3.addAction(action3)
            Alert3.addAction(action4)
   

            
            //archieved
            self.present(Alert3, animated: true, completion: nil)
            self.refData = "\(ArchievedAuditsFilter[indexPath.row].ref)"
            self.siteID = "\(ArchievedAuditsFilter[indexPath.row].siteID)"
            print(self.refData )
            
     
           

        }else{

            
            //empty
        }
    }

    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
             if let viewInfoView = segue.destination as? createSite{

                 if auditID != ""{
                     viewInfoView.auditID = auditID
                 }else{
                     print("Failed to load data")
                 }

             }else if let viewInfoView = segue.destination as? addAuditSites{
                 
                 if auditID != ""{
                     viewInfoView.auditID = auditID
                 }else{
                     print("Failed to load data")
                 }

             }else if let viewInfoView = segue.destination as? viewSiteSnaps{
                     viewInfoView.refData = refData
                     viewInfoView.siteID = siteID
                     viewInfoView.auditID = auditID

             }else{
                 
             }
         }
    
    
    

    func createLayout() -> UICollectionViewCompositionalLayout{
        //Compositional layout
        let layout = UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
              
            if sectionNumber  == self.mapSection {
                //MAPVIEW

                     let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(300)))
                         item.contentInsets.trailing = 5
                         item.contentInsets.leading = -15
                         //item.contentInsets.top = 20
                     let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(
                         widthDimension: .fractionalWidth(1),
                         heightDimension: .absolute(300)),
                         subitems: [item])
         


                         let section = NSCollectionLayoutSection(group: group)
                         section.orthogonalScrollingBehavior = .groupPaging


                         section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension:.absolute(50) ), elementKind: "auditHeader", alignment: .topLeading)]

                         section.contentInsets.leading = 10


                         return section

            }else if sectionNumber  == self.auditListSection {
                //AUDITVIEW
                
                    let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(100)))
                        item.contentInsets.trailing = 20
                        item.contentInsets.leading = 20
                        item.contentInsets.top = 20
                    let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .absolute(CGFloat(self.CompletedAuditsFilter.count) * 100)),
                        subitems: [item])
            

                        let section = NSCollectionLayoutSection(group: group)
                        section.orthogonalScrollingBehavior = .groupPaging
                
                        section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension:.absolute(50) ), elementKind: "auditHeader", alignment: .topLeading)]
                
                        section.contentInsets.leading = 10

                
                        return section

            }else if sectionNumber == self.archievedSection {
                //ARCHIEVED
                
                     let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1/2), heightDimension: .fractionalHeight(1)))
                         item.contentInsets.trailing = 20
                         item.contentInsets.leading = 20
                         //item.contentInsets.top = 20
                     let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(
                         widthDimension: .fractionalWidth(1),
                         heightDimension: .absolute(100)),
                         subitems: [item])


                         let section = NSCollectionLayoutSection(group: group)
                         section.orthogonalScrollingBehavior = .groupPaging


                         section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension:.absolute(50) ), elementKind: "auditHeader", alignment: .topLeading)]

                         section.contentInsets.leading = 10


                         return section

            }else{
                
                
                     let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                         item.contentInsets.trailing = 20
                         item.contentInsets.leading = 20
                         //item.contentInsets.top = 20
                     let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(
                         widthDimension: .fractionalWidth(1),
                         heightDimension: .absolute(100)),
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
