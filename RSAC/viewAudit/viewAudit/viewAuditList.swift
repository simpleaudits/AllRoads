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
import SDWebImage
 

class viewAuditList: UICollectionViewController,UICollectionViewDelegateFlowLayout,MKMapViewDelegate  {
    
    // configure the section
    let mapSection = 0
    let auditListSection = 1
    let archievedSection = 2
    
    //Rows in each section, these are subject to change.
        var SectionCount:Int = 3

    


        var CellHeight: CGFloat = 80
        var padding: CGFloat = 16

        var auditID = String()
        var siteID = String()
        var projectName = String()
        var refData = String()
       
    
    
    
        var listingData = Int()
        let mainConsole = CONSOLE()
        let extensConsole = extens()
        let firebaseConsole = saveLocal()
        var listOfSites: [createSiteData] = [] // for the favourites
        var CompletedAuditsFilter: [createSiteData] = []
        var ArchievedAuditsFilter: [createSiteData] = []
    
    @IBOutlet weak var statusSegment: UISegmentedControl!
    
  
    
    
    override func viewDidLoad() {

        super.viewDidLoad()
        
        //load the number of listing the user can actually make here:
        loadUserStats()
        
        
        loadAuditSnapshots()
        
        

 
        self.collectionView?.register(auditHeader.self, forSupplementaryViewOfKind: "auditHeader", withReuseIdentifier: "auditHeader")
        self.collectionView?.register(viewAuditCell.self, forCellWithReuseIdentifier: "viewAuditCell")
        self.collectionView?.register(viewAuditHeaderMap.self, forCellWithReuseIdentifier: "viewAuditHeaderMap")
        
        
        self.collectionView.collectionViewLayout = createLayout()

        self.navigationItem.title = projectName


    }
    
//sharable APO---------------------------------------------------------------------------------------------------------------------[START]
    @IBAction func createShare(_ sender: Any) {
        createSharedAlert()

    }
    

        func createSharedAlert() {
            
            //PREVIEW THE CURRENT IMAGE WITHIN ALERT
            
            let collabID =  self.extensConsole.collaborationID()
            let alertController = UIAlertController(title: "Share this project", message: "collabID:\n\(collabID)", preferredStyle: .alert)
            let imageView = UIImageView(frame: CGRect(x: alertController.view.frame.maxX/2 - 160, y: 100, width: 200, height: 200))

            //create UIImage here
            
            let dataQR = String(collabID).data(using: String.Encoding.ascii, allowLossyConversion: true)
            
            // Get a QR CIFilter
            guard let qrFilter = CIFilter(name: "CIQRCodeGenerator") else { return }
            // Input the data
            qrFilter.setValue(dataQR, forKey: "inputMessage")
            // Get the output image
            guard let qrImage = qrFilter.outputImage else { return }
            // Scale the image
            let transform = CGAffineTransform(scaleX: 10, y: 10)
            let scaledQrImage = qrImage.transformed(by: transform)
            // Do some processing to get the UIImage
            let context = CIContext()
            guard let cgImage = context.createCGImage(scaledQrImage, from: scaledQrImage.extent) else { return }
            
            let processedImage = UIImage(cgImage: cgImage)
      
            imageView.image = processedImage
            imageView.layer.cornerRadius = 20
            imageView.layer.masksToBounds = true
            alertController.view.addSubview(imageView)
            let height = NSLayoutConstraint(item: alertController.view!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 400)
            let width = NSLayoutConstraint(item: alertController.view!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 250)
            alertController.view.addConstraint(height)
            alertController.view.addConstraint(width)

            let action1 = UIAlertAction(title: "Create",style: .default) { (action:UIAlertAction!) in
                
                self.firebaseConsole.createCollaborationAPI(collaborationID:collabID,
                                                            date:self.extensConsole.timeStamp(),
                                                            projectName: self.projectName,
                                                            isEditable: true,
                                                            auditID: self.auditID)
 
            }

            let action3 = UIAlertAction(title: "Copy to Clipboard", style: .default) { (action:UIAlertAction!) in
            print("Cancel button tapped");
            }
            
            alertController.addAction(action1)
            //alertController.addAction(action3)
            alertController.view.addSubview(imageView)


            self.present(alertController, animated: true, completion: nil)


            }
    


