//
//  addSiteDetails.swift
//  RSAC
//
//  Created by John on 24/1/2024.
//

import UIKit
import Foundation
import Firebase

protocol saveDescription{
    func saveDescription(text:String)
  
    
}

protocol saveDescriptionRisk{
    func saveRisk(text:[String])
    
}


protocol saveDescriptionTag{
    func saveTag(text:[String])
    
}

extension UINavigationBar
{
    var largeTitleHeight: CGFloat {
        let maxSize = self.subviews
            .filter { $0.frame.origin.y > 0 }
            .max { $0.frame.origin.y < $1.frame.origin.y }
            .map { $0.frame.size }
        return maxSize?.height ?? 52
    }
}

class addSiteDetails: UIViewController,UITextViewDelegate,UITextFieldDelegate,UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, crashTypesFunc {
    
    //objects:
    var headerContent: UILabel!
    
    
    var delegate1: saveDescription?
    var delegate2: saveDescriptionRisk?
    var delegate3: saveDescriptionTag?
    
    
    var scrollView = UIScrollView()
    var stringData = String()
    var safetRiskValue: Int = 0
    
    var maxScroll = 1000.00
    
    
    //section 1
    var descriptionTextfield = UITextView()



    //section 3
    var riskFactorHeader = UILabel()
    var riskFactorHeaderTextfield = UITextField()
    var riskFactorButton = UIButton()
    
    
    
    var switchKey = String()
    var value_DataArray : [String] = []
    var tag_value_DataArray : [String] = []
    
    var collectionViewData: UICollectionView!
    var item_value_Data = "low risk"
    
    
    
