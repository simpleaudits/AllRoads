//
//  addSiteDetails.swift
//  RSAC
//
//  Created by John on 24/1/2024.
//

import UIKit
import ActionSheetPicker_3_0

protocol saveDescription{
    func saveDescription(text:String)
}


class addSiteDetails: UIViewController,UITextViewDelegate,UITextFieldDelegate {
    
    var delegate: saveDescription?

    var scrollView = UIScrollView()
    var stringData = String()
    
    var maxScroll = 1000.00
    
    
    //section 1
    var descriptionTextfield = UITextView()
    
    //section 2
    var safetyRating = UILabel()
    var safetyRatingTextfield = UITextField()
    var safetyRatingButton = UIButton()
    var saveChanges = UIButton()
    
    //section 3
    var riskFactorHeader = UILabel()
    var riskFactorHeaderTextfield = UITextField()
    var riskFactorButton = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

       
        
        let topBarHeight = UIApplication.shared.statusBarFrame.size.height +
                                  (self.navigationController?.navigationBar.frame.height ?? 0.0)
        
        //----------------------
      
        
        descriptionTextfield = UITextView(frame: CGRect(x: 10, y: 20, width: Int(view.frame.width) - 20, height: 200 ))
        descriptionTextfield.font = UIFont.systemFont(ofSize: 12)
        descriptionTextfield.delegate = self
        descriptionTextfield.layer.borderWidth = 2
        descriptionTextfield.layer.cornerRadius = 20
        descriptionTextfield.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        descriptionTextfield.layer.masksToBounds = true
        descriptionTextfield.text = stringData
        
        //200
        
        descriptionTextfield.layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        descriptionTextfield.layer.masksToBounds = false
        descriptionTextfield.layer.shadowOffset = CGSize(width: 0, height: 4.0)
        descriptionTextfield.layer.shadowRadius = 8.0
        descriptionTextfield.layer.shadowOpacity = 0.4
        
        //----------------------
        
        safetyRating = UILabel(frame:CGRect(x: 20, y: descriptionTextfield.frame.maxY + 30, width: descriptionTextfield.frame.width - 20, height: 30))
        //safetyRating.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        safetyRating.text = "Safety Rating:"
        safetyRating.font = UIFont.boldSystemFont(ofSize: 20)
            
