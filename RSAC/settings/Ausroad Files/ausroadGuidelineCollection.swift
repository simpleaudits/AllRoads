//
//  ausroadGuidelineCollection.swift
//  RSAC
//
//  Created by John on 18/5/2024.
//

import UIKit


class ausroadGuidelineCollection: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    
    
    //MARK: - Declaring list of files
    var PDFfilename = String()
    var headingName = String()
    
    var ausroadGuidePDF =
    [
        "AGRS01-21_Guide_to_Road_Safety_Part_1_Introduction_Safe_System.pdf",
        "AGRS02-21_Guide_to_Road_Safety_Part_2_Safe_Roads.pdf",
        "AGRS03-21_Guide_to_Road_Safety_Part_3_Safe_Speed.pdf",
        "AGRS04-21_Guide_to_Road_Safety_Part_4_Safe_People.pdf",
        "AGRS05-21_Guide_to_Road_Safety_Part_5_Safe_Vehicles.pdf",
        "AGRS06-22_Guide_to_Road_Safety_Part-6_Road_Safety_Audit.pdf",
        "AGRS07-21_Guide_to_Road_Safety_Part_7_Road_Safety_Strategy_and_Management.pdf"
    ]
    
    var ausroadGuideImage =
    [
        "1.jpeg",
        "2.jpeg",
        "3.jpeg",
        "4.jpeg",
        "5.jpeg",
        "6.jpeg",
        "7.jpeg"
    ]
    
    //MARK: - Declaring list of files
    
    
    override func viewDidLoad() {
  

        
        collectionView?.register(cellFiles.self, forCellWithReuseIdentifier: "auditCell")
        collectionView?.register(headerFiles.self, forSupplementaryViewOfKind: "auditHeader", withReuseIdentifier: "auditHeader")
        
        self.collectionView.collectionViewLayout = createLayout()

        super.viewDidLoad()
    }


    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return ausroadGuidePDF.count
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
            case 0:
            return 1

            case 1:
            return 1
       
            case 2:
            return 1

            case 3:
            return 1

            case 4:
            return 1

            case 5:
            return 1

            default:
            return 1

        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        // Configure the cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "auditCell", for: indexPath) as! cellFiles
        
        if indexPath.section  == 0 {
            cell.categoryImage.image = UIImage(named: "\(Array(ausroadGuideImage)[0])")
        }else if indexPath.section  == 1 {
            cell.categoryImage.image = UIImage(named: "\(Array(ausroadGuideImage)[1])")
        }else if indexPath.section  == 2 {
            cell.categoryImage.image = UIImage(named: "\(Array(ausroadGuideImage)[2])")
        }else if indexPath.section  == 3 {
            cell.categoryImage.image = UIImage(named: "\(Array(ausroadGuideImage)[3])")
        }else if indexPath.section  == 4 {
            cell.categoryImage.image = UIImage(named: "\(Array(ausroadGuideImage)[4])")
        }else if indexPath.section  == 5 {
            cell.categoryImage.image = UIImage(named: "\(Array(ausroadGuideImage)[5])")
        }else {
            cell.categoryImage.image = UIImage(named: "\(Array(ausroadGuideImage)[6])")
        }
        
        return cell
        

        
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "auditHeader", for: indexPath) as! headerFiles

        if indexPath.section  == 0 {
            sectionHeader.headerName.text = "Part 1: Introduction and The Safe System"
        }else if indexPath.section  == 1 {
            sectionHeader.headerName.text = "Part 2: Safe Roads"
        }else if indexPath.section  == 2 {
            sectionHeader.headerName.text = "Part 3: Safe Speed"
        }else if indexPath.section  == 3 {
            sectionHeader.headerName.text = "Part 4: Safe People"
        }else if indexPath.section  == 4 {
            sectionHeader.headerName.text = "Part 5: Safe Vehicles"
        }else if indexPath.section  == 5 {
            sectionHeader.headerName.text = "Part 6: Road Safety Audit"
        }else {
            sectionHeader.headerName.text = "Part 7: Road Safety Strategy and Management"
        }
        
        return sectionHeader
    }
    

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.section  == 0 {
            PDFfilename =  "\(Array(ausroadGuidePDF)[0])"
            headingName = "Part 1: Introduction and The Safe System"
            self.performSegue(withIdentifier: "viewPDF", sender: indexPath.row);
        }else if indexPath.section  == 1 {
            PDFfilename =  "\(Array(ausroadGuidePDF)[1])"
            headingName = "Part 2: Safe Roads"
            self.performSegue(withIdentifier: "viewPDF", sender: indexPath.row);
        }else if indexPath.section  == 2 {
            PDFfilename =  "\(Array(ausroadGuidePDF)[2])"
            headingName = "Part 3: Safe Speed"
            self.performSegue(withIdentifier: "viewPDF", sender: indexPath.row);
        }else if indexPath.section  == 3 {
            PDFfilename =  "\(Array(ausroadGuidePDF)[3])"
            headingName = "Part 4: Safe People"
            self.performSegue(withIdentifier: "viewPDF", sender: indexPath.row);
        }else if indexPath.section  == 4 {
            PDFfilename =  "\(Array(ausroadGuidePDF)[4])"
            headingName = "Part 5: Safe Vehicles"
            self.performSegue(withIdentifier: "viewPDF", sender: indexPath.row);
        }else if indexPath.section  == 5 {
            PDFfilename =  "\(Array(ausroadGuidePDF)[5])"
            headingName = "Part 6: Road Safety Audit"
            self.performSegue(withIdentifier: "viewPDF", sender: indexPath.row);
        }else {
            PDFfilename =  "\(Array(ausroadGuidePDF)[6])"
            headingName = "Part 7: Road Safety Strategy and Management"
            self.performSegue(withIdentifier: "viewPDF", sender: indexPath.row);
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   
        if let viewControllerB = segue.destination as?  viewGuidelinesPDF{
            viewControllerB.PDFfilename = PDFfilename
            viewControllerB.headingName = headingName
        }else{

        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    func createLayout() -> UICollectionViewCompositionalLayout{
        //Compositional layout
        let layout = UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
  
            if sectionNumber  == 0 {
                
               
                    let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1/2), heightDimension: .fractionalHeight(1)))
                        item.contentInsets.trailing = 0
                        item.contentInsets.leading = 0
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
                         item.contentInsets.trailing = 0
                         item.contentInsets.leading = 0
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
                         item.contentInsets.trailing = 0
                         item.contentInsets.leading = 0
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

            }else if sectionNumber == 3 {
                
                
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1/2), heightDimension: .fractionalHeight(1)))
                    item.contentInsets.trailing = 0
                    item.contentInsets.leading = 0
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

           }else if sectionNumber == 4 {
               
               
               let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1/2), heightDimension: .fractionalHeight(1)))
                   item.contentInsets.trailing = 0
                   item.contentInsets.leading = 0
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

          }else if sectionNumber == 5 {
              
              
              let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1/2), heightDimension: .fractionalHeight(1)))
                  item.contentInsets.trailing = 0
                  item.contentInsets.leading = 0
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
                     item.contentInsets.trailing = 0
                     item.contentInsets.leading = 0
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