    //Even though this says savecrashType, it acutally refers to the "risk" it is just retainng the crash property in the crashTypes controller
    func finishPassing_crashType(savecrashType: [String]) {
        if (self.item_value_Data != ""){
            value_DataArray = savecrashType
            collectionViewData.reloadData()
            
        }else{
            print ("empty")
         
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {

        
        switch switchKey {
            
            case "Comment":
            // if the user selects any other option i.e risk or tag first, this will default the string data as text from the "descriptionTextfield" object, if not and they select comment first, it will pull data from the "stringData" variable
            
            if stringData.isEmpty {
                //string inherits descriptionTextfield.text
                self.delegate2?.saveRisk(text: value_DataArray)
                self.delegate1?.saveDescription(text: descriptionTextfield.text)
            }else{
                //string will stay empty
                self.delegate2?.saveRisk(text: value_DataArray)
                self.delegate1?.saveDescription(text: stringData)
            }
            
                
            case "Risk":
                self.delegate2?.saveRisk(text: value_DataArray)
                self.delegate1?.saveDescription(text: stringData)
         
                
            case "Tag":
                self.delegate3?.saveTag(text: value_DataArray)
                //self.delegate2?.saveRisk(text: value_DataArray)
                self.delegate1?.saveDescription(text: stringData)
                

                
            case "history":
                print("")
                
         
                
            default:
                
        break
        }
        
        
        
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
     
        
        //load contents of view:
        switch switchKey {
            
        case "Comment":
            print("comment")
        
            navigationItem.title = "Observation"
            
            scrollView = UIScrollView(frame: CGRect(x: 0, y: 150, width: view.frame.width, height: view.frame.height ))
            scrollView.contentSize.height = maxScroll
            scrollView.isScrollEnabled = true

            let sizeFrame =  CGSize(width: scrollView.frame.width * 0.9, height: scrollView.frame.height * 0.8)
            descriptionTextfield = UITextView(frame: CGRect(origin: CGPoint(x: sizeFrame.width * 0.05, y: 0), size: sizeFrame))

            descriptionTextfield.font = UIFont.systemFont(ofSize: 20)
            descriptionTextfield.delegate = self
            descriptionTextfield.layer.borderWidth = 1
            descriptionTextfield.layer.cornerRadius = 10
            descriptionTextfield.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            descriptionTextfield.backgroundColor = #colorLiteral(red: 0.4549019608, green: 0.4549019608, blue: 0.5019607843, alpha: 0.08)
            descriptionTextfield.layer.masksToBounds = true
            descriptionTextfield.text = stringData

            
            view.addSubview(descriptionTextfield)
            view.addSubview(scrollView)
            scrollView.addSubview(descriptionTextfield)
            
            
        case "Risk":
            addRiskPopup(selectionOption: 1, title: "Risk")

            //----------------------
            navigationItem.title = "Risk"
    
            
            // Create a UICollectionViewFlowLayout
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            //layout.itemSize = CGSize(width: 40, height: 10) // Adjust size as needed
            layout.minimumInteritemSpacing = 2
            layout.minimumLineSpacing = 2
            
            // Initialize the UICollectionView with the layout
            collectionViewData = UICollectionView(frame: CGRect(x: 10, y: Int(navigationController!.navigationBar.largeTitleHeight), width: Int(view.frame.width) - 20, height: 200 ), collectionViewLayout: layout)
            collectionViewData.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            collectionViewData.isHidden = false
            self.collectionViewData?.dataSource = self
            self.collectionViewData?.delegate = self
            collectionViewData.register(crashTypeCell.self, forCellWithReuseIdentifier: "crashTypeCell")
     

            self.view.addSubview(collectionViewData)
            

            
     
            
        case "Tag":
            print("tag")
            
            addRiskPopup(selectionOption: 2, title: "Tag")

 
            //----------------------
            navigationItem.title = "Project Tag"
    
            
            // Create a UICollectionViewFlowLayout
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            //layout.itemSize = CGSize(width: 40, height: 10) // Adjust size as needed
            layout.minimumInteritemSpacing = 2
            layout.minimumLineSpacing = 2
            
            // Initialize the UICollectionView with the layout
            collectionViewData = UICollectionView(frame: CGRect(x: 10, y: Int(navigationController!.navigationBar.largeTitleHeight), width: Int(view.frame.width) - 20, height: 200 ), collectionViewLayout: layout)
            collectionViewData.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            collectionViewData.isHidden = false
            self.collectionViewData?.dataSource = self
            self.collectionViewData?.delegate = self
            collectionViewData.register(crashTypeCell.self, forCellWithReuseIdentifier: "crashTypeCell")
     
       
            self.view.addSubview(collectionViewData)
 
            
        case "History":
            print("")
            
     
            
        default:
            
        break
        }
    }
    
    
    func addRiskPopup(selectionOption: Int, title: String){
        
        let crashTypesView = crashTypes()
        let nav = UINavigationController(rootViewController: crashTypesView)
        nav.navigationBar.prefersLargeTitles = true

        nav.navigationBar.topItem!.title = title
        nav.navigationBar.tintColor = .black
        nav.modalPresentationStyle = .pageSheet
        nav.isModalInPresentation = true
        crashTypesView.delegate = self
        crashTypesView.crashDataArray = value_DataArray
        crashTypesView.selectionOption = selectionOption // send data to this view based on the loaded data, this will always populate the crash type view with highlighted data.
        
            
            if let presentationController = nav.presentationController as? UISheetPresentationController {
                presentationController.detents = [.medium(),.large()] /// change to [.medium(), .large()] for a half *and* full screen sheet
                presentationController.prefersGrabberVisible = true
                presentationController.preferredCornerRadius = 45

 
                presentationController.largestUndimmedDetentIdentifier = .large
                //presentationController.prefersScrollingExpandsWhenScrolledToEdge = false
            }

            
            self.present(nav, animated: true)
        

     
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        //navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveData))
 

        //Convert JSON string to Data, this is required due to the following reasons. Converts string to array object.
        guard let jsonData = "\(item_value_Data)".data(using: .utf8) else {
            print("Error: Unable to convert string to Data")
            return
        }

        // Decode JSON data to array of strings
        do {
            let stringArray = try JSONDecoder().decode([String].self, from: jsonData)
            print(stringArray) // Output: ["Hit Train", "Adjacent approach"]
            
            value_DataArray = stringArray
        } catch {
            print("Error decoding JSON: \(error)")
        }
  

        
 
 

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return value_DataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "crashTypeCell", for: indexPath) as! crashTypeCell
        
        
        let indexcrashType = value_DataArray[indexPath.row]
        
        cell.backgroundColor = #colorLiteral(red: 1, green: 0.6645795107, blue: 0.2553189099, alpha: 1)
        cell.layer.cornerRadius = 15
        cell.layer.masksToBounds = true
        cell.label.text = "\(indexcrashType)"
        
        return cell
    }
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let string = value_DataArray[indexPath.item]
        
        // Create a temporary label to measure the text size
        let tempLabel = UILabel()
        tempLabel.text = (string as String)
        tempLabel.font = UIFont.systemFont(ofSize: 12) // Match the font used in the cell
        tempLabel.numberOfLines = 0
        
        // Calculate the size of the label
        let width = tempLabel.intrinsicContentSize.width + 16 // 16 is padding
        let height = tempLabel.intrinsicContentSize.height + 16 // 16 is padding
         

        
        return CGSize(width: width, height: height)
    
}


    
    @objc func saveData(_ sender: UIButton) {
        self.delegate1?.saveDescription(text: self.descriptionTextfield.text)
        self.navigationController?.popViewController(animated: true)
        //self.dismiss(animated: true, completion: nil)
        
        

        
    }
    
    

}