    // Change user DP ALERT --------------------------------------------------------------------------------------------------------------------[END]
    
    
    
//Change project Status---------------------------------------------------------------------------------------------------------------------[START]
        @IBAction func indexChanged(_ sender: Any) {
            switch statusSegment.selectedSegmentIndex {
            case 0:
                print("Complete")
                self.firebaseConsole.updateAuditProgress(auditProgress: mainConsole.complete!, auditID: auditID)
                
                break
            case 1:
                print("In-Progress")
                self.firebaseConsole.updateAuditProgress(auditProgress: mainConsole.progress!, auditID: auditID)
   
                break
            default:
                print("Archieved")
                
                self.firebaseConsole.updateAuditProgress(auditProgress: mainConsole.archived!, auditID: auditID)
                
                break
            }
    
        }
//Change project Status---------------------------------------------------------------------------------------------------------------------[END]
    
    
    
    
    
//Load Data from Firebase---------------------------------------------------------------------------------------------------------------------[START]

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
                       
                        
                        //all true completed
                        self.CompletedAuditsFilter = self.listOfSites.filter(
                            {return $0.status.localizedCaseInsensitiveContains("In-Progress Audits") })
                        print("CompletedAuditsFilter:\(self.CompletedAuditsFilter.count)")

                        //all false completed
                        self.ArchievedAuditsFilter = self.listOfSites.filter(
                            {return $0.status.localizedCaseInsensitiveContains("Archived") })
                        print("ArchievedAuditsFilter:\(self.ArchievedAuditsFilter.count)")
    
                   
                    
                        self.collectionView.reloadData()
                    
                        // get user status:
                        checkUserStatus()
      

                    })
        
            }
    
//Load Data from Firebase---------------------------------------------------------------------------------------------------------------------[END]
    