        safetyRatingTextfield = UITextField(frame:CGRect(x: 20, y: safetyRating.frame.maxY + 10, width: 100, height: 30))
        safetyRatingTextfield.placeholder = "Low Risk"
        safetyRatingTextfield.isUserInteractionEnabled = false
        safetyRatingTextfield.font = UIFont.boldSystemFont(ofSize: 15)
        safetyRatingTextfield.layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        safetyRatingTextfield.layer.cornerRadius = 10
        safetyRatingTextfield.textAlignment = .center
        safetyRatingTextfield.layer.masksToBounds = false
        safetyRatingTextfield.layer.shadowOffset = CGSize(width: 0, height: 4.0)
        safetyRatingTextfield.layer.shadowRadius = 8.0
        safetyRatingTextfield.layer.shadowOpacity = 0.4
        
        
        
//
//        //270
//
        //Buttons:
        safetyRatingButton = UIButton(frame: CGRect(x: descriptionTextfield.frame.maxX - 20 - 60, y: safetyRating.frame.maxY + 10, width: 60, height: 30))
        safetyRatingButton.setTitleColor(UIColor.white, for: .normal)
        safetyRatingButton.setTitle("Add", for: .normal)
//
//        //editImage.setImage(UIImage(systemName: "pencil"), for: .normal)
        safetyRatingButton.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        safetyRatingButton.layer.cornerRadius = 15
        safetyRatingButton.layer.masksToBounds = true
        safetyRatingButton.addTarget(self, action: #selector(selectRating(_:)), for: .touchUpInside)
//
        
        
        saveChanges = UIButton(frame: CGRect(x: 10, y: safetyRatingButton.frame.maxY + 60, width: view.frame.width - 20, height: 40))
        saveChanges.setTitleColor(UIColor.white, for: .normal)
        saveChanges.setTitle("Save", for: .normal)
        //saveChanges.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        //editImage.setImage(UIImage(systemName: "pencil"), for: .normal)
        saveChanges.backgroundColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
        saveChanges.layer.cornerRadius = 20
        saveChanges.layer.masksToBounds = true
        saveChanges.addTarget(self, action: #selector(saveData(_:)), for: .touchUpInside)
//
        
        //----------------------
//
//        riskFactorHeader = UILabel(frame:CGRect(x: 20, y: safetyRatingButton.frame.maxY + 30, width: safetyRatingButton.frame.width - 20, height: 30))
//        //safetyRating.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
//        riskFactorHeader.text = "Risk Level:"
//        riskFactorHeader.font = UIFont.boldSystemFont(ofSize: 20)
//
//
//        riskFactorHeaderTextfield = UITextField(frame:CGRect(x: 20, y: riskFactorHeader.frame.maxY + 10, width: descriptionTextfield.frame.width - 20, height: 30))
//        //safetyRatingTextfield.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
//        riskFactorHeaderTextfield.placeholder = "John Bean"
//        riskFactorHeaderTextfield.font = UIFont.systemFont(ofSize: 15)
//
//        //300
//
//        //Buttons:
//        riskFactorButton = UIButton(frame:CGRect(x: descriptionTextfield.frame.maxX - 20 - 60, y: riskFactorHeader.frame.maxY + 10, width: 60, height: 30))
//        riskFactorButton.setTitleColor(UIColor.white, for: .normal)
//        riskFactorButton.setTitle("Add", for: .normal)
//
//        //editImage.setImage(UIImage(systemName: "pencil"), for: .normal)
//        riskFactorButton.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
//        riskFactorButton.layer.cornerRadius = 15
//        riskFactorButton.layer.masksToBounds = true
//        riskFactorButton.addTarget(self, action: #selector(editDescriptionButton(_:)), for: .touchUpInside)
//
//
        
     
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: topBarHeight, width: view.frame.width, height: view.frame.height ))
        scrollView.contentSize.height = maxScroll

        
        view.addSubview(scrollView)
        scrollView.addSubview(descriptionTextfield)
        scrollView.addSubview(safetyRating)
        scrollView.addSubview(safetyRatingButton)
        scrollView.addSubview(saveChanges)
        
        
        scrollView.addSubview(safetyRatingTextfield)

    }
    

    
    
    
    @objc func saveData(_ sender: UIButton) {
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            self.navigationController?.popViewController(animated: true)
            
            self.dismiss(animated: true, completion: nil)
            
         
        })
        
    }
    
    
    
    
    
    @objc func selectRating(_ sender: UIButton) {
        ActionSheetMultipleStringPicker.show(withTitle: "Select Rating:", rows:
                    [[
                   "No Risk","Low Risk", "Medium Risk", "High Risk"
                  ]]
                   , initialSelection: [0, 3], doneBlock: {
                       picker, indexes, values in

                       print("values = \(values!)")
                       print("indexes = \(indexes!)")
                       print("picker = \(picker!)")
            
            
                        switch "\(indexes!)" {
                        case "[0]":
                            
                            self.safetyRatingTextfield.text = "No Risk"
                            self.safetyRatingTextfield.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
   
                            
                            break
                        case "[1]":
                            
                            self.safetyRatingTextfield.text = "Low Risk"
                            self.safetyRatingTextfield.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
                            break
                        case "[2]":
                            
                            self.safetyRatingTextfield.text = "Medium Risk"
                            self.safetyRatingTextfield.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
                            
                            break
                            
                        case "[3]":
                            
                            self.safetyRatingTextfield.text = "High Risk"
                            self.safetyRatingTextfield.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                            
                            break
                            
                            
                            
                            
                        default:
            
                            
                            break
                        }

                      
            
            
    
                       return
               }, cancel: { ActionMultipleStringCancelBlock in return }, origin: sender)

        
        
        

    }
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool
    {
        if(text == "\n")
        {
            view.endEditing(true)
            
            self.delegate?.saveDescription(text: self.descriptionTextfield.text)
           

            
            return false
        }
        else
        {
            return true
        }
    }

}
