//
//  DescriptionVC.swift
//  dbtestswift
//
//  Created by macbook on 2/11/19.
//  Copyright © 2019 macbook. All rights reserved.
//

import UIKit
import Firebase
import SwiftLoader
import Foundation

protocol reportContentField{
    func finishPassing_decription(saveDescription: String)
}

class crashTypeCell: UICollectionViewCell {
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




class buildReportContentPage: UIViewController,UITextViewDelegate,auditStage,crashTypesFunc, UINavigationControllerDelegate, UISheetPresentationControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return item_value_reportDataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "crashTypeCell", for: indexPath) as! crashTypeCell
        
        
        let indexcrashType = item_value_reportDataArray[indexPath.row]
        
        cell.backgroundColor = #colorLiteral(red: 1, green: 0.6645795107, blue: 0.2553189099, alpha: 1)
        cell.layer.cornerRadius = 15
        cell.layer.masksToBounds = true
        cell.label.text = "\(indexcrashType)"
        
        return cell
    }
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let string = item_value_reportDataArray[indexPath.item]
        
        // Create a temporary label to measure the text size
        let tempLabel = UILabel()
        tempLabel.text = (string as! String)
        tempLabel.font = UIFont.systemFont(ofSize: 12) // Match the font used in the cell
        tempLabel.numberOfLines = 0
        
        // Calculate the size of the label
        let width = tempLabel.intrinsicContentSize.width + 16 // 16 is padding
        let height = tempLabel.intrinsicContentSize.height + 16 // 16 is padding
         

        
        return CGSize(width: width, height: height)
    
}
    
    

    var activityIndicator = UIActivityIndicatorView()
    
    //Reference to site and audit ID
    var auditID = String()
    var siteID = String()
    //var userUID = String()
    
    let mainFunction = extens()
    let mainConsole = CONSOLE()
    
    
 
   
    var datePicker = UIDatePicker()
    var segmentControl = UISegmentedControl()
    
    var segmentControlCrashType = UISegmentedControl()

    var segmentActionWeather = UISegmentedControl()
  
    //var DetailsView: UITextView!
    var DetailsView: UITextView!
    
    var crashTypeSelected: UICollectionView!
    
    var headerContent: UILabel!
    var SubheaderContent: UILabel!
    var textCount: UILabel!
    
    var descriptionFromParent = String()
    var delegate: reportContentField?
    
    
    var questionIndex_key  = String()
    var questionIndex_value  = String()
    var item_value_reportData = String()
    var item_value_reportDataArray : [String] = []
    
//MARK: - check date if true function
    func isValidDate(_ dateString: String, withFormat format: String) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // Ensures consistent date parsing
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0) // Optionally set to GMT
        
        // Attempt to convert the string to a Date object
        return dateFormatter.date(from: dateString) != nil
    }