//Load Data from Firebase, get max listing---------------------------------------------------------------------------------------------------------------------[START]
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
    
    
    @IBAction func addSite(_ sender: Any) {
        
        if listOfSites.count < listingData{
            self.performSegue(withIdentifier: "addSite", sender: self);
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
        
    
    
//Load Data from Firebase, get max listing---------------------------------------------------------------------------------------------------------------------[END]
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//Load project data from Firebase---------------------------------------------------------------------------------------------------------------------[START]
    
     func checkUserStatus(){
           
          if Auth.auth().currentUser != nil {
              
              let uid = Auth.auth().currentUser?.uid
              
              let reftest = Database.database().reference()
                  .child("\(self.mainConsole.prod!)")
              let auditData = reftest
                  .child("\(self.mainConsole.post!)")
                  .child(uid!)
                  .child("\(self.mainConsole.audit!)")
                  .child("\(auditID)")
        

              auditData.queryOrderedByKey()
                  .observe( .value, with: { snapshot in
                            guard let dict = snapshot.value as? [String:Any] else {
                            //error here
                            return
                            }

                             let status = dict["auditProgress"] as? String
                             print("status:\(status!)")
                             SwiftLoader.hide()
                      
                       
                              switch status{
                              case self.mainConsole.complete!:
                              self.statusSegment.selectedSegmentIndex = 0;
                              break
                              case self.mainConsole.progress!:
                              self.statusSegment.selectedSegmentIndex = 1;
                              break
                              default:
                              self.statusSegment.selectedSegmentIndex = 2;
                              break
                              }

                        
                            
                        
                })
                                 
                  
            }

      }
            
    
    
//Load project data from Firebase---------------------------------------------------------------------------------------------------------------------[END]
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

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
         
            default:
            return ArchievedAuditsFilter.count

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
     
        }else {
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "auditHeader", for: indexPath) as! auditHeader
            sectionHeader.headerName.text = "Archived"
            return sectionHeader
     
        }
        
    }
    

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
  
        if indexPath.section  == auditListSection {
            //Working Audits
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "viewAuditCell", for: indexPath) as! viewAuditCell
             
            let siteItems = CompletedAuditsFilter[indexPath.row]
       
            
            cell.auditLabel.text = siteItems.siteName
            cell.auditDate.text = siteItems.date
            cell.lineDivider1.isHidden = false
            cell.observationCountLabel.text = "| \(siteItems.observationCount)"
            //cell.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 0.5)
            
            let transforImageSize = SDImageResizingTransformer(size: CGSize(width: 100, height: 100), scaleMode: .fill)
            cell.imageUI.sd_setImage(with: URL(string:siteItems.locationImageURL), placeholderImage: nil, context: [.imageTransformer:transforImageSize])
            
            
            
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 15
            cell.layer.borderWidth = 1
            cell.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            

            
        return cell

            
        }else if indexPath.section  == mapSection {
            let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: "viewAuditHeaderMap", for: indexPath) as! viewAuditHeaderMap
            
    
            for x in CompletedAuditsFilter{
            
                
        //map reference
                let annotation = MKPointAnnotation()
                let centerCoordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(x.lat), longitude:CLLocationDegrees(x.long))
                annotation.coordinate = centerCoordinate
                annotation.title = "Location: \(x.siteName)\n\nObservations: \(x.observationCount)"
                //annotation.subtitle = "Observations:\(x.observationCount)"
                cell.myLocations.addAnnotation(annotation)

                let mapCenter = CLLocationCoordinate2DMake(CLLocationDegrees(x.lat), CLLocationDegrees(x.long))
                let span = MKCoordinateSpan.init(latitudeDelta: 0.01, longitudeDelta: 0.01)

                let region = MKCoordinateRegion.init(center: mapCenter, span: span)
                cell.myLocations.region = region
                
            
            }
            
            return cell
            
            
        }else {
        //Archieved section
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "viewAuditCell", for: indexPath) as! viewAuditCell
             
            let siteItems = ArchievedAuditsFilter[indexPath.row]

            
            //cell.auditImage.sd_setImage(with: URL(string:audititems.imageURL))
            //cell.auditDate.text = audititems.date
            cell.auditLabel.text = siteItems.siteName
            cell.auditDate.text = siteItems.date
            cell.lineDivider1.isHidden = true
            cell.observationCountLabel.text = siteItems.observationCount
            //cell.backgroundColor = #colorLiteral(red: 1, green: 0.8323456645, blue: 0.4732058644, alpha: 0.5)
            
            
            let transforImageSize = SDImageResizingTransformer(size: CGSize(width: 100, height: 100), scaleMode: .fill)
            cell.imageUI.sd_setImage(with: URL(string:siteItems.locationImageURL), placeholderImage: nil, context: [.imageTransformer:transforImageSize])
            

            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 15
            cell.layer.borderWidth = 1
            cell.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            


            return cell
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

       // DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {self.performSegue(withIdentifier: "gameSettings", sender: indexPath.row);}

        if indexPath.section  == mapSection {
            //Map view


        }else if indexPath.section == auditListSection{
            // List of audits
            
            let auditData = CompletedAuditsFilter[indexPath.row]
            
            let Alert3 = UIAlertController(title: "Site Name:", message: "\(auditData.siteName)", preferredStyle: .actionSheet)
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
            
  

        }else {
    
            let auditData = ArchievedAuditsFilter[indexPath.row]
            let Alert3 = UIAlertController(title: "Site Name:", message: "\(auditData.siteName)", preferredStyle: .actionSheet)
                        let action1 = UIAlertAction(title: "View audit",style: .default) { (action:UIAlertAction!) in
                            //save this for headerview in view item
                            self.performSegue(withIdentifier: "viewAuditList", sender: self)

                        }

            
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

             }else if let viewInfoView = segue.destination as? Observation{
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
//                         item.contentInsets.trailing = 5
//                         item.contentInsets.leading = -15
                         //item.contentInsets.top = 20
                     let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(
                         widthDimension: .fractionalWidth(1),
                         heightDimension: .absolute(300)),
                         subitems: [item])
         


                         let section = NSCollectionLayoutSection(group: group)
                         section.orthogonalScrollingBehavior = .groupPaging

//
//                         section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension:.absolute(50) ), elementKind: "auditHeader", alignment: .topLeading)]
//
                        //section.contentInsets.leading = 10


                         return section

            }else if sectionNumber  == self.auditListSection {
                //AUDITVIEW
                
                    let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(100)))
                        item.contentInsets.trailing = 20
                        item.contentInsets.leading = 20
                        item.contentInsets.top = 5
                    let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .absolute(CGFloat(self.CompletedAuditsFilter.count) * 100)),
                        subitems: [item])
            

                        let section = NSCollectionLayoutSection(group: group)
                        section.orthogonalScrollingBehavior = .groupPaging
                
                        section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension:.absolute(50) ), elementKind: "auditHeader", alignment: .topLeading)]
                
                        section.contentInsets.leading = 10

                
                        return section

            }else {
                //ARCHIEVED
                
                     let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(100)))
                         item.contentInsets.trailing = 20
                         item.contentInsets.leading = 20
                         item.contentInsets.top = 5
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
