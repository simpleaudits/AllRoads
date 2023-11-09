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

 

class viewAuditList: UICollectionViewController,UICollectionViewDelegateFlowLayout,MKMapViewDelegate  {
    
        //Rows in each section, these are subject to change.
        var SectionCount:Int = 3

        var rowsInSection1:Int = 3
        var rowsInSection2:Int = 10
        var rowsInSection3:Int = 5
        var rowsInSection4:Int = 5



        var CellHeight: CGFloat = 80
        var padding: CGFloat = 16

        var auditID = String()
        var projectName = String()
        let mainConsole = CONSOLE()
        let extensConsole = extens()
        var listOfAudit: [auditListData] = [] // for the favourites

    
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
            
            let uid = Auth.auth().currentUser?.uid
            
                //we want to get the database reference
                let reftest = Database.database().reference()
                    .child("\(self.mainConsole.prod!)")
                let thisUsersGamesRef = reftest
                    .child("\(self.mainConsole.post!)")
                    .child(uid!)
                    .child("\(self.mainConsole.audit!)")
                    .child("\(auditID)")
                    .child("\(self.mainConsole.auditList!)")
            
            thisUsersGamesRef.queryOrderedByKey()
                    .observe(.value, with: { snapshot in
                        
                    var NewListOfAudit: [auditListData] = []
                        
                        for child in snapshot.children {
                            
                            if let snapshot = child as? DataSnapshot,
                                let listOfAudits = auditListData(snapshot: snapshot) {
                                NewListOfAudit.append(listOfAudits)
                                
               
                                
                            }
                        }
                        self.listOfAudit = NewListOfAudit
                        self.collectionView.reloadData()
                    })
                
        
            }
            

    override func viewDidDisappear(_ animated: Bool) {
        print("YES")


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
            return 1

            case 1:
            //music
            return listOfAudit.count
       

            default:
            return 0

        }
    }



    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        if indexPath.section == 1{
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "auditHeader", for: indexPath) as! auditHeader

            sectionHeader.headerName.text =  "Snapshots"
     
            return sectionHeader
     
        }else if indexPath.section == 0 {
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "auditHeader", for: indexPath) as! auditHeader

            sectionHeader.headerName.text =  "Locations"

            return sectionHeader
            
     
        }else{
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "auditHeader", for: indexPath) as! auditHeader

            sectionHeader.headerName.text = mainConsole.archived
   
            return sectionHeader
                                
 
        }
        
    }
    

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
  
        if indexPath.section  == 1 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "viewAuditCell", for: indexPath) as! viewAuditCell
             
            let audititems = listOfAudit[indexPath.row]
            
            cell.auditImage.sd_setImage(with: URL(string:audititems.imageURL))
            cell.auditDate.text = audititems.date
            cell.auditLabel.text = audititems.auditTitle

            // Configure the cell
            cell.layer.cornerRadius = 10
            cell.layer.masksToBounds = false
            cell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            cell.layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            cell.layer.shadowOffset = CGSize(width: 0, height: 4.0)
            cell.layer.shadowRadius = 8.0
            cell.layer.shadowOpacity = 0.4
            return cell
            
            
        }else if indexPath.section  == 0 {
            let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: "viewAuditHeaderMap", for: indexPath) as! viewAuditHeaderMap
            
    
            for x in listOfAudit{
            
                
                //map reference
                let annotation = MKPointAnnotation()
                let centerCoordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(x.lat), longitude:CLLocationDegrees(x.long))
                annotation.coordinate = centerCoordinate
                annotation.title = x.auditTitle
                cell.myLocations.addAnnotation(annotation)
                
                let mapCenter = CLLocationCoordinate2DMake(CLLocationDegrees(x.lat), CLLocationDegrees(x.long))
                let span = MKCoordinateSpan.init(latitudeDelta: 0.01, longitudeDelta: 0.01)
                let region = MKCoordinateRegion.init(center: mapCenter, span: span)
                cell.myLocations.region = region
            
            }
            
            return cell
            
            
        }else{
        
            let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: "auditCell", for: indexPath) as! auditCell
            
        
            
            return cell
            
        }
        
    }
    
//    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//
//
//       // DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {self.performSegue(withIdentifier: "gameSettings", sender: indexPath.row);}
//
//        if indexPath.section  == 0 {
//
//            //let auditData = listOfAudit[indexPath.row]
//
//
//
//
//        }else if indexPath.section == 1{
//
//        }else if indexPath.section == 2{
//
//
//
//        }else{
//
//        }
//    }
//
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
             if let viewInfoView = segue.destination as?  addAudit{

                 if auditID != ""{
                     viewInfoView.auditID = auditID
                 }else{
                     print("Failed to load data")
                 }

             }
         }
    
    
    
    

    
    

    func createLayout() -> UICollectionViewCompositionalLayout{
        //Compositional layout
        let layout = UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
           
            
            
            if sectionNumber  == 1 {
                
                    let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(100)))
                        item.contentInsets.trailing = 20
                        item.contentInsets.leading = 20
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

            }else if sectionNumber  == 0 {
                

                     let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(400)))
                         item.contentInsets.trailing = 20
                         item.contentInsets.leading = 20
                         //item.contentInsets.top = 20
                     let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(
                         widthDimension: .fractionalWidth(1),
                         heightDimension: .absolute(400)),
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
