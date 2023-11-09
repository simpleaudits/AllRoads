//
//  addDescription.swift
//  RoadSafetyAuditCloud
//
//  Created by John on 2/11/2023.
//

import UIKit

class addDescription: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    
    var descriptionTextfieldHeader = UILabel()
    var descriptionTextfield = UITextView()
    var detailsCollectionView : UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        descriptionTextfieldHeader = UILabel(frame: CGRect(x: 10, y:10, width: view.frame.width, height: 20))
        descriptionTextfieldHeader.text = "Describe the site:"
        descriptionTextfieldHeader.font = UIFont.boldSystemFont(ofSize: 20)
        
        descriptionTextfield = UITextView(frame: CGRect(x: 10, y: Int(descriptionTextfieldHeader.frame.maxY) + 20, width: Int(view.frame.width) - 20, height: 200 ))
        descriptionTextfield.layer.borderWidth = 2
        descriptionTextfield.layer.cornerRadius = 20
        descriptionTextfield.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        descriptionTextfield.layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        descriptionTextfield.layer.masksToBounds = false
        descriptionTextfield.layer.shadowOffset = CGSize(width: 0, height: 4.0)
        descriptionTextfield.layer.shadowRadius = 8.0
        descriptionTextfield.layer.shadowOpacity = 0.4
        view.addSubview(descriptionTextfield)
        view.addSubview(descriptionTextfieldHeader)
        
        
       
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        detailsCollectionView = UICollectionView(frame: CGRect(x: 10, y:descriptionTextfield.frame.maxY + 30, width: view.frame.width, height: view.frame.height - (descriptionTextfield.frame.minY + 30)), collectionViewLayout: layout)
        detailsCollectionView.isPagingEnabled = true
        detailsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        detailsCollectionView.register(detailsCell.self, forCellWithReuseIdentifier: "detailsCell")
        detailsCollectionView.delegate = self
        detailsCollectionView.dataSource = self
        view.addSubview(detailsCollectionView)
        




        // Do any additional setup after loading the view.
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // we want to set the collectionview

        
       return UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20)
    }
  
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 60)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: "detailsCell", for: indexPath) as! detailsCell
        
        cell.layer.cornerRadius = 5
        cell.layer.masksToBounds = false
        cell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cell.layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        cell.layer.shadowOffset = CGSize(width: 0, height: 4.0)
        cell.layer.shadowRadius = 8.0
        cell.layer.shadowOpacity = 0.4
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items

        return 50
    }

}
