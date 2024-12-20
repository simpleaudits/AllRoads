//
//  JafflerCollectionView.swift
//  dbtestswift
//
//  Created by macbook on 28/6/20.
//  Copyright © 2020 macbook. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage
import FirebaseDatabase
import PDFKit



//@available(iOS 13.0, *)
class viewSiteSnaps: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    
    let mainConsole = CONSOLE()
    let mainFunction = extens()
    var refData = String()
    var ListReferenceDataAdd = String()
    
    var auditID = String()
    var siteID = String()
    var listOfSitesData: [auditSiteData] = []
    
    
    var titleData = String()
    var descriptionData = String()
    

    var myImageView = UIImageView()
    var myImage = UIImage()
    var imageData123 = UIImage()

    //ARRAY


    


      
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination5 = segue.destination as? viewPDF {
           destination5.refData = refData

          }
        
    
        else {
            
        }
   
            
            
        }



    override func viewDidLoad() {
    
        super.viewDidLoad()

        
        
        
        
        
        
        
        
        

        loadSiteAuditData()
   

        

        self.collectionView?.dataSource = self
        self.collectionView?.delegate = self
        
        
        collectionView?.register(viewSiteSnapsCell.self, forCellWithReuseIdentifier: "viewSiteSnapsCell")
        //collectionView?.register(HeaderJafflers.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "JaffleHeader")
        
  
        
        }


    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // we want to set the collectionview

        
       return UIEdgeInsets(top: 20, left: 10, bottom: 0, right: 10)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        

        return .init(width:view.frame.width, height : 100)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
         
        
         
        return .init(width: view.frame.width, height : 0)
     }
    

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return listOfSitesData.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: "viewSiteSnapsCell", for: indexPath) as! viewSiteSnapsCell
   
        let indexAudit = listOfSitesData[indexPath.item]
        cell.siteName.text = indexAudit.auditTitle
        cell.auditDate.text = indexAudit.date
        cell.auditDescription.text = indexAudit.auditDescription
        let transforImageSize = SDImageResizingTransformer(size: CGSize(width: 150, height: 150), scaleMode: .fill)
        cell.siteImage.sd_setImage(with: URL(string:indexAudit.imageURL), placeholderImage: nil, context: [.imageTransformer:transforImageSize])
        
        titleData = indexAudit.auditTitle
        descriptionData = indexAudit.auditDescription

      
    return cell
    }

    
    
    //get the list of users that applied. (3)
       
       func loadSiteAuditData(){
     
           //if Auth.auth().currentUser != nil {
  
               Database.database().reference(withPath:"\(refData)/\(mainConsole.auditList!)")
                   .observe(.value, with: { [self] snapshot in

                var listOfSitesData: [auditSiteData] = []
                for child in snapshot.children {

                if let snapshot = child as? DataSnapshot,
                   let List = auditSiteData(snapshot: snapshot) {
                    listOfSitesData.append(List)
                    
                    
           
                    

                }
                }

                self.listOfSitesData = listOfSitesData
                    
                  
               
               })
               

               DispatchQueue.main.async {
                   self.collectionView.reloadData()
                   
               }
           
       }
    

    
    
    

    
        
}
