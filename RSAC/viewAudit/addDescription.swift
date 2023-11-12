//
//  addDescription.swift
//  RoadSafetyAuditCloud
//
//  Created by John on 2/11/2023.
//

import UIKit

class addDescription: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITextViewDelegate,UITextFieldDelegate {
    
    var descriptionTextfieldHeaderCount = UILabel()
    var descriptionTextfieldHeader = UILabel()
    var descriptionTextfield = UITextView()
    var detailsCollectionView : UICollectionView!
    
    let mainConsole = CONSOLE()
    let extensConsole = extens()
    
    
    struct Section {
        var sectionName: String
        var items: [String]
        var isCollapsed: Bool
    }
    
    var sectionData: [Section] = [
        Section(sectionName: "Section 1", items: ["Item 1", "Item 2", "Item 3"], isCollapsed: false),
        Section(sectionName: "Section 2", items: ["Item 4", "Item 5"], isCollapsed: false),
        Section(sectionName: "Section 3", items: ["Item 6", "Item 7", "Item 8"], isCollapsed: false)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        descriptionTextfieldHeader = UILabel(frame: CGRect(x: 10, y:10, width: view.frame.width, height: 20))
        descriptionTextfieldHeader.text = "DESCRIBE THE SITE"
        descriptionTextfieldHeader.font = UIFont.systemFont(ofSize: 15)
        descriptionTextfieldHeader.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        
        

        
        descriptionTextfield = UITextView(frame: CGRect(x: 0, y: Int(descriptionTextfieldHeader.frame.maxY) + 10, width: Int(view.frame.width), height: 200 ))
        descriptionTextfield.font = UIFont.systemFont(ofSize: 20)
        descriptionTextfield.delegate = self
//        descriptionTextfield.layer.borderWidth = 2
//        descriptionTextfield.layer.cornerRadius = 20
//        descriptionTextfield.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//        descriptionTextfield.layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
//        descriptionTextfield.layer.masksToBounds = false
//        descriptionTextfield.layer.shadowOffset = CGSize(width: 0, height: 4.0)
//        descriptionTextfield.layer.shadowRadius = 8.0
//        descriptionTextfield.layer.shadowOpacity = 0.4
        
        
        descriptionTextfieldHeaderCount = UILabel(frame: CGRect(x: 0, y:descriptionTextfield.frame.maxY, width: view.frame.width, height: 20))
        descriptionTextfieldHeaderCount.textAlignment = .right
        descriptionTextfieldHeaderCount.font = UIFont.systemFont(ofSize: 12)
        descriptionTextfieldHeaderCount.backgroundColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        descriptionTextfieldHeaderCount.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)

        
        view.addSubview(descriptionTextfield)
        view.addSubview(descriptionTextfieldHeader)
        view.addSubview(descriptionTextfieldHeaderCount)
        
       
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        detailsCollectionView = UICollectionView(frame: CGRect(x: 10, y:descriptionTextfield.frame.maxY + 30, width: view.frame.width, height: view.frame.height - (descriptionTextfield.frame.minY + 30)), collectionViewLayout: layout)
        detailsCollectionView.isPagingEnabled = false
        detailsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        detailsCollectionView.register(detailsCell.self, forCellWithReuseIdentifier: "detailsCell")
        detailsCollectionView.delegate = self
        detailsCollectionView.dataSource = self
        //view.addSubview(detailsCollectionView)
        

        
    
        detailsCollectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")

        // Do any additional setup after loading the view.
        
        hideKeyboardWhenTappedAround()
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // we want to set the collectionview

        
       return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
  
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 30)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        

       
        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: "detailsCell", for: indexPath) as! detailsCell
     
        cell.labelUI.text = sectionData[indexPath.section].items[indexPath.item]
        
        cell.layer.cornerRadius = 5
        cell.layer.masksToBounds = false
        cell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//        cell.layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
//        cell.layer.shadowOffset = CGSize(width: 0, height: 4.0)
//        cell.layer.shadowRadius = 2.0
//        cell.layer.shadowOpacity = 0.4
        return cell
    }
    

    
     func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
         let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath)

                // Configure the header view
                let label = UILabel(frame: headerView.bounds)
                label.textAlignment = .left
                label.text = sectionData[indexPath.section].sectionName
                // Add tap gesture recognizer

         
         
                headerView.addSubview(label)
  
                return headerView
            
     }

        

    
     func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sectionData[section].items.count
     }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        // Adjust the size of your section headers
        return CGSize(width: view.frame.width, height: 30)
    }
    
    func hideKeyboardWhenTappedAround() {
           let tapGesture = UITapGestureRecognizer(target: self,
                            action: #selector(hideKeyboard))
           view.addGestureRecognizer(tapGesture)
    }
    
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(productPrice textField: UITextField) {
        //print("TextField did begin editing method called")
        //count the number of words via the spaces in the string
//        let spaceCount = self.speechToTextData.text.reduce(0) { $1 == " " ? $0 + 1 : $0 }
//
//
//        self.speechToTextCount.text = "\(spaceCount + 1)"

    }


 
    // UITextViewDelegate method
    func textViewDidChange(_ textView: UITextView) {
        // This method is called whenever the text changes
        if let text = textView.text {
            let characterCount = text.count
           // print("Character count: \(characterCount)")
            descriptionTextfieldHeaderCount.text = "Character Count:\(characterCount)"
    
        }
    }

}
