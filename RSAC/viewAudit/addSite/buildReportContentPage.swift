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

protocol reportContentField{
    func finishPassing_decription(saveDescription: String)
}


class buildReportContentPage: UIViewController,UITextFieldDelegate,UITextViewDelegate,auditStage{
    var activityIndicator = UIActivityIndicatorView()
    
    //Reference to site and audit ID
    var auditID = String()
    var siteID = String()
    //var userUID = String()
    
    let mainFunction = extens()
    let mainConsole = CONSOLE()
    
    
 
   
    var datePicker = UIDatePicker()
    var segmentControl = UISegmentedControl()
    
    
    

    var DetailsField: UITextField!
    var DetailsView: UITextView!
    var numberDetailsTextfield: UITextField!
    var headerContent: UILabel!
    var textCount: UILabel!
    
    var descriptionFromParent = String()
    var delegate: reportContentField?
    
    
    var questionIndex_key  = String()
    var questionIndex_value  = String()
    var item_value_reportData = String()

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        activityIndicator.frame =  CGRectMake(0.0, 0.0, 40.0,40.0)
        activityIndicator.center = self.view.center
        self.view.addSubview(activityIndicator)
        activityIndicator.bringSubviewToFront(self.view)
        activityIndicator.startAnimating()
       



    }

    
    override func viewDidAppear(_ animated: Bool) {
        
        activityIndicator.stopAnimating()
        
        
        switch questionIndex_key {
        case "Audit Team Contact Name":
            
            headerContent = UILabel(frame: CGRect(x: 10, y: 100 + 20, width: Int(view.frame.width) - 20, height:  20))
            headerContent.text = questionIndex_key.uppercased()
            headerContent.font = UIFont.systemFont(ofSize: 12)
            headerContent.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            view.addSubview(headerContent)
            
            DetailsField = UITextField(frame: CGRect(x: 10, y: Int(self.headerContent.frame.maxY) + 10, width: Int(view.frame.width) - 20, height: 50 ))
            DetailsField.font = UIFont.systemFont(ofSize: 12)
            DetailsField.delegate = self
            //DetailsField.layer.borderWidth = 2
            DetailsField.text = item_value_reportData
            DetailsField.layer.cornerRadius = 15
            DetailsField.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            DetailsField.layer.masksToBounds = true
            DetailsField.textAlignment = .center
            DetailsField.returnKeyType = .done
            DetailsField.becomeFirstResponder()
         
            self.view.addSubview(DetailsField)
            
            
            textCount = UILabel(frame: CGRect(x: 10, y: Int(DetailsField.frame.maxY), width: Int(view.frame.width) - 20, height: 20 ))
            textCount.font = UIFont.systemFont(ofSize: 12)
            textCount.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            textCount.textAlignment = .right
            textCount.text = "count:\(item_value_reportData.count)"
            self.view.addSubview(textCount)
            
        case "Audit Team Organisation":
            
            headerContent = UILabel(frame: CGRect(x: 10, y: 100 + 20, width: Int(view.frame.width) - 20, height:  20))
            headerContent.text = questionIndex_key.uppercased()
            headerContent.font = UIFont.systemFont(ofSize: 12)
            headerContent.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            view.addSubview(headerContent)
            
            DetailsField = UITextField(frame: CGRect(x: 10, y: Int(self.headerContent.frame.maxY) + 10, width: Int(view.frame.width) - 20, height: 50 ))
            DetailsField.font = UIFont.systemFont(ofSize: 12)
            DetailsField.delegate = self
            //DetailsField.layer.borderWidth = 2
            DetailsField.text = item_value_reportData
            DetailsField.layer.cornerRadius = 15
            DetailsField.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            DetailsField.layer.masksToBounds = true
            DetailsField.textAlignment = .center
            DetailsField.returnKeyType = .done
            DetailsField.becomeFirstResponder()

            self.view.addSubview(DetailsField)
            
            
            textCount = UILabel(frame: CGRect(x: 10, y: Int(DetailsField.frame.maxY), width: Int(view.frame.width) - 20, height: 20 ))
            textCount.font = UIFont.systemFont(ofSize: 12)
            textCount.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            textCount.textAlignment = .right
            textCount.text = "count:\(item_value_reportData.count)"
            self.view.addSubview(textCount)
            
        case "Audit Team Organisation Contact Details":
            
            headerContent = UILabel(frame: CGRect(x: 10, y: 100 + 20, width: Int(view.frame.width) - 20, height:  20))
            headerContent.text = questionIndex_key.uppercased()
            headerContent.font = UIFont.systemFont(ofSize: 12)
            headerContent.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            view.addSubview(headerContent)
            
            DetailsField = UITextField(frame: CGRect(x: 10, y: Int(self.headerContent.frame.maxY) + 10, width: Int(view.frame.width) - 20, height: 50 ))
            DetailsField.font = UIFont.systemFont(ofSize: 12)
            DetailsField.delegate = self
            //DetailsField.layer.borderWidth = 2
            DetailsField.text = item_value_reportData
            DetailsField.layer.cornerRadius = 15
            DetailsField.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            DetailsField.layer.masksToBounds = true
            DetailsField.textAlignment = .center
            DetailsField.returnKeyType = .done
            DetailsField.becomeFirstResponder()

            self.view.addSubview(DetailsField)
            
            textCount = UILabel(frame: CGRect(x: 10, y: Int(DetailsField.frame.maxY), width: Int(view.frame.width) - 20, height: 20 ))
            textCount.font = UIFont.systemFont(ofSize: 12)
            textCount.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            textCount.textAlignment = .right
            textCount.text = "count:\(item_value_reportData.count)"
            self.view.addSubview(textCount)
            
            
        case "Your company name":
            
            headerContent = UILabel(frame: CGRect(x: 10, y: 100 + 20, width: Int(view.frame.width) - 20, height:  20))
            headerContent.text = questionIndex_key.uppercased()
            headerContent.font = UIFont.systemFont(ofSize: 12)
            headerContent.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            view.addSubview(headerContent)
            
            DetailsField = UITextField(frame: CGRect(x: 10, y: Int(self.headerContent.frame.maxY) + 10, width: Int(view.frame.width) - 20, height: 50 ))
            DetailsField.font = UIFont.systemFont(ofSize: 12)
            DetailsField.delegate = self
            //DetailsField.layer.borderWidth = 2
            DetailsField.text = item_value_reportData
            DetailsField.layer.cornerRadius = 15
            DetailsField.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            DetailsField.layer.masksToBounds = true
            DetailsField.textAlignment = .center
            DetailsField.returnKeyType = .done
            DetailsField.becomeFirstResponder()

            self.view.addSubview(DetailsField)
            
            textCount = UILabel(frame: CGRect(x: 10, y: Int(DetailsField.frame.maxY), width: Int(view.frame.width) - 20, height: 20 ))
            textCount.font = UIFont.systemFont(ofSize: 12)
            textCount.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            textCount.textAlignment = .right
            textCount.text = "count:\(item_value_reportData.count)"
            self.view.addSubview(textCount)
            
            
        case "Road Safety Audit Stage":
            
            //Open List
    
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit Stage", style: .plain, target: self, action: #selector(addStage))
            
            headerContent = UILabel(frame: CGRect(x: 10, y: 100 + 20, width: Int(view.frame.width) - 20, height:  20))
            headerContent.text = questionIndex_key.uppercased()
            headerContent.font = UIFont.systemFont(ofSize: 12)
            headerContent.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            view.addSubview(headerContent)
            
            DetailsField = UITextField(frame: CGRect(x: 10, y: Int(self.headerContent.frame.maxY) + 10, width: Int(view.frame.width) - 20, height: 50 ))
            DetailsField.font = UIFont.systemFont(ofSize: 12)
            DetailsField.delegate = self
            //DetailsField.layer.borderWidth = 2
            DetailsField.text = item_value_reportData
            DetailsField.isEnabled = false
            DetailsField.layer.cornerRadius = 15
            DetailsField.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            DetailsField.layer.masksToBounds = true
            DetailsField.textAlignment = .center
            DetailsField.returnKeyType = .done
    
            self.view.addSubview(DetailsField)
            
            textCount = UILabel(frame: CGRect(x: 10, y: Int(DetailsField.frame.maxY), width: Int(view.frame.width) - 20, height: 20 ))
            textCount.font = UIFont.systemFont(ofSize: 12)
            textCount.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            textCount.textAlignment = .right
            textCount.text = "count:\(item_value_reportData.count)"
            self.view.addSubview(textCount)

            
        case "Project Location":
            
            headerContent = UILabel(frame: CGRect(x: 10, y: 100 + 20, width: Int(view.frame.width) - 20, height:  20))
            headerContent.text = questionIndex_key.uppercased()
            headerContent.font = UIFont.systemFont(ofSize: 12)
            headerContent.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            view.addSubview(headerContent)
            
            DetailsField = UITextField(frame: CGRect(x: 10, y: Int(self.headerContent.frame.maxY) + 10, width: Int(view.frame.width) - 20, height: 50 ))
            DetailsField.font = UIFont.systemFont(ofSize: 12)
            DetailsField.delegate = self
            //DetailsField.layer.borderWidth = 2
            DetailsField.text = item_value_reportData
            DetailsField.layer.cornerRadius = 15
            DetailsField.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            DetailsField.layer.masksToBounds = true
            DetailsField.textAlignment = .center
            DetailsField.returnKeyType = .done
            DetailsField.becomeFirstResponder()
    
            self.view.addSubview(DetailsField)
          
            
        case "Project Description":
            
            headerContent = UILabel(frame: CGRect(x: 10, y: 100 + 20, width: Int(view.frame.width) - 20, height:  20))
            headerContent.text = questionIndex_key.uppercased()
            headerContent.font = UIFont.systemFont(ofSize: 12)
            headerContent.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            view.addSubview(headerContent)
            
            DetailsView = UITextView(frame: CGRect(x: 10, y: Int(self.headerContent.frame.maxY) + 10, width: Int(view.frame.width) - 20, height: 200 ))
            DetailsView.font = UIFont.systemFont(ofSize: 12)
            DetailsView.delegate = self
            //DetailsField.layer.borderWidth = 2
            DetailsView.text = item_value_reportData
            DetailsView.layer.cornerRadius = 15
            DetailsView.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
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
        
        case "Project Number / Task Number":
            

            
            headerContent = UILabel(frame: CGRect(x: 10, y: 100 + 20, width: Int(view.frame.width) - 20, height:  20))
            headerContent.text = questionIndex_key.uppercased()
            headerContent.font = UIFont.systemFont(ofSize: 12)
            headerContent.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            view.addSubview(headerContent)
            
            numberDetailsTextfield = UITextField(frame: CGRect(x: 10, y: Int(self.headerContent.frame.maxY) + 10, width: Int(view.frame.width) - 20, height: 50 ))
            numberDetailsTextfield.font = UIFont.systemFont(ofSize: 12)
            numberDetailsTextfield.delegate = self
            //DetailsField.layer.borderWidth = 2
            numberDetailsTextfield.text = item_value_reportData
            numberDetailsTextfield.layer.cornerRadius = 15
            numberDetailsTextfield.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            numberDetailsTextfield.layer.masksToBounds = true
            numberDetailsTextfield.textAlignment = .center
            numberDetailsTextfield.returnKeyType = .done
            numberDetailsTextfield.keyboardType = .phonePad
          
            numberDetailsTextfield.becomeFirstResponder()
            
            let bar = UIToolbar()
            let reset = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonTappedForMyNumericTextField))
            bar.items = [reset]
            bar.sizeToFit()
            numberDetailsTextfield.inputAccessoryView = bar
            
            self.view.addSubview(numberDetailsTextfield)
            

        
        case "Organisation / Department":
            
            headerContent = UILabel(frame: CGRect(x: 10, y: 100 + 20, width: Int(view.frame.width) - 20, height:  20))
            headerContent.text = questionIndex_key.uppercased()
            headerContent.font = UIFont.systemFont(ofSize: 12)
            headerContent.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            view.addSubview(headerContent)
            
            DetailsField = UITextField(frame: CGRect(x: 10, y: Int(self.headerContent.frame.maxY) + 10, width: Int(view.frame.width) - 20, height: 50 ))
            DetailsField.font = UIFont.systemFont(ofSize: 12)
            DetailsField.delegate = self
            //DetailsField.layer.borderWidth = 2
            DetailsField.text = item_value_reportData
            DetailsField.layer.cornerRadius = 15
            DetailsField.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            DetailsField.layer.masksToBounds = true
            DetailsField.textAlignment = .center
            DetailsField.returnKeyType = .done
            DetailsField.becomeFirstResponder()
     
            self.view.addSubview(DetailsField)
        
        case "Contact Name":
            
            headerContent = UILabel(frame: CGRect(x: 10, y: 100 + 20, width: Int(view.frame.width) - 20, height:  20))
            headerContent.text = questionIndex_key.uppercased()
            headerContent.font = UIFont.systemFont(ofSize: 12)
            headerContent.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            view.addSubview(headerContent)
            
            DetailsField = UITextField(frame: CGRect(x: 10, y: Int(self.headerContent.frame.maxY) + 10, width: Int(view.frame.width) - 20, height: 50 ))
            DetailsField.font = UIFont.systemFont(ofSize: 12)
            DetailsField.delegate = self
            //DetailsField.layer.borderWidth = 2
            DetailsField.text = item_value_reportData
            DetailsField.layer.cornerRadius = 15
            DetailsField.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            DetailsField.layer.masksToBounds = true
            DetailsField.textAlignment = .center
            DetailsField.returnKeyType = .done
            DetailsField.becomeFirstResponder()
     
            self.view.addSubview(DetailsField)
      
            
        case "Contact Tel. No.":
            
            headerContent = UILabel(frame: CGRect(x: 10, y: 100 + 20, width: Int(view.frame.width) - 20, height:  20))
            headerContent.text = questionIndex_key.uppercased()
            headerContent.font = UIFont.systemFont(ofSize: 12)
            headerContent.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            view.addSubview(headerContent)
            
            numberDetailsTextfield = UITextField(frame: CGRect(x: 10, y: Int(self.headerContent.frame.maxY) + 10, width: Int(view.frame.width) - 20, height: 50 ))
            numberDetailsTextfield.font = UIFont.systemFont(ofSize: 12)
            numberDetailsTextfield.delegate = self
            //DetailsField.layer.borderWidth = 2
            numberDetailsTextfield.text = item_value_reportData
            numberDetailsTextfield.layer.cornerRadius = 15
            numberDetailsTextfield.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            numberDetailsTextfield.layer.masksToBounds = true
            numberDetailsTextfield.textAlignment = .center
            numberDetailsTextfield.returnKeyType = .done
            numberDetailsTextfield.keyboardType = .phonePad
         
            numberDetailsTextfield.becomeFirstResponder()
            
            let bar = UIToolbar()
            let reset = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonTappedForMyNumericTextField))
            bar.items = [reset]
            bar.sizeToFit()
            numberDetailsTextfield.inputAccessoryView = bar
            
            self.view.addSubview(numberDetailsTextfield)
            
  
            
            
        case "Email Address":
            
            headerContent = UILabel(frame: CGRect(x: 10, y: 100 + 20, width: Int(view.frame.width) - 20, height:  20))
            headerContent.text = questionIndex_key.uppercased()
            headerContent.font = UIFont.systemFont(ofSize: 12)
            headerContent.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            view.addSubview(headerContent)
            
            DetailsField = UITextField(frame: CGRect(x: 10, y: Int(self.headerContent.frame.maxY) + 10, width: Int(view.frame.width) - 20, height: 50 ))
            DetailsField.font = UIFont.systemFont(ofSize: 12)
            DetailsField.delegate = self
            //DetailsField.layer.borderWidth = 2
            DetailsField.text = item_value_reportData
            DetailsField.layer.cornerRadius = 15
            DetailsField.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            DetailsField.layer.masksToBounds = true
            DetailsField.textAlignment = .center
            DetailsField.keyboardType = .emailAddress
            DetailsField.returnKeyType = .done
            DetailsField.becomeFirstResponder()
    
            self.view.addSubview(DetailsField)
            
        case "Date the Final Audit is Required":
            
            headerContent = UILabel(frame: CGRect(x: 10, y: 100 + 20, width: Int(view.frame.width) - 20, height:  20))
            headerContent.text = questionIndex_key.uppercased()
            headerContent.font = UIFont.systemFont(ofSize: 12)
            headerContent.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            view.addSubview(headerContent)
            
            DetailsField = UITextField(frame: CGRect(x: 10, y: Int(self.headerContent.frame.maxY) + 10, width: Int(view.frame.width) - 20, height: 50 ))
            DetailsField.font = UIFont.systemFont(ofSize: 12)
            DetailsField.delegate = self
            //DetailsField.layer.borderWidth = 2
            DetailsField.text = "  \(item_value_reportData)"
            DetailsField.layer.cornerRadius = 15
            DetailsField.layer.backgroundColor = .none
            DetailsField.layer.masksToBounds = true
            DetailsField.textAlignment = .right
   
            self.view.addSubview(DetailsField)
      
      
            // DatePicker
            datePicker.center = CGPoint(x: Int(headerContent.frame.minX) + 20, y: Int(self.headerContent.frame.maxY) + 35)
   
            //Formate Date
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
            let date = dateFormatter.date(from: item_value_reportData)
            
            datePicker.setDate(date!, animated: true)
            datePicker.datePickerMode = .date
            datePicker.layer.masksToBounds = true
            datePicker.addTarget(self, action: #selector(handleDatePicker(sender:)), for: UIControl.Event.valueChanged)
            self.view.addSubview(datePicker)


        case "Previous Road Safety Audit":
            
            headerContent = UILabel(frame: CGRect(x: 10, y: 100 + 20, width: Int(view.frame.width) - 20, height:  20))
            headerContent.text = questionIndex_key.uppercased()
            headerContent.font = UIFont.systemFont(ofSize: 12)
            headerContent.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            view.addSubview(headerContent)
            
            DetailsField = UITextField(frame: CGRect(x: 10, y: Int(self.headerContent.frame.maxY) + 10, width: Int(view.frame.width) - 20, height: 50 ))
            DetailsField.font = UIFont.systemFont(ofSize: 12)
            DetailsField.delegate = self
            //DetailsField.layer.borderWidth = 2
            DetailsField.text = item_value_reportData
            DetailsField.layer.cornerRadius = 15
            DetailsField.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            DetailsField.layer.masksToBounds = true
            DetailsField.textAlignment = .center
            DetailsField.returnKeyType = .done
            DetailsField.becomeFirstResponder()
 
            self.view.addSubview(DetailsField)
            
        case "Previous Road Safety Audit Stage":
            
            //Open List
    
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit Stage", style: .plain, target: self, action: #selector(addStage))
            
            headerContent = UILabel(frame: CGRect(x: 10, y: 100 + 20, width: Int(view.frame.width) - 20, height:  20))
            headerContent.text = questionIndex_key.uppercased()
            headerContent.font = UIFont.systemFont(ofSize: 12)
            headerContent.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            view.addSubview(headerContent)
            
            DetailsField = UITextField(frame: CGRect(x: 10, y: Int(self.headerContent.frame.maxY) + 10, width: Int(view.frame.width) - 20, height: 50 ))
            DetailsField.font = UIFont.systemFont(ofSize: 12)
            DetailsField.delegate = self
            //DetailsField.layer.borderWidth = 2
            DetailsField.text = item_value_reportData
            DetailsField.isEnabled = false
            DetailsField.layer.cornerRadius = 15
            DetailsField.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            DetailsField.layer.masksToBounds = true
            DetailsField.textAlignment = .center
            DetailsField.returnKeyType = .done
            self.view.addSubview(DetailsField)
            
            textCount = UILabel(frame: CGRect(x: 10, y: Int(DetailsField.frame.maxY), width: Int(view.frame.width) - 20, height: 20 ))
            textCount.font = UIFont.systemFont(ofSize: 12)
            textCount.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            textCount.textAlignment = .right
            textCount.text = "count:\(item_value_reportData.count)"
            self.view.addSubview(textCount)
       
        
        case "Previous Audit Date":
            
            headerContent = UILabel(frame: CGRect(x: 10, y: 100 + 20, width: Int(view.frame.width) - 20, height:  20))
            headerContent.text = questionIndex_key.uppercased()
            headerContent.font = UIFont.systemFont(ofSize: 12)
            headerContent.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            view.addSubview(headerContent)
            
            DetailsField = UITextField(frame: CGRect(x: 10, y: Int(self.headerContent.frame.maxY) + 10, width: Int(view.frame.width) - 20, height: 50 ))
            DetailsField.font = UIFont.systemFont(ofSize: 12)
            DetailsField.delegate = self
            //DetailsField.layer.borderWidth = 2
            DetailsField.text = "  \(item_value_reportData)"
            DetailsField.layer.cornerRadius = 15
            DetailsField.layer.backgroundColor = .none
            DetailsField.layer.masksToBounds = true
            DetailsField.textAlignment = .right
            DetailsField.isEnabled = false
            self.view.addSubview(DetailsField)
      
      
            // DatePicker
            datePicker.center = CGPoint(x: Int(headerContent.frame.minX) + 20, y: Int(self.headerContent.frame.maxY) + 35)
   
            //Formate Date
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
            let date = dateFormatter.date(from: item_value_reportData)
            
            datePicker.setDate(date!, animated: true)
            datePicker.datePickerMode = .date
            datePicker.layer.masksToBounds = true
            datePicker.addTarget(self, action: #selector(handleDatePicker(sender:)), for: UIControl.Event.valueChanged)
            self.view.addSubview(datePicker)

        case "Previous Audit Organisation":
            
            headerContent = UILabel(frame: CGRect(x: 10, y: 100 + 20, width: Int(view.frame.width) - 20, height:  20))
            headerContent.text = questionIndex_key.uppercased()
            headerContent.font = UIFont.systemFont(ofSize: 12)
            headerContent.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            view.addSubview(headerContent)
            
            DetailsField = UITextField(frame: CGRect(x: 10, y: Int(self.headerContent.frame.maxY) + 10, width: Int(view.frame.width) - 20, height: 50 ))
            DetailsField.font = UIFont.systemFont(ofSize: 12)
            DetailsField.delegate = self
            //DetailsField.layer.borderWidth = 2
            DetailsField.text = item_value_reportData
            DetailsField.layer.cornerRadius = 15
            DetailsField.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            DetailsField.layer.masksToBounds = true
            DetailsField.textAlignment = .center
            DetailsField.returnKeyType = .done
            DetailsField.becomeFirstResponder()
     
            self.view.addSubview(DetailsField)
         
        case "Previous Audit Team Leader":
            
            headerContent = UILabel(frame: CGRect(x: 10, y: 100 + 20, width: Int(view.frame.width) - 20, height:  20))
            headerContent.text = questionIndex_key.uppercased()
            headerContent.font = UIFont.systemFont(ofSize: 12)
            headerContent.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            view.addSubview(headerContent)
            
            DetailsField = UITextField(frame: CGRect(x: 10, y: Int(self.headerContent.frame.maxY) + 10, width: Int(view.frame.width) - 20, height: 50 ))
            DetailsField.font = UIFont.systemFont(ofSize: 12)
            DetailsField.delegate = self
            //DetailsField.layer.borderWidth = 2
            DetailsField.text = item_value_reportData
            DetailsField.layer.cornerRadius = 15
            DetailsField.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            DetailsField.layer.masksToBounds = true
            DetailsField.textAlignment = .center
            DetailsField.returnKeyType = .done
            DetailsField.becomeFirstResponder()
            DetailsField.isEnabled = false
            self.view.addSubview(DetailsField)
            
            
        case "Copy of Audit and CAR Provided":
            
            headerContent = UILabel(frame: CGRect(x: 10, y: 100 + 20, width: Int(view.frame.width) - 20, height:  20))
            headerContent.text = questionIndex_key.uppercased()
            headerContent.font = UIFont.systemFont(ofSize: 12)
            headerContent.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            view.addSubview(headerContent)
            
            DetailsField = UITextField(frame: CGRect(x: 10, y: Int(self.headerContent.frame.maxY) + 10, width: Int(view.frame.width) - 20, height: 50 ))
            DetailsField.font = UIFont.systemFont(ofSize: 12)
            DetailsField.delegate = self
            //DetailsField.layer.borderWidth = 2
            DetailsField.text = item_value_reportData
            DetailsField.layer.cornerRadius = 15
            DetailsField.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            DetailsField.layer.masksToBounds = true
            DetailsField.textAlignment = .center
            DetailsField.returnKeyType = .done
            DetailsField.becomeFirstResponder()
            DetailsField.isEnabled = false
            self.view.addSubview(DetailsField)
            
            
        case "Safe System Assessments":
            
            headerContent = UILabel(frame: CGRect(x: 10, y: 100 + 20, width: Int(view.frame.width) - 20, height:  20))
            headerContent.text = questionIndex_key.uppercased()
            headerContent.font = UIFont.systemFont(ofSize: 12)
            headerContent.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            view.addSubview(headerContent)
            
            DetailsField = UITextField(frame: CGRect(x: 10, y: Int(self.headerContent.frame.maxY) + 10, width: Int(view.frame.width) - 20, height: 50 ))
            DetailsField.font = UIFont.systemFont(ofSize: 12)
            DetailsField.delegate = self
            //DetailsField.layer.borderWidth = 2
            DetailsField.text = item_value_reportData
            DetailsField.layer.cornerRadius = 15
            DetailsField.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            DetailsField.layer.masksToBounds = true
            DetailsField.textAlignment = .center
            DetailsField.returnKeyType = .done
            DetailsField.becomeFirstResponder()
            DetailsField.isEnabled = false
            self.view.addSubview(DetailsField)
            
        case "Assessment Date":
            
            headerContent = UILabel(frame: CGRect(x: 10, y: 100 + 20, width: Int(view.frame.width) - 20, height:  20))
            headerContent.text = questionIndex_key.uppercased()
            headerContent.font = UIFont.systemFont(ofSize: 12)
            headerContent.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            view.addSubview(headerContent)
            
            DetailsField = UITextField(frame: CGRect(x: 10, y: Int(self.headerContent.frame.maxY) + 10, width: Int(view.frame.width) - 20, height: 50 ))
            DetailsField.font = UIFont.systemFont(ofSize: 12)
            DetailsField.delegate = self
            //DetailsField.layer.borderWidth = 2
            DetailsField.text = "  \(item_value_reportData)"
            DetailsField.layer.cornerRadius = 15
            DetailsField.layer.backgroundColor = .none
            DetailsField.layer.masksToBounds = true
            DetailsField.textAlignment = .right
            DetailsField.isEnabled = false
            self.view.addSubview(DetailsField)
      
      
            // DatePicker
            datePicker.center = CGPoint(x: Int(headerContent.frame.minX) + 20, y: Int(self.headerContent.frame.maxY) + 35)
   
            //Formate Date
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
            let date = dateFormatter.date(from: item_value_reportData)
            
            datePicker.setDate(date!, animated: true)
            datePicker.datePickerMode = .date
            datePicker.layer.masksToBounds = true
            datePicker.addTarget(self, action: #selector(handleDatePicker(sender:)), for: UIControl.Event.valueChanged)
            self.view.addSubview(datePicker)
            
        case "Assessment Organisation":
            
            headerContent = UILabel(frame: CGRect(x: 10, y: 100 + 20, width: Int(view.frame.width) - 20, height:  20))
            headerContent.text = questionIndex_key.uppercased()
            headerContent.font = UIFont.systemFont(ofSize: 12)
            headerContent.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            view.addSubview(headerContent)
            
            DetailsField = UITextField(frame: CGRect(x: 10, y: Int(self.headerContent.frame.maxY) + 10, width: Int(view.frame.width) - 20, height: 50 ))
            DetailsField.font = UIFont.systemFont(ofSize: 12)
            DetailsField.delegate = self
            //DetailsField.layer.borderWidth = 2
            DetailsField.text = item_value_reportData
            DetailsField.layer.cornerRadius = 15
            DetailsField.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            DetailsField.layer.masksToBounds = true
            DetailsField.textAlignment = .center
            DetailsField.returnKeyType = .done
            DetailsField.becomeFirstResponder()
            DetailsField.isEnabled = false
            self.view.addSubview(DetailsField)
            
            
        case "Copy of Assessment Provided":
            
            headerContent = UILabel(frame: CGRect(x: 10, y: 100 + 20, width: Int(view.frame.width) - 20, height:  20))
            headerContent.text = questionIndex_key.uppercased()
            headerContent.font = UIFont.systemFont(ofSize: 12)
            headerContent.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            view.addSubview(headerContent)
            
            DetailsField = UITextField(frame: CGRect(x: 10, y: Int(self.headerContent.frame.maxY) + 10, width: Int(view.frame.width) - 20, height: 50 ))
            DetailsField.font = UIFont.systemFont(ofSize: 12)
            DetailsField.delegate = self
            //DetailsField.layer.borderWidth = 2
            DetailsField.text = item_value_reportData
            DetailsField.layer.cornerRadius = 15
            DetailsField.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            DetailsField.layer.masksToBounds = true
            DetailsField.textAlignment = .center
            DetailsField.returnKeyType = .done
            DetailsField.isEnabled = false
            DetailsField.becomeFirstResponder()
            self.view.addSubview(DetailsField)
            
            let items = ["Yes", "No", "Unknown"]
            segmentControl = UISegmentedControl(items: items)
            segmentControl.frame = CGRect(x: 10, y: Int(DetailsField.frame.maxY) + 10, width: Int(view.frame.width) - 20, height: 30)
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
      
        case "Project Objective":
            
            headerContent = UILabel(frame: CGRect(x: 10, y: 100 + 20, width: Int(view.frame.width) - 20, height:  20))
            headerContent.text = questionIndex_key.uppercased()
            headerContent.font = UIFont.systemFont(ofSize: 12)
            headerContent.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            view.addSubview(headerContent)
            
            DetailsField = UITextField(frame: CGRect(x: 10, y: Int(self.headerContent.frame.maxY) + 10, width: Int(view.frame.width) - 20, height: 50 ))
            DetailsField.font = UIFont.systemFont(ofSize: 12)
            DetailsField.delegate = self
            //DetailsField.layer.borderWidth = 2
            DetailsField.text = item_value_reportData
            DetailsField.layer.cornerRadius = 15
            DetailsField.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            DetailsField.layer.masksToBounds = true
            DetailsField.textAlignment = .center
            DetailsField.returnKeyType = .done
            DetailsField.becomeFirstResponder()
            self.view.addSubview(DetailsField)
            
            
        case "Speed Limit / Design Speed":
            
            headerContent = UILabel(frame: CGRect(x: 10, y: 100 + 20, width: Int(view.frame.width) - 20, height:  20))
            headerContent.text = questionIndex_key.uppercased()
            headerContent.font = UIFont.systemFont(ofSize: 12)
            headerContent.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            view.addSubview(headerContent)
            
            numberDetailsTextfield = UITextField(frame: CGRect(x: Int(view.frame.width)/2 - 50, y: Int(self.headerContent.frame.maxY) + 10, width: 100, height: 100 ))
            numberDetailsTextfield.font = UIFont.boldSystemFont(ofSize: 30)
            //numberDetailsTextfield.sizeToFit()
            numberDetailsTextfield.delegate = self
            numberDetailsTextfield.layer.borderWidth = 5
            numberDetailsTextfield.layer.borderColor = #colorLiteral(red: 1, green: 0.231372549, blue: 0.1882352941, alpha: 1)
            numberDetailsTextfield.text = item_value_reportData
            numberDetailsTextfield.layer.cornerRadius = 50
            numberDetailsTextfield.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            numberDetailsTextfield.layer.masksToBounds = true
            numberDetailsTextfield.textAlignment = .center
            numberDetailsTextfield.returnKeyType = .done
            numberDetailsTextfield.keyboardType = .phonePad
            numberDetailsTextfield.isEnabled = false
            numberDetailsTextfield.becomeFirstResponder()
            
            let bar = UIToolbar()
            let reset = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonTappedForMyNumericTextField))
            bar.items = [reset]
            bar.sizeToFit()
            numberDetailsTextfield.inputAccessoryView = bar
            
            self.view.addSubview(numberDetailsTextfield)
            
           
            
            
        default:
            
            break
           
       
        }
        
    }
    
    //MARK: - segue to select category page
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? CategoryTableViewController {
            
            destination.delegate = self
            
        }
    
        else {
            
        }
   
            
            
        }

