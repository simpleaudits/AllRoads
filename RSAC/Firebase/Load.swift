//
//  Load.swift
//  waiter+
//
//  Created by John on 6/9/2023.
//

import Foundation
import Firebase
import SwiftLoader

extension mainSearchView {
    
    func loadAudits(){
        
        SwiftLoader.show(title: "Loading Audits", animated: true)
        
        let uid = Auth.auth().currentUser?.uid
            //we want to get the database reference
            let reftest = Database.database().reference()
                .child("\(self.mainConsole.prod!)")
            let auditDataList = reftest
                .child("\(self.mainConsole.post!)")
                .child(uid!)
                .child("\(self.mainConsole.audit!)")

        
        auditDataList.queryOrderedByKey()
                .observe(.value, with: { snapshot in
                    
                var myAudits: [newAuditDataset] = []
              
                    for child in snapshot.children {
                        if let snapshot = child as? DataSnapshot,
                            let proditem = newAuditDataset(snapshot: snapshot) {
                            myAudits.append(proditem)
                            
                        }
                    }
                    self.auditData = myAudits
                    
                    self.CompletedAuditsFilter = self.auditData.filter(
                        {return $0.auditProgress.localizedCaseInsensitiveContains("Completed Audits") })

                    self.InProgressAuditsAuditsFilter = self.auditData.filter(
                        {return $0.auditProgress.localizedCaseInsensitiveContains("In-Progress Audits") })

                    self.ArchievedAuditsFilter = self.auditData.filter(
                        {return $0.auditProgress.localizedCaseInsensitiveContains("Archived") })
                    
                    SwiftLoader.hide()
                    
                    self.collectionView.reloadData()
            
                    
                   
                })
            
    
        }
    
    
//    func loadAudits(){
//
//        //1)prod
//        //2)post
//        //3)skips UID
//        //4)audit
//        //skips AuditRef
//
//        //--------------------------------
//        //1)
//        let auditDataList = Database.database().reference()
//            .child("\(self.mainConsole.prod!)")
//            .child("\(self.mainConsole.post!)")
//
//        //3)
//        auditDataList.observeSingleEvent(of: DataEventType .childAdded, with: { snapshot in
//        //4), 5)
//            for child in snapshot.childSnapshot(forPath: "\(self.mainConsole.audit!)").children {
//                    if let snapshot = child as? DataSnapshot,
//                        let proditem = newAuditDataset(snapshot: snapshot) {
//                        self.auditData.append(proditem)
//
//
//
//
//
//
//                    }
//            }
//
//            self.CompletedAuditsFilter = self.auditData.filter(
//                {return $0.auditProgress.localizedCaseInsensitiveContains("Completed Audits") })
//
//            self.InProgressAuditsAuditsFilter = self.auditData.filter(
//                {return $0.auditProgress.localizedCaseInsensitiveContains("In-Progress Audits") })
//
//            self.ArchievedAuditsFilter = self.auditData.filter(
//                {return $0.auditProgress.localizedCaseInsensitiveContains("Archived") })
//
//            self.collectionView.reloadData()
//
//            })
//
//
//        }

}