//MARK: - check date if true function
 
    
    
    override func viewDidLoad() {
        
        //add a nav bar button:
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(doneSaveBtn))
  
        
        //Convert JSON string to Data, this is required due to the following reasons. We need to
        guard let jsonData = "\(item_value_reportData)".data(using: .utf8) else {
            print("Error: Unable to convert string to Data")
            return
        }

        // Decode JSON data to array of strings
        do {
            let stringArray = try JSONDecoder().decode([String].self, from: jsonData)
            print(stringArray) // Output: ["Hit Train", "Adjacent approach"]
            
            item_value_reportDataArray = stringArray
        } catch {
            print("Error decoding JSON: \(error)")
        }
  
        

     
        
        super.viewDidLoad()
        

   
        activityIndicator.frame =  CGRectMake(0.0, 0.0, 40.0,40.0)
        activityIndicator.center = self.view.center
        self.view.addSubview(activityIndicator)
        activityIndicator.bringSubviewToFront(self.view)
        activityIndicator.startAnimating()
       

      




    }

    //sadfdasfsd
    
    override func viewDidAppear(_ animated: Bool) {
        
        activityIndicator.stopAnimating()
        
        
        switch questionIndex_key {
        case "📝 Audit Team Contact Name":
            
            headerContent = UILabel(frame: CGRect(x: 10, y: 100 + 20, width: Int(view.frame.width) - 20, height:  20))
            headerContent.text = questionIndex_key.uppercased()
            headerContent.font = UIFont.systemFont(ofSize: 12)
            headerContent.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            view.addSubview(headerContent)
            
            DetailsView = UITextView(frame: CGRect(x: 10, y: Int(self.headerContent.frame.maxY) + 10, width: Int(view.frame.width) - 20, height: 50 ))
            DetailsView.font = UIFont.boldSystemFont(ofSize: 25)
            DetailsView.delegate = self
            //DetailsView.layer.borderWidth = 2
            DetailsView.text = item_value_reportData
            DetailsView.layer.cornerRadius = 15
            DetailsView.layer.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
            DetailsView.layer.masksToBounds = true
            DetailsView.textAlignment = .left
            DetailsView.returnKeyType = .done
            DetailsView.becomeFirstResponder()
         
            self.view.addSubview(DetailsView)
            

            
        case "🏢 Audit Team Organisation":
            
            headerContent = UILabel(frame: CGRect(x: 10, y: 100 + 20, width: Int(view.frame.width) - 20, height:  20))
            headerContent.text = questionIndex_key.uppercased()
            headerContent.font = UIFont.systemFont(ofSize: 12)
            headerContent.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            view.addSubview(headerContent)
            
            DetailsView = UITextView(frame: CGRect(x: 10, y: Int(self.headerContent.frame.maxY) + 10, width: Int(view.frame.width) - 20, height: 50 ))
            DetailsView.font = UIFont.boldSystemFont(ofSize: 25)
            DetailsView.delegate = self
            //DetailsView.layer.borderWidth = 2
            DetailsView.text = item_value_reportData
            DetailsView.layer.cornerRadius = 15
            DetailsView.layer.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
            DetailsView.layer.masksToBounds = true
            DetailsView.textAlignment = .left
            DetailsView.returnKeyType = .done
            DetailsView.becomeFirstResponder()

            self.view.addSubview(DetailsView)
            
            

        case "📞 Audit Team Contact Details":
            
            headerContent = UILabel(frame: CGRect(x: 10, y: 100 + 20, width: Int(view.frame.width) - 20, height:  20))
            headerContent.text = questionIndex_key.uppercased()
            headerContent.font = UIFont.systemFont(ofSize: 12)
            headerContent.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            view.addSubview(headerContent)
            
            DetailsView = UITextView(frame: CGRect(x: 10, y: Int(self.headerContent.frame.maxY) + 10, width: Int(view.frame.width) - 20, height: 50 ))
            DetailsView.font = UIFont.boldSystemFont(ofSize: 25)
            DetailsView.delegate = self
            //DetailsView.layer.borderWidth = 2
            DetailsView.text = item_value_reportData
            DetailsView.layer.cornerRadius = 15
            DetailsView.layer.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
            DetailsView.layer.masksToBounds = true
            DetailsView.textAlignment = .left
            DetailsView.keyboardType = .numberPad
            DetailsView.becomeFirstResponder()

            self.view.addSubview(DetailsView)
            

            
            
        case "📝 Your company name":
            
            headerContent = UILabel(frame: CGRect(x: 10, y: 100 + 20, width: Int(view.frame.width) - 20, height:  20))
            headerContent.text = questionIndex_key.uppercased()
            headerContent.font = UIFont.systemFont(ofSize: 12)
            headerContent.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            view.addSubview(headerContent)
            
            DetailsView = UITextView(frame: CGRect(x: 10, y: Int(self.headerContent.frame.maxY) + 10, width: Int(view.frame.width) - 20, height: 50 ))
            DetailsView.font = UIFont.boldSystemFont(ofSize: 25)
            DetailsView.delegate = self
            //DetailsView.layer.borderWidth = 2
            DetailsView.text = item_value_reportData
            DetailsView.layer.cornerRadius = 15
            DetailsView.layer.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
            DetailsView.layer.masksToBounds = true
            DetailsView.textAlignment = .left
            DetailsView.returnKeyType = .done
            DetailsView.becomeFirstResponder()

            self.view.addSubview(DetailsView)
 
            
            
        case "🚧 Road Safety Audit Stage":
            
            //Open List
    
            //navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit Stage", style: .plain, target: self, action: #selector(addStage))
            
            perform(#selector(addDesigStageBtn), with: nil, afterDelay: 0.5)
            
            headerContent = UILabel(frame: CGRect(x: 10, y: 100 + 20, width: Int(view.frame.width) - 20, height:  20))
            headerContent.text = questionIndex_key.uppercased()
            headerContent.font = UIFont.systemFont(ofSize: 12)
            headerContent.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            view.addSubview(headerContent)
            
            DetailsView = UITextView(frame: CGRect(x: 10, y: Int(self.headerContent.frame.maxY) + 10, width: Int(view.frame.width) - 20, height: 50 ))
            DetailsView.font = UIFont.boldSystemFont(ofSize: 25)
            DetailsView.delegate = self
            //DetailsView.layer.borderWidth = 2
            DetailsView.text = item_value_reportData
            
            DetailsView.layer.cornerRadius = 15
            DetailsView.layer.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
            DetailsView.layer.masksToBounds = true
            DetailsView.textAlignment = .left
            DetailsView.returnKeyType = .done
    
            self.view.addSubview(DetailsView)


            
        case "📍 Project Location":
            
            headerContent = UILabel(frame: CGRect(x: 10, y: 100 + 20, width: Int(view.frame.width) - 20, height:  20))
            headerContent.text = questionIndex_key.uppercased()
            headerContent.font = UIFont.systemFont(ofSize: 12)
            headerContent.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            view.addSubview(headerContent)
            
            DetailsView = UITextView(frame: CGRect(x: 10, y: Int(self.headerContent.frame.maxY) + 10, width: Int(view.frame.width) - 20, height: 50 ))
            DetailsView.font = UIFont.boldSystemFont(ofSize: 25)
            DetailsView.delegate = self
            //DetailsView.layer.borderWidth = 2
            DetailsView.text = item_value_reportData
            DetailsView.layer.cornerRadius = 15
            DetailsView.layer.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
            DetailsView.layer.masksToBounds = true
            DetailsView.textAlignment = .left
            DetailsView.returnKeyType = .done
            DetailsView.becomeFirstResponder()
    
            self.view.addSubview(DetailsView)
          
            
        case "📝 Project Description":
            
            headerContent = UILabel(frame: CGRect(x: 10, y: 100 + 20, width: Int(view.frame.width) - 20, height:  20))
            headerContent.text = questionIndex_key.uppercased()
            headerContent.font = UIFont.systemFont(ofSize: 12)
            headerContent.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            view.addSubview(headerContent)
            
            DetailsView = UITextView(frame: CGRect(x: 10, y: Int(self.headerContent.frame.maxY) + 10, width: Int(view.frame.width) - 20, height: 200 ))
            DetailsView.font = UIFont.boldSystemFont(ofSize: 25)
            DetailsView.delegate = self
            //DetailsView.layer.borderWidth = 2
            DetailsView.text = item_value_reportData
            DetailsView.layer.cornerRadius = 15
            DetailsView.layer.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
            DetailsView.layer.masksToBounds = true
            DetailsView.textAlignment = .left
            DetailsView.returnKeyType = .done
            DetailsView.becomeFirstResponder()
            self.view.addSubview(DetailsView)
            
            textCount = UILabel(frame: CGRect(x: 10, y: Int(DetailsView.frame.maxY), width: Int(view.frame.width) - 20, height: 20 ))
            textCount.font = UIFont.systemFont(ofSize: 12)
            textCount.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            textCount.textAlignment = .right
            //textCount.text = "count:\(item_value_reportData.count)"
            self.view.addSubview(textCount)
        
        case "#️⃣ Project Number / Task Number":
            

            
            headerContent = UILabel(frame: CGRect(x: 10, y: 100 + 20, width: Int(view.frame.width) - 20, height:  20))
            headerContent.text = questionIndex_key.uppercased()
            headerContent.font = UIFont.systemFont(ofSize: 12)
            headerContent.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            view.addSubview(headerContent)
            
            DetailsView = UITextView(frame: CGRect(x: 10, y: Int(self.headerContent.frame.maxY) + 10, width: Int(view.frame.width) - 20, height: 50 ))
            DetailsView.font = UIFont.boldSystemFont(ofSize: 25)
            DetailsView.delegate = self
            //DetailsView.layer.borderWidth = 2
            DetailsView.text = item_value_reportData
            DetailsView.layer.cornerRadius = 15
            DetailsView.layer.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
            DetailsView.layer.masksToBounds = true
            DetailsView.textAlignment = .center

            DetailsView.keyboardType = .phonePad
            DetailsView.becomeFirstResponder()
            view.addSubview(DetailsView)
      

            

        
        case "🏢 Organisation / Department":
            
            headerContent = UILabel(frame: CGRect(x: 10, y: 100 + 20, width: Int(view.frame.width) - 20, height:  20))
            headerContent.text = questionIndex_key.uppercased()
            headerContent.font = UIFont.systemFont(ofSize: 12)
            headerContent.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            view.addSubview(headerContent)
            
            DetailsView = UITextView(frame: CGRect(x: 10, y: Int(self.headerContent.frame.maxY) + 10, width: Int(view.frame.width) - 20, height: 50 ))
            DetailsView.font = UIFont.boldSystemFont(ofSize: 25)
            DetailsView.delegate = self
            //DetailsView.layer.borderWidth = 2
            DetailsView.text = item_value_reportData
            DetailsView.layer.cornerRadius = 15
            DetailsView.layer.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
            DetailsView.layer.masksToBounds = true
            DetailsView.textAlignment = .left
            DetailsView.returnKeyType = .done
            DetailsView.becomeFirstResponder()
     
            self.view.addSubview(DetailsView)
        
        case "📝 Contact Name":
            
            headerContent = UILabel(frame: CGRect(x: 10, y: 100 + 20, width: Int(view.frame.width) - 20, height:  20))
            headerContent.text = questionIndex_key.uppercased()
            headerContent.font = UIFont.systemFont(ofSize: 12)
            headerContent.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            view.addSubview(headerContent)
            
            DetailsView = UITextView(frame: CGRect(x: 10, y: Int(self.headerContent.frame.maxY) + 10, width: Int(view.frame.width) - 20, height: 50 ))
            DetailsView.font = UIFont.boldSystemFont(ofSize: 25)
            DetailsView.delegate = self
            //DetailsView.layer.borderWidth = 2
            DetailsView.text = item_value_reportData
            DetailsView.layer.cornerRadius = 15
            DetailsView.layer.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
            DetailsView.layer.masksToBounds = true
            DetailsView.textAlignment = .left
            DetailsView.returnKeyType = .done
            DetailsView.becomeFirstResponder()
     
            self.view.addSubview(DetailsView)
      
            
        case "📞 Contact Tel. No.":
            
            headerContent = UILabel(frame: CGRect(x: 10, y: 100 + 20, width: Int(view.frame.width) - 20, height:  20))
            headerContent.text = questionIndex_key.uppercased()
            headerContent.font = UIFont.systemFont(ofSize: 12)
            headerContent.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            view.addSubview(headerContent)
            
            DetailsView = UITextView(frame: CGRect(x: 10, y: Int(self.headerContent.frame.maxY) + 10, width: Int(view.frame.width) - 20, height: 50 ))
            DetailsView.font = UIFont.boldSystemFont(ofSize: 25)
            DetailsView.delegate = self
            //DetailsView.layer.borderWidth = 2
            DetailsView.text = item_value_reportData
            DetailsView.layer.cornerRadius = 15
            DetailsView.layer.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
            DetailsView.layer.masksToBounds = true
            DetailsView.textAlignment = .center
            DetailsView.returnKeyType = .done
            DetailsView.keyboardType = .phonePad
            DetailsView.becomeFirstResponder()
            view.addSubview(DetailsView)
         
        
            

            
  
            
            
        case "📩 Email Address":
            
            headerContent = UILabel(frame: CGRect(x: 10, y: 100 + 20, width: Int(view.frame.width) - 20, height:  20))
            headerContent.text = questionIndex_key.uppercased()
            headerContent.font = UIFont.systemFont(ofSize: 12)
            headerContent.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            view.addSubview(headerContent)
            
            DetailsView = UITextView(frame: CGRect(x: 10, y: Int(self.headerContent.frame.maxY) + 10, width: Int(view.frame.width) - 20, height: 50 ))
            DetailsView.font = UIFont.boldSystemFont(ofSize: 25)
            DetailsView.delegate = self
            //DetailsView.layer.borderWidth = 2
            DetailsView.text = item_value_reportData
            DetailsView.layer.cornerRadius = 15
            DetailsView.layer.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
            DetailsView.layer.masksToBounds = true
            DetailsView.textAlignment = .left
            DetailsView.keyboardType = .emailAddress
            DetailsView.returnKeyType = .done
            DetailsView.becomeFirstResponder()
    
            self.view.addSubview(DetailsView)
            
        case "📅 Date the Final Audit is Required":
            
            headerContent = UILabel(frame: CGRect(x: 10, y: 100 + 20, width: Int(view.frame.width) - 20, height:  20))
            headerContent.text = questionIndex_key.uppercased()
            headerContent.font = UIFont.systemFont(ofSize: 12)
            headerContent.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            view.addSubview(headerContent)
            
            DetailsView = UITextView(frame: CGRect(x: 10, y: Int(self.headerContent.frame.maxY) + 10, width: Int(view.frame.width) - 20, height: 50 ))
            DetailsView.font = UIFont.boldSystemFont(ofSize: 25)
            DetailsView.delegate = self
            //DetailsView.layer.borderWidth = 2
            DetailsView.text = "  \(item_value_reportData)"
            DetailsView.layer.cornerRadius = 15
            DetailsView.layer.backgroundColor = .none
            DetailsView.layer.masksToBounds = true
            DetailsView.textAlignment = .right
            DetailsView.isHidden = true
   
            self.view.addSubview(DetailsView)
      
      
            // DatePicker
            datePicker.center = CGPoint(x: Int(headerContent.frame.minX) + 20, y: Int(self.headerContent.frame.maxY) + 35)
            datePicker.addTarget(self, action: #selector(handleDatePicker), for: .valueChanged)
            
            //Format Date
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
            
            if isValidDate(item_value_reportData, withFormat: dateFormatter.dateFormat) == false {
                datePicker.setDate(Date(timeIntervalSinceNow: 0), animated: true)
                datePicker.datePickerMode = .date
                datePicker.layer.masksToBounds = true
                
            }else{
                let date = dateFormatter.date(from: item_value_reportData)
                datePicker.setDate(date!, animated: true)
                datePicker.datePickerMode = .date
                datePicker.layer.masksToBounds = true
                
            }

            self.view.addSubview(datePicker)


            
        case "🚧 Previous Road Safety Audit":
            
            headerContent = UILabel(frame: CGRect(x: 10, y: 100 + 20, width: Int(view.frame.width) - 20, height:  20))
            headerContent.text = questionIndex_key.uppercased()
            headerContent.font = UIFont.systemFont(ofSize: 12)
            headerContent.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            view.addSubview(headerContent)
            
            DetailsView = UITextView(frame: CGRect(x: 10, y: Int(self.headerContent.frame.maxY) + 10, width: Int(view.frame.width) - 20, height: 50 ))
            DetailsView.font = UIFont.boldSystemFont(ofSize: 25)
            DetailsView.delegate = self
            //DetailsView.layer.borderWidth = 2
            DetailsView.text = item_value_reportData
            DetailsView.layer.cornerRadius = 15
            DetailsView.layer.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
            DetailsView.layer.masksToBounds = true
            DetailsView.textAlignment = .left
            DetailsView.returnKeyType = .done
            DetailsView.becomeFirstResponder()
 
            self.view.addSubview(DetailsView)
            
        case "🚧 Previous Road Safety Audit Stage":
            
            //Open List
  
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit Stage", style: .plain, target: self, action: #selector(addStage))
            
            headerContent = UILabel(frame: CGRect(x: 10, y: 100 + 20, width: Int(view.frame.width) - 20, height:  20))
            headerContent.text = questionIndex_key.uppercased()
            headerContent.font = UIFont.systemFont(ofSize: 12)
            headerContent.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            view.addSubview(headerContent)
            
            DetailsView = UITextView(frame: CGRect(x: 10, y: Int(self.headerContent.frame.maxY) + 10, width: Int(view.frame.width) - 20, height: 50 ))
            DetailsView.font = UIFont.boldSystemFont(ofSize: 25)
            DetailsView.delegate = self
            //DetailsView.layer.borderWidth = 2
            DetailsView.text = item_value_reportData
            
            DetailsView.layer.cornerRadius = 15
            DetailsView.layer.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
            DetailsView.layer.masksToBounds = true
            DetailsView.textAlignment = .left
            DetailsView.returnKeyType = .done
            self.view.addSubview(DetailsView)
            
       
       
        
        case "📅 Previous Audit Date":
            
            headerContent = UILabel(frame: CGRect(x: 10, y: 100 + 20, width: Int(view.frame.width) - 20, height:  20))
            headerContent.text = questionIndex_key.uppercased()
            headerContent.font = UIFont.systemFont(ofSize: 12)
            headerContent.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            view.addSubview(headerContent)
            
            DetailsView = UITextView(frame: CGRect(x: 10, y: Int(self.headerContent.frame.maxY) + 10, width: Int(view.frame.width) - 20, height: 50 ))
            DetailsView.font = UIFont.boldSystemFont(ofSize: 25)
            DetailsView.delegate = self
            //DetailsView.layer.borderWidth = 2
            DetailsView.text = "  \(item_value_reportData)"
            DetailsView.layer.cornerRadius = 15
            DetailsView.layer.backgroundColor = .none
            DetailsView.layer.masksToBounds = true
            DetailsView.textAlignment = .right
            
            DetailsView.isHidden = true
            self.view.addSubview(DetailsView)
      
      
            // DatePicker
            datePicker.center = CGPoint(x: Int(headerContent.frame.minX) + 20, y: Int(self.headerContent.frame.maxY) + 35)
            datePicker.addTarget(self, action: #selector(handleDatePicker), for: .valueChanged)
   
            //Formate Date
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
            
            if isValidDate(item_value_reportData, withFormat: dateFormatter.dateFormat) == false {
                datePicker.setDate(Date(timeIntervalSinceNow: 0), animated: true)
                datePicker.datePickerMode = .date
                datePicker.layer.masksToBounds = true
                
            }else{
                let date = dateFormatter.date(from: item_value_reportData)
                datePicker.setDate(date!, animated: true)
                datePicker.datePickerMode = .date
                datePicker.layer.masksToBounds = true
                
            }

            self.view.addSubview(datePicker)

        case "🏢 Previous Audit Organisation":
            
            headerContent = UILabel(frame: CGRect(x: 10, y: 100 + 20, width: Int(view.frame.width) - 20, height:  20))
            headerContent.text = questionIndex_key.uppercased()
            headerContent.font = UIFont.systemFont(ofSize: 12)
            headerContent.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            view.addSubview(headerContent)
            
            DetailsView = UITextView(frame: CGRect(x: 10, y: Int(self.headerContent.frame.maxY) + 10, width: Int(view.frame.width) - 20, height: 50 ))
            DetailsView.font = UIFont.boldSystemFont(ofSize: 25)
            DetailsView.delegate = self
            //DetailsView.layer.borderWidth = 2
            DetailsView.text = item_value_reportData
            DetailsView.layer.cornerRadius = 15
            DetailsView.layer.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
            DetailsView.layer.masksToBounds = true
            DetailsView.textAlignment = .left
            DetailsView.returnKeyType = .done
            DetailsView.becomeFirstResponder()
     
            self.view.addSubview(DetailsView)
         
        case "👷 Previous Audit Team Leader":
            
            headerContent = UILabel(frame: CGRect(x: 10, y: 100 + 20, width: Int(view.frame.width) - 20, height:  20))
            headerContent.text = questionIndex_key.uppercased()
            headerContent.font = UIFont.systemFont(ofSize: 12)
            headerContent.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            view.addSubview(headerContent)
            
            DetailsView = UITextView(frame: CGRect(x: 10, y: Int(self.headerContent.frame.maxY) + 10, width: Int(view.frame.width) - 20, height: 50 ))
            DetailsView.font = UIFont.boldSystemFont(ofSize: 25)
            DetailsView.delegate = self
            //DetailsView.layer.borderWidth = 2
            DetailsView.text = item_value_reportData
            DetailsView.layer.cornerRadius = 15
            DetailsView.layer.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
            DetailsView.layer.masksToBounds = true
            DetailsView.textAlignment = .left
            DetailsView.returnKeyType = .done
            DetailsView.becomeFirstResponder()
            //
            self.view.addSubview(DetailsView)
            
            
        case "📄 Copy of Audit and CAR Provided":
            
            headerContent = UILabel(frame: CGRect(x: 10, y: 100 + 20, width: Int(view.frame.width) - 20, height:  20))
            headerContent.text = questionIndex_key.uppercased()
            headerContent.font = UIFont.systemFont(ofSize: 12)
            headerContent.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            view.addSubview(headerContent)
        
            
            DetailsView = UITextView(frame: CGRect(x: 10, y: Int(self.headerContent.frame.maxY) + 10, width: Int(view.frame.width) - 20, height: 50 ))
            DetailsView.font = UIFont.boldSystemFont(ofSize: 25)
            DetailsView.delegate = self
            //DetailsView.layer.borderWidth = 2
            DetailsView.text = item_value_reportData
            DetailsView.layer.cornerRadius = 15
            DetailsView.layer.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
            DetailsView.layer.masksToBounds = true
            DetailsView.textAlignment = .left
            DetailsView.returnKeyType = .done
            DetailsView.becomeFirstResponder()
            DetailsView.isHidden = true
            //
            self.view.addSubview(DetailsView)
            
            let items = ["Yes", "No", "Unknown"]
            segmentControl = UISegmentedControl(items: items)
            segmentControl.frame = CGRect(x: 10, y: Int(headerContent.frame.maxY) + 10, width: Int(view.frame.width) - 20, height: 30)
            segmentControl.addTarget(self, action: #selector(segmentAction(_:)), for: .valueChanged)
            
            switch item_value_reportData{
            case "Yes":
                segmentControl.selectedSegmentIndex = 0
                break
            case "No":
                segmentControl.selectedSegmentIndex = 1
                break
            default:
                segmentControl.selectedSegmentIndex = 2
                break
            }
            
            view.addSubview(segmentControl)
            
            
        case "🚦 Safe System Assessments":
            
            headerContent = UILabel(frame: CGRect(x: 10, y: 100 + 20, width: Int(view.frame.width) - 20, height:  20))
            headerContent.text = questionIndex_key.uppercased()
            headerContent.font = UIFont.systemFont(ofSize: 12)
            headerContent.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            view.addSubview(headerContent)
            
            DetailsView = UITextView(frame: CGRect(x: 10, y: Int(self.headerContent.frame.maxY) + 10, width: Int(view.frame.width) - 20, height: 50 ))
            DetailsView.font = UIFont.boldSystemFont(ofSize: 25)
            DetailsView.delegate = self
            //DetailsView.layer.borderWidth = 2
            DetailsView.text = item_value_reportData
            DetailsView.layer.cornerRadius = 15
            DetailsView.layer.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
            DetailsView.layer.masksToBounds = true
            DetailsView.textAlignment = .left
            DetailsView.returnKeyType = .done
            DetailsView.becomeFirstResponder()
            //
            self.view.addSubview(DetailsView)
            
        case "📅 Assessment Date":
            
            headerContent = UILabel(frame: CGRect(x: 10, y: 100 + 20, width: Int(view.frame.width) - 20, height:  20))
            headerContent.text = questionIndex_key.uppercased()
            headerContent.font = UIFont.systemFont(ofSize: 12)
            headerContent.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            view.addSubview(headerContent)
            
            DetailsView = UITextView(frame: CGRect(x: 10, y: Int(self.headerContent.frame.maxY) + 10, width: Int(view.frame.width) - 20, height: 50 ))
            DetailsView.font = UIFont.boldSystemFont(ofSize: 25)
            DetailsView.delegate = self
            //DetailsView.layer.borderWidth = 2
            DetailsView.text = "  \(item_value_reportData)"
            DetailsView.layer.cornerRadius = 15
            DetailsView.layer.backgroundColor = .none
            DetailsView.layer.masksToBounds = true
            DetailsView.textAlignment = .right
            //
            DetailsView.isHidden = true
            self.view.addSubview(DetailsView)
      
      
            // DatePicker
            datePicker.center = CGPoint(x: Int(headerContent.frame.minX) + 20, y: Int(self.headerContent.frame.maxY) + 35)
            datePicker.addTarget(self, action: #selector(handleDatePicker), for: .valueChanged)
   
         
            //Format Date
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
            
            if isValidDate(item_value_reportData, withFormat: dateFormatter.dateFormat) == false {
                datePicker.setDate(Date(timeIntervalSinceNow: 0), animated: true)
                datePicker.datePickerMode = .date
                datePicker.layer.masksToBounds = true
                
            }else{
                let date = dateFormatter.date(from: item_value_reportData)
                datePicker.setDate(date!, animated: true)
                datePicker.datePickerMode = .date
                datePicker.layer.masksToBounds = true
                
            }

            self.view.addSubview(datePicker)
            
        case "🏢 Assessment Organisation":
            
            headerContent = UILabel(frame: CGRect(x: 10, y: 100 + 20, width: Int(view.frame.width) - 20, height:  20))
            headerContent.text = questionIndex_key.uppercased()
            headerContent.font = UIFont.systemFont(ofSize: 12)
            headerContent.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            view.addSubview(headerContent)
            
            DetailsView = UITextView(frame: CGRect(x: 10, y: Int(self.headerContent.frame.maxY) + 10, width: Int(view.frame.width) - 20, height: 50 ))
            DetailsView.font = UIFont.boldSystemFont(ofSize: 25)
            DetailsView.delegate = self
            //DetailsView.layer.borderWidth = 2
            DetailsView.text = item_value_reportData
            DetailsView.layer.cornerRadius = 15
            DetailsView.layer.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
            DetailsView.layer.masksToBounds = true
            DetailsView.textAlignment = .left
            DetailsView.returnKeyType = .done
            DetailsView.becomeFirstResponder()
            //
            self.view.addSubview(DetailsView)
            
            
        case "📄 Copy of Assessment Provided":
            
            headerContent = UILabel(frame: CGRect(x: 10, y: 100 + 20, width: Int(view.frame.width) - 20, height:  20))
            headerContent.text = questionIndex_key.uppercased()
            headerContent.font = UIFont.systemFont(ofSize: 12)
            headerContent.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            view.addSubview(headerContent)
            
            DetailsView = UITextView(frame: CGRect(x: 10, y: Int(self.headerContent.frame.maxY) + 10, width: Int(view.frame.width) - 20, height: 50 ))
            DetailsView.font = UIFont.boldSystemFont(ofSize: 25)
            DetailsView.delegate = self
            //DetailsView.layer.borderWidth = 2
            DetailsView.text = item_value_reportData
            DetailsView.layer.cornerRadius = 15
            DetailsView.layer.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
            DetailsView.layer.masksToBounds = true
            DetailsView.textAlignment = .left
            DetailsView.returnKeyType = .done
            //
            DetailsView.isHidden = true
            DetailsView.becomeFirstResponder()
            self.view.addSubview(DetailsView)
            
            let items = ["Yes", "No", "Unknown"]
            segmentControl = UISegmentedControl(items: items)
            segmentControl.frame = CGRect(x: 10, y: Int(headerContent.frame.maxY) + 10, width: Int(view.frame.width) - 20, height: 30)
            segmentControl.addTarget(self, action: #selector(segmentAction(_:)), for: .valueChanged)
            
            switch item_value_reportData{
            case "Yes":
                segmentControl.selectedSegmentIndex = 0
                break
            case "No":
                segmentControl.selectedSegmentIndex = 1
                break
            default:
                segmentControl.selectedSegmentIndex = 2
                break
            }
            
            view.addSubview(segmentControl)
      
        case "📝 Project Objective":
            
            headerContent = UILabel(frame: CGRect(x: 10, y: 100 + 20, width: Int(view.frame.width) - 20, height:  20))
            headerContent.text = questionIndex_key.uppercased()
            headerContent.font = UIFont.systemFont(ofSize: 12)
            headerContent.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            view.addSubview(headerContent)
            
            DetailsView = UITextView(frame: CGRect(x: 10, y: Int(self.headerContent.frame.maxY) + 10, width: Int(view.frame.width) - 20, height: 50 ))
            DetailsView.font = UIFont.boldSystemFont(ofSize: 25)
            DetailsView.delegate = self
            //DetailsView.layer.borderWidth = 2
            DetailsView.text = item_value_reportData
            DetailsView.layer.cornerRadius = 15
            DetailsView.layer.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
            DetailsView.layer.masksToBounds = true
            DetailsView.textAlignment = .left
            DetailsView.returnKeyType = .done
            DetailsView.becomeFirstResponder()
            self.view.addSubview(DetailsView)
            
            
        case "🚦 Speed Limit / Design Speed":
            
            headerContent = UILabel(frame: CGRect(x: 10, y: 100 + 20, width: Int(view.frame.width) - 20, height:  20))
            headerContent.text = questionIndex_key.uppercased()
            headerContent.font = UIFont.systemFont(ofSize: 12)
            headerContent.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            view.addSubview(headerContent)
            
            DetailsView = UITextView(frame: CGRect(x: Int(view.frame.width)/2 - 50, y: Int(self.headerContent.frame.maxY) + 10, width: 100, height: 100 ))
            DetailsView.font = UIFont.boldSystemFont(ofSize: 30)
            //DetailsView.sizeToFit()
            DetailsView.delegate = self
            DetailsView.layer.borderWidth = 5
            DetailsView.layer.borderColor = #colorLiteral(red: 1, green: 0.231372549, blue: 0.1882352941, alpha: 1)
            DetailsView.text = item_value_reportData
            DetailsView.layer.cornerRadius = 50
            DetailsView.layer.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
            DetailsView.layer.masksToBounds = true
            DetailsView.textAlignment = .center
            DetailsView.returnKeyType = .done
            DetailsView.keyboardType = .phonePad
            DetailsView.becomeFirstResponder()
            view.addSubview(DetailsView)
         
            

            
        case "📄 Standards, Departures from Standards and Mitigation":
            
            headerContent = UILabel(frame: CGRect(x: 10, y: 100 + 20, width: Int(view.frame.width) - 20, height:  20))
            headerContent.text = questionIndex_key.uppercased()
            headerContent.font = UIFont.systemFont(ofSize: 12)
            headerContent.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            view.addSubview(headerContent)
            
            DetailsView = UITextView(frame: CGRect(x: 10, y: Int(self.headerContent.frame.maxY) + 10, width: Int(view.frame.width) - 20, height: 50 ))
            DetailsView.font = UIFont.boldSystemFont(ofSize: 25)
            DetailsView.delegate = self
            //DetailsView.layer.borderWidth = 2
            DetailsView.text = item_value_reportData
            DetailsView.layer.cornerRadius = 15
            DetailsView.layer.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
            DetailsView.layer.masksToBounds = true
            DetailsView.textAlignment = .left
            DetailsView.returnKeyType = .done
            DetailsView.becomeFirstResponder()
            //
            self.view.addSubview(DetailsView)
            
        case "🚘 Existing Traffic Flows":
            
            headerContent = UILabel(frame: CGRect(x: 10, y: 100 + 20, width: Int(view.frame.width) - 20, height:  20))
            headerContent.text = questionIndex_key.uppercased()
            headerContent.font = UIFont.systemFont(ofSize: 12)
            headerContent.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            view.addSubview(headerContent)
            
            DetailsView = UITextView(frame: CGRect(x: 10, y: Int(self.headerContent.frame.maxY) + 10, width: Int(view.frame.width) - 20, height: 50 ))
            DetailsView.font = UIFont.boldSystemFont(ofSize: 25)
            DetailsView.delegate = self
            //DetailsView.layer.borderWidth = 2
            DetailsView.text = item_value_reportData
            DetailsView.layer.cornerRadius = 15
            DetailsView.layer.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
            DetailsView.layer.masksToBounds = true
            DetailsView.textAlignment = .center
            DetailsView.returnKeyType = .done
            DetailsView.keyboardType = .phonePad
            DetailsView.becomeFirstResponder()
            view.addSubview(DetailsView)
         

            

            
        case "🚘 Forecast Traffic Flows":
            
            headerContent = UILabel(frame: CGRect(x: 10, y: 100 + 20, width: Int(view.frame.width) - 20, height:  20))
            headerContent.text = questionIndex_key.uppercased()
            headerContent.font = UIFont.systemFont(ofSize: 12)
            headerContent.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            view.addSubview(headerContent)
            
            DetailsView = UITextView(frame: CGRect(x: 10, y: Int(self.headerContent.frame.maxY) + 10, width: Int(view.frame.width) - 20, height: 50 ))
            DetailsView.font = UIFont.boldSystemFont(ofSize: 25)
            DetailsView.delegate = self
            //DetailsView.layer.borderWidth = 2
            DetailsView.text = item_value_reportData
            DetailsView.layer.cornerRadius = 15
            DetailsView.layer.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
            DetailsView.layer.masksToBounds = true
            DetailsView.textAlignment = .center
            DetailsView.returnKeyType = .done
            DetailsView.keyboardType = .phonePad
            DetailsView.becomeFirstResponder()
            view.addSubview(DetailsView)
         
         
        
        case "💥 Crash Data (5 Years)":
            
            headerContent = UILabel(frame: CGRect(x: 10, y: 100 + 20, width: Int(view.frame.width) - 20, height:  20))
            headerContent.text = questionIndex_key.uppercased()
            headerContent.font = UIFont.systemFont(ofSize: 12)
            headerContent.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            view.addSubview(headerContent)
            


            
            DetailsView = UITextView(frame: CGRect(x: 10, y: 50, width: Int(view.frame.width) - 20, height: 100 ))
            DetailsView.font = UIFont.boldSystemFont(ofSize: 25)
            DetailsView.delegate = self
            //DetailsView.layer.borderWidth = 2
            DetailsView.text = item_value_reportData
            DetailsView.layer.cornerRadius = 15
            DetailsView.layer.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
            DetailsView.layer.masksToBounds = true
            DetailsView.textAlignment = .left
            DetailsView.returnKeyType = .done
            //DetailsView.becomeFirstResponder()
            DetailsView.isHidden = true
            self.view.addSubview(DetailsView)
        
            // Create a UICollectionViewFlowLayout
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            //layout.itemSize = CGSize(width: 40, height: 10) // Adjust size as needed
            layout.minimumInteritemSpacing = 2
            layout.minimumLineSpacing = 2
           
        
            
            
            //Let user set if crash data was avaliable in the last 5 years, if yes we can let them choose the data type, if no the text will be "0".
            
            let items = ["Yes", "No"]
            segmentControlCrashType = UISegmentedControl(items: items)
            segmentControlCrashType.frame = CGRect(x: 10, y: Int(headerContent.frame.maxY) + 10, width: Int(view.frame.width) - 20, height: 30)
            segmentControlCrashType.addTarget(self, action: #selector(segmentControlCrashTypesegmentAction(_:)), for: .valueChanged)
            

       
            

            
            view.addSubview(segmentControlCrashType)
            
            SubheaderContent = UILabel(frame: CGRect(x: 10, y: Int(segmentControlCrashType.frame.maxY) + 20, width: Int(view.frame.width) - 20, height:  40))
           
            SubheaderContent.font = UIFont.systemFont(ofSize: 12)
            SubheaderContent.numberOfLines = 5
            SubheaderContent.adjustsFontSizeToFitWidth = true
            SubheaderContent.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            view.addSubview(SubheaderContent)
            
            // Initialize the UICollectionView with the layout
            crashTypeSelected = UICollectionView(frame: CGRect(x: 10, y: Int(SubheaderContent.frame.maxY) + 20, width: Int(view.frame.width) - 20, height: 200 ), collectionViewLayout: layout)
            crashTypeSelected.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
            crashTypeSelected.isHidden = false
            self.crashTypeSelected?.dataSource = self
            self.crashTypeSelected?.delegate = self
            crashTypeSelected.register(crashTypeCell.self, forCellWithReuseIdentifier: "crashTypeCell")
     
            self.view.addSubview(crashTypeSelected)
            
            
            if item_value_reportDataArray[0] == "no" {
                SubheaderContent.text = "In the last 5 years, there has been no or unknown crashes recorded at this location."
                segmentControlCrashType.selectedSegmentIndex = 1
            }else{
                SubheaderContent.text = "In the last 5 years, what were the common crash types experienced at this location?"
                segmentControlCrashType.selectedSegmentIndex = 0
                addCrashTypeBtn()
            }
            
//        case "🚘 Speed Survey Data":
//            
//            headerContent = UILabel(frame: CGRect(x: 10, y: 100 + 20, width: Int(view.frame.width) - 20, height:  20))
//            headerContent.text = questionIndex_key.uppercased()
//            headerContent.font = UIFont.systemFont(ofSize: 12)
//            headerContent.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
//            view.addSubview(headerContent)
//            
//            DetailsView = UITextView(frame: CGRect(x: 10, y: Int(self.headerContent.frame.maxY) + 10, width: Int(view.frame.width) - 20, height: 50 ))
//            DetailsView.font = UIFont.boldSystemFont(ofSize: 25)
//            DetailsView.delegate = self
//            //DetailsView.layer.borderWidth = 2
//            DetailsView.text = item_value_reportData
//            DetailsView.layer.cornerRadius = 15
//            DetailsView.layer.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
//            DetailsView.layer.masksToBounds = true
//            DetailsView.textAlignment = .left
//            DetailsView.returnKeyType = .done
//            //
//            DetailsView.becomeFirstResponder()
//            DetailsView.isHidden = true
//            self.view.addSubview(DetailsView)
//            
//            let items = ["Yes", "No", "Unknown"]
//            segmentControl = UISegmentedControl(items: items)
//            segmentControl.frame = CGRect(x: 10, y: Int(headerContent.frame.maxY) + 10, width: Int(view.frame.width) - 20, height: 30)
//            segmentControl.addTarget(self, action: #selector(segmentAction(_:)), for: .valueChanged)
//            
//            switch item_value_reportData{
//            case "Yes":
//                segmentControl.selectedSegmentIndex = 0
//                break
//            case "No":
//                segmentControl.selectedSegmentIndex = 1
//                break
//            default:
//                segmentControl.selectedSegmentIndex = 2
//                break
//            }
//            
//            view.addSubview(segmentControl)
            
        case "📝 Audit Requested By":
            
            headerContent = UILabel(frame: CGRect(x: 10, y: 100 + 20, width: Int(view.frame.width) - 20, height:  20))
            headerContent.text = questionIndex_key.uppercased()
            headerContent.font = UIFont.systemFont(ofSize: 12)
            headerContent.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            view.addSubview(headerContent)

            DetailsView = UITextView(frame: CGRect(x: 10, y: Int(self.headerContent.frame.maxY) + 10, width: Int(view.frame.width) - 20, height: 50 ))
            DetailsView.font = UIFont.boldSystemFont(ofSize: 25)
            DetailsView.delegate = self
            //DetailsView.layer.borderWidth = 2
            DetailsView.text = item_value_reportData
            DetailsView.layer.cornerRadius = 15
            DetailsView.layer.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
            DetailsView.layer.masksToBounds = true
            DetailsView.textAlignment = .left
            DetailsView.returnKeyType = .done
            DetailsView.becomeFirstResponder()
            //
            self.view.addSubview(DetailsView)
       
        case "📅 Date Request Received":
            
            headerContent = UILabel(frame: CGRect(x: 10, y: 100 + 20, width: Int(view.frame.width) - 20, height:  20))
            headerContent.text = questionIndex_key.uppercased()
            headerContent.font = UIFont.systemFont(ofSize: 12)
            headerContent.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            view.addSubview(headerContent)
            
            DetailsView = UITextView(frame: CGRect(x: 10, y: Int(self.headerContent.frame.maxY) + 10, width: Int(view.frame.width) - 20, height: 50 ))
            DetailsView.font = UIFont.boldSystemFont(ofSize: 25)
            DetailsView.delegate = self
            //DetailsView.layer.borderWidth = 2
            DetailsView.text = "  \(item_value_reportData)"
            DetailsView.layer.cornerRadius = 15
            DetailsView.layer.backgroundColor = .none
            DetailsView.layer.masksToBounds = true
            DetailsView.textAlignment = .right
          //
            DetailsView.isHidden = true
            self.view.addSubview(DetailsView)
      
      
            // DatePicker
            datePicker.center = CGPoint(x: Int(headerContent.frame.minX) + 20, y: Int(self.headerContent.frame.maxY) + 35)
            datePicker.addTarget(self, action: #selector(handleDatePicker), for: .valueChanged)
   
     
            //Format Date
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
            
            if isValidDate(item_value_reportData, withFormat: dateFormatter.dateFormat) == false {
                datePicker.setDate(Date(timeIntervalSinceNow: 0), animated: true)
                datePicker.datePickerMode = .date
                datePicker.layer.masksToBounds = true
                
            }else{
                let date = dateFormatter.date(from: item_value_reportData)
                datePicker.setDate(date!, animated: true)
                datePicker.datePickerMode = .date
                datePicker.layer.masksToBounds = true
                
            }

            self.view.addSubview(datePicker)
            
            
        case "📝 Audit Reference Number":
            
            headerContent = UILabel(frame: CGRect(x: 10, y: 100 + 20, width: Int(view.frame.width) - 20, height:  20))
            headerContent.text = questionIndex_key.uppercased()
            headerContent.font = UIFont.systemFont(ofSize: 12)
            headerContent.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            view.addSubview(headerContent)
            
            DetailsView = UITextView(frame: CGRect(x: 10, y: Int(self.headerContent.frame.maxY) + 10, width: Int(view.frame.width) - 20, height: 50 ))
            DetailsView.font = UIFont.boldSystemFont(ofSize: 25)
            DetailsView.delegate = self
            //DetailsView.layer.borderWidth = 2
            DetailsView.text = item_value_reportData
            DetailsView.layer.cornerRadius = 15
            DetailsView.layer.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
            DetailsView.layer.masksToBounds = true
            DetailsView.textAlignment = .center
            DetailsView.returnKeyType = .done
            DetailsView.keyboardType = .phonePad
            DetailsView.becomeFirstResponder()
            view.addSubview(DetailsView)
         

        
            
        case "👷 Audit Team Leader":
            
            headerContent = UILabel(frame: CGRect(x: 10, y: 100 + 20, width: Int(view.frame.width) - 20, height:  20))
            headerContent.text = questionIndex_key.uppercased()
            headerContent.font = UIFont.systemFont(ofSize: 12)
            headerContent.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            view.addSubview(headerContent)

            DetailsView = UITextView(frame: CGRect(x: 10, y: Int(self.headerContent.frame.maxY) + 10, width: Int(view.frame.width) - 20, height: 50 ))
            DetailsView.font = UIFont.boldSystemFont(ofSize: 25)
            DetailsView.delegate = self
            //DetailsView.layer.borderWidth = 2
            DetailsView.text = item_value_reportData
            DetailsView.layer.cornerRadius = 15
            DetailsView.layer.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
            DetailsView.layer.masksToBounds = true
            DetailsView.textAlignment = .left
            DetailsView.returnKeyType = .done
            DetailsView.becomeFirstResponder()
            //
            self.view.addSubview(DetailsView)
            
            
        case "📅 Audit Assessment Date":
            
            headerContent = UILabel(frame: CGRect(x: 10, y: 100 + 20, width: Int(view.frame.width) - 20, height:  20))
            headerContent.text = questionIndex_key.uppercased()
            headerContent.font = UIFont.systemFont(ofSize: 12)
            headerContent.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            view.addSubview(headerContent)
            
            DetailsView = UITextView(frame: CGRect(x: 10, y: Int(self.headerContent.frame.maxY) + 10, width: Int(view.frame.width) - 20, height: 50 ))
            DetailsView.font = UIFont.boldSystemFont(ofSize: 25)
            DetailsView.delegate = self
            //DetailsView.layer.borderWidth = 2
            DetailsView.text = "  \(item_value_reportData)"
            DetailsView.layer.cornerRadius = 15
            DetailsView.layer.backgroundColor = .none
            DetailsView.layer.masksToBounds = true
            DetailsView.textAlignment = .right
            
            DetailsView.isHidden = true
            self.view.addSubview(DetailsView)
      
      
            // DatePicker
            datePicker.center = CGPoint(x: Int(headerContent.frame.minX) + 20, y: Int(self.headerContent.frame.maxY) + 35)
            datePicker.addTarget(self, action: #selector(handleDatePicker), for: .valueChanged)
            
            //Format Date
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
            
            if isValidDate(item_value_reportData, withFormat: dateFormatter.dateFormat) == false {
                datePicker.setDate(Date(timeIntervalSinceNow: 0), animated: true)
                datePicker.datePickerMode = .date
                datePicker.layer.masksToBounds = true
                
            }else{
                let date = dateFormatter.date(from: item_value_reportData)
                datePicker.setDate(date!, animated: true)
                datePicker.datePickerMode = .date
                datePicker.layer.masksToBounds = true
                
            }

            self.view.addSubview(datePicker)
            
            
        case "☀️ Weather Condition":
            
            headerContent = UILabel(frame: CGRect(x: 10, y: 100 + 20, width: Int(view.frame.width) - 20, height:  20))
            headerContent.text = questionIndex_key.uppercased()
            headerContent.font = UIFont.systemFont(ofSize: 12)
            headerContent.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            view.addSubview(headerContent)

            DetailsView = UITextView(frame: CGRect(x: 10, y: Int(self.headerContent.frame.maxY) + 10, width: Int(view.frame.width) - 20, height: 50 ))
            DetailsView.font = UIFont.boldSystemFont(ofSize: 25)
            DetailsView.delegate = self
            //DetailsView.layer.borderWidth = 2
            DetailsView.text = item_value_reportData
            DetailsView.layer.cornerRadius = 15
            DetailsView.layer.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
            DetailsView.layer.masksToBounds = true
            DetailsView.textAlignment = .left
            DetailsView.returnKeyType = .done
            DetailsView.becomeFirstResponder()
            DetailsView.isHidden = true
            //
            self.view.addSubview(DetailsView)
            
            
            let items = ["Rain", "Good", "Cloudy", "Dark"]
            segmentActionWeather = UISegmentedControl(items: items)
            segmentActionWeather.frame = CGRect(x: 10, y: Int(headerContent.frame.maxY) + 10, width: Int(view.frame.width) - 20, height: 30)
            segmentActionWeather.addTarget(self, action: #selector(segmentActionWeather(_:)), for: .valueChanged)
            
            switch item_value_reportData{
            case "Rain":
                segmentActionWeather.selectedSegmentIndex = 0
                break
            case "Good":
                segmentActionWeather.selectedSegmentIndex = 1
                break
            case "Cloudy":
                segmentActionWeather.selectedSegmentIndex = 2
                break
            default:
                segmentActionWeather.selectedSegmentIndex = 3
                break
            }
            view.addSubview(segmentActionWeather)
            
        default:
            
            break
           
            

            
        }
        
    }
    
    //MARK: - segue to select category page
//    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let destination = segue.destination as? CategoryTableViewController {
//            
//            destination.delegate = self
//            
//        }
//    
//        else {
//            
//        }
//   
//            
//            
//        }

// MARK: - category protocol
    
    func finishPassing_category(saveCategory: String) {
        //Display audit stage cell when the string is not empty.
        if (self.item_value_reportData != ""){

            item_value_reportData = saveCategory
            DetailsView.text = "\(item_value_reportData)"
         
            
        }else{
  
         
        }
    }
    
    
    func finishPassing_crashType(savecrashType: [String]) {
        if (self.item_value_reportData != ""){
  
            item_value_reportDataArray = savecrashType
            DetailsView.text = "\(item_value_reportDataArray)"
            
            crashTypeSelected.reloadData()
            
        }else{
            print ("empty")
         
        }
    }
    
    
//MARK: - choose project Stage
    
    @objc func addStage(){
        performSegue(withIdentifier: "showStage", sender: self)
    }
    
    
//MARK: - save data
    func saveData(question:String, ref:String, textData:String){
         
        
            SwiftLoader.show(title: "Updating", animated: true)
            let reftest = Database.database().reference(withPath:"\(ref)")
    
            reftest.updateChildValues([
                "\(question)": textData,
            ]){
                (error:Error?, ref:DatabaseReference) in
                if let error = error {
                    print("Data could not be saved: \(error).")
                    
                    SwiftLoader.hide()
                    self.mainFunction.errorUpload(errorMessage: "Data could not be saved",subtitle: "\(error)")

                } else {
                    
                    print("Data saved successfully!")
                    
                    self.mainFunction.successUpload(Message: "Updated", subtitle: "")
                    SwiftLoader.hide()
                    
                    
                    //dismiss the view
                    //self.dismiss(animated: true, completion: nil)
                    self.navigationController?.popViewController(animated: true)
                }
            }
    
        
    }

    
    
    
    
    
//MARK: - crashType button pressed
    
    
    @objc func addCrashTypeBtn(){
        

        
        let crashTypesView = crashTypes()
        let nav = UINavigationController(rootViewController: crashTypesView)
        nav.navigationBar.prefersLargeTitles = true

        nav.navigationBar.topItem!.title = "Crash types"
        nav.navigationBar.tintColor = .black
        nav.modalPresentationStyle = .pageSheet
        nav.isModalInPresentation = true
        crashTypesView.delegate = self
        crashTypesView.crashDataArray = item_value_reportDataArray // send data to this view based on the loaded data, this will always populate the crash type view with highlighted data.
        
            
            if let presentationController = nav.presentationController as? UISheetPresentationController {
                presentationController.detents = [.medium(),.large()] /// change to [.medium(), .large()] for a half *and* full screen sheet
                presentationController.prefersGrabberVisible = true
                presentationController.preferredCornerRadius = 45
                
   
                
       
 
                presentationController.largestUndimmedDetentIdentifier = .large
                //presentationController.prefersScrollingExpandsWhenScrolledToEdge = false
            }
            
            
            
            self.present(nav, animated: true)
        

     
    
    }
    
    
    @objc func addDesigStageBtn(){
        

        
        let designCategory = CategoryTableViewController()
        let nav = UINavigationController(rootViewController: designCategory)
        nav.navigationBar.prefersLargeTitles = true

        nav.navigationBar.topItem!.title = "Design Stage"
        nav.navigationBar.tintColor = .black
        nav.modalPresentationStyle = .pageSheet
        nav.isModalInPresentation = true
        designCategory.delegate = self
        //designCategory.crashDataArray = item_value_reportDataArray // send data to this view based on the loaded data, this will always populate the crash type view with highlighted data.
        
            
            if let presentationController = nav.presentationController as? UISheetPresentationController {
                presentationController.detents = [.medium(),.large()] /// change to [.medium(), .large()] for a half *and* full screen sheet
                presentationController.prefersGrabberVisible = true
                presentationController.preferredCornerRadius = 45
       
 
                presentationController.largestUndimmedDetentIdentifier = .large
                //presentationController.prefersScrollingExpandsWhenScrolledToEdge = false
            }
            
            
            
            self.present(nav, animated: true)
        

     
    
    }
    
    
    
//MARK: - textfield protocols
    @objc func segmentControlCrashTypesegmentAction(_ segmentedControl: UISegmentedControl) {
         switch (segmentedControl.selectedSegmentIndex) {
         case 0:
          
             //item_value_reportDataArray = []
             
             perform(#selector(addCrashTypeBtn), with: item_value_reportDataArray = [], afterDelay: 0.5)
             
             SubheaderContent.text = "In the last 5 years, what were the common crash types experienced at this location?"
             
             DetailsView.text = "\(item_value_reportDataArray)"
             
             crashTypeSelected.isHidden = false
             
             crashTypeSelected.reloadData()
             
             break // Uno
         case 1:

             //self.navigationController?.popViewController(animated: true)
             dismiss(animated: true)
             
             SubheaderContent.text = "In the last 5 years, there has been no or unknown crashes recorded at this location."
             
             item_value_reportDataArray = ["no"]

             DetailsView.text = "\(item_value_reportDataArray)"
             
             crashTypeSelected.isHidden = false

             crashTypeSelected.reloadData()
             
             break
         
         default:
             break
         }
     }
    
    
    
    @objc func segmentAction(_ segmentedControl: UISegmentedControl) {
         switch (segmentedControl.selectedSegmentIndex) {
         case 0:
             DetailsView.text = "Yes"

         case 1:
             DetailsView.text = "No"

             break // Dos
         case 2:
             DetailsView.text = "Unknown"

             break
         default:
             break
         }
     }
    
    
    @objc func segmentActionWeather(_ segmentedControl: UISegmentedControl) {
         switch (segmentedControl.selectedSegmentIndex) {
         case 0:
             DetailsView.text = "Rain"
         case 1:
             DetailsView.text = "Good"
             break // Dos
         case 2:
             DetailsView.text = "Cloudy"
             break // Dos
         case 3:
             DetailsView.text = "Dark"
             break
         default:
             break
         }
     }
   
    
    @objc func handleDatePicker(sender: UIDatePicker) {
        //        Wednesday, Sep 12, 2018           --> EEEE, MMM d, yyyy
        //        09/12/2018                        --> MM/dd/yyyy
        //        09-12-2018 14:11                  --> MM-dd-yyyy HH:mm
        //        Sep 12, 2:11 PM                   --> MMM d, h:mm a
        //        September 2018                    --> MMMM yyyy
        //        Sep 12, 2018                      --> MMM d, yyyy
        //        Wed, 12 Sep 2018 14:11:54 +0000   --> E, d MMM yyyy HH:mm:ss Z
        //        2018-09-12T14:11:54+0000          --> yyyy-MM-dd'T'HH:mm:ssZ
        //        12.09.18                          --> dd.MM.yy
        //        10:41:02.112                      --> HH:mm:ss.SSS
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        let todaysDate = dateFormatter.string(from: datePicker.date)
        DetailsView.text = todaysDate
        

    }
    

    
    @objc func doneSaveBtn(){
        //crash data
        DetailsView.resignFirstResponder()
 
        
        //save contents in the textfield specfic to the question
        let uid = Auth.auth().currentUser?.uid
        let reportConfigRefString = "\(self.mainConsole.prod!)/\(self.mainConsole.post!)/\(uid!)/\(self.mainConsole.audit!)/\(auditID)/\(self.mainConsole.siteList!)/\(siteID)/\(self.mainConsole.reportContent!)"
        
        
        //save the data
        saveData(question: questionIndex_value, ref: reportConfigRefString, textData: DetailsView.text ?? "")
        
    }
    



}