// MARK: - category protocol
    
    func finishPassing_category(saveCategory: String) {
        //Display audit stage cell when the string is not empty.
        if (self.item_value_reportData != ""){
            print ("not empty")
            print (saveCategory)
            item_value_reportData = saveCategory
            
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

//MARK: - textfield protocols
    @objc func segmentAction(_ segmentedControl: UISegmentedControl) {
         switch (segmentedControl.selectedSegmentIndex) {
         case 0:
             DetailsField.text = "Yes"
             
             //save contents in the textfield specfic to the question
             let uid = Auth.auth().currentUser?.uid
             let reportConfigRefString = "\(self.mainConsole.prod!)/\(self.mainConsole.post!)/\(uid!)/\(self.mainConsole.audit!)/\(auditID)/\(self.mainConsole.siteList!)/\(siteID)/\(self.mainConsole.reportContent!)"
             
             
             //save the data
             saveData(question: questionIndex_value, ref: reportConfigRefString, textData: DetailsField.text ?? "")
             break // Uno
         case 1:
             DetailsField.text = "No"
             
             //save contents in the textfield specfic to the question
             let uid = Auth.auth().currentUser?.uid
             let reportConfigRefString = "\(self.mainConsole.prod!)/\(self.mainConsole.post!)/\(uid!)/\(self.mainConsole.audit!)/\(auditID)/\(self.mainConsole.siteList!)/\(siteID)/\(self.mainConsole.reportContent!)"
             
             
             //save the data
             saveData(question: questionIndex_value, ref: reportConfigRefString, textData: DetailsField.text ?? "")
             break // Dos
         case 2:
             DetailsField.text = "Unknown"
             
             
             //save contents in the textfield specfic to the question
             let uid = Auth.auth().currentUser?.uid
             let reportConfigRefString = "\(self.mainConsole.prod!)/\(self.mainConsole.post!)/\(uid!)/\(self.mainConsole.audit!)/\(auditID)/\(self.mainConsole.siteList!)/\(siteID)/\(self.mainConsole.reportContent!)"
             
             
             //save the data
             saveData(question: questionIndex_value, ref: reportConfigRefString, textData: DetailsField.text ?? "")
             break // Tres
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
        DetailsField.text = todaysDate
        
        //save contents in the textfield specfic to the question
        let uid = Auth.auth().currentUser?.uid
        let reportConfigRefString = "\(self.mainConsole.prod!)/\(self.mainConsole.post!)/\(uid!)/\(self.mainConsole.audit!)/\(auditID)/\(self.mainConsole.siteList!)/\(siteID)/\(self.mainConsole.reportContent!)"
        
        
        //save the data
        saveData(question: questionIndex_value, ref: reportConfigRefString, textData: DetailsField.text ?? "")
        
    }
    
    
    func textViewDidChange(_ textView: UITextField) {
        // This method is called whenever the text changes
        if let text = textView.text {
            let characterCount = text.count
           // print("Character count: \(characterCount)")
           
            textCount.text = "count:\(DetailsView.text?.count ?? 0)"
            
      

        }
    }
    

    func textViewDidChange(_ textView: UITextView) {
        // This method is called whenever the text changes
        if let text = textView.text {
            let characterCount = text.count
            textCount.text = "count:\(DetailsView.text?.count ?? 0)"
            

        }
    }
    
    
 
    @objc func doneButtonTappedForMyNumericTextField() {
        print("Done");
        numberDetailsTextfield.resignFirstResponder()
        

        
        //save contents in the textfield specfic to the question
        let uid = Auth.auth().currentUser?.uid
        let reportConfigRefString = "\(self.mainConsole.prod!)/\(self.mainConsole.post!)/\(uid!)/\(self.mainConsole.audit!)/\(auditID)/\(self.mainConsole.siteList!)/\(siteID)/\(self.mainConsole.reportContent!)"
        
        
        //save the data
        saveData(question: questionIndex_value, ref: reportConfigRefString, textData: numberDetailsTextfield.text ?? "")
        
    }

    
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        //Project Creator
        let uid = Auth.auth().currentUser?.uid
        let reportConfigRefString = "\(self.mainConsole.prod!)/\(self.mainConsole.post!)/\(uid!)/\(self.mainConsole.audit!)/\(auditID)/\(self.mainConsole.siteList!)/\(siteID)/\(self.mainConsole.reportContent!)"
        
        
        //save contents in the textfield specfic to the question
        saveData(question: questionIndex_value, ref: reportConfigRefString, textData: textField.text ?? "")

        return true
    }
    
    

    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool
    {
        if(text == "\n")
        {
            view.endEditing(true)
            
            
            //save contents in the textfield specfic to the question
            let uid = Auth.auth().currentUser?.uid
            let reportConfigRefString = "\(self.mainConsole.prod!)/\(self.mainConsole.post!)/\(uid!)/\(self.mainConsole.audit!)/\(auditID)/\(self.mainConsole.siteList!)/\(siteID)/\(self.mainConsole.reportContent!)"
            
            
            //save the data
            saveData(question: questionIndex_value, ref: reportConfigRefString, textData: DetailsView.text ?? "")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                self.navigationController?.popViewController(animated: true)
                
                //self.dismiss(animated: true, completion: nil)
             
            })
            
       
            
            return false
        }
        else
        {
            return true
        }
    }
    



}
