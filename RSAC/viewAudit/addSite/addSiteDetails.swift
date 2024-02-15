//
//  addSiteDetails.swift
//  RSAC
//
//  Created by John on 24/1/2024.
//

import UIKit


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
    var userAdded = UILabel()
    var userAddedTextfield = UITextField()
    var addUsersFromList = UIButton()
    
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
        descriptionTextfield.font = UIFont.systemFont(ofSize: 15)
        descriptionTextfield.delegate = self
        descriptionTextfield.layer.borderWidth = 2
        descriptionTextfield.layer.cornerRadius = 20
        descriptionTextfield.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        descriptionTextfield.text = stringData
        
        //200
        
        descriptionTextfield.layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        descriptionTextfield.layer.masksToBounds = false
        descriptionTextfield.layer.shadowOffset = CGSize(width: 0, height: 4.0)
        descriptionTextfield.layer.shadowRadius = 8.0
        descriptionTextfield.layer.shadowOpacity = 0.4
        
        //----------------------
        
        userAdded = UILabel(frame:CGRect(x: 20, y: descriptionTextfield.frame.maxY + 30, width: descriptionTextfield.frame.width - 20, height: 30))
        //userAdded.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        userAdded.text = "Assigned:"
        userAdded.font = UIFont.boldSystemFont(ofSize: 20)
        
        userAddedTextfield = UITextField(frame:CGRect(x: 20, y: userAdded.frame.maxY + 10, width: descriptionTextfield.frame.width - 20, height: 30))
        //userAddedTextfield.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        userAddedTextfield.placeholder = "John Bean"
        userAddedTextfield.font = UIFont.systemFont(ofSize: 15)
        
        //270

        //Buttons:
        addUsersFromList = UIButton(frame: CGRect(x: descriptionTextfield.frame.maxX - 20 - 60, y: userAdded.frame.maxY + 10, width: 60, height: 30))
        addUsersFromList.setTitleColor(UIColor.white, for: .normal)
        addUsersFromList.setTitle("Add", for: .normal)

        //editImage.setImage(UIImage(systemName: "pencil"), for: .normal)
        addUsersFromList.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        addUsersFromList.layer.cornerRadius = 15
        addUsersFromList.layer.masksToBounds = true
        addUsersFromList.addTarget(self, action: #selector(editDescriptionButton(_:)), for: .touchUpInside)
        
        
        //----------------------
        
        riskFactorHeader = UILabel(frame:CGRect(x: 20, y: addUsersFromList.frame.maxY + 30, width: addUsersFromList.frame.width - 20, height: 30))
        //userAdded.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        riskFactorHeader.text = "Risk Level:"
        riskFactorHeader.font = UIFont.boldSystemFont(ofSize: 20)
        
        
        riskFactorHeaderTextfield = UITextField(frame:CGRect(x: 20, y: riskFactorHeader.frame.maxY + 10, width: descriptionTextfield.frame.width - 20, height: 30))
        //userAddedTextfield.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        riskFactorHeaderTextfield.placeholder = "John Bean"
        riskFactorHeaderTextfield.font = UIFont.systemFont(ofSize: 15)
        
        //300

        //Buttons:
        riskFactorButton = UIButton(frame:CGRect(x: descriptionTextfield.frame.maxX - 20 - 60, y: riskFactorHeader.frame.maxY + 10, width: 60, height: 30))
        riskFactorButton.setTitleColor(UIColor.white, for: .normal)
        riskFactorButton.setTitle("Add", for: .normal)

        //editImage.setImage(UIImage(systemName: "pencil"), for: .normal)
        riskFactorButton.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        riskFactorButton.layer.cornerRadius = 15
        riskFactorButton.layer.masksToBounds = true
        riskFactorButton.addTarget(self, action: #selector(editDescriptionButton(_:)), for: .touchUpInside)
        
        
        
     
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: topBarHeight, width: view.frame.width, height: view.frame.height ))
        scrollView.contentSize.height = maxScroll

        
        view.addSubview(scrollView)
        scrollView.addSubview(descriptionTextfield)
        scrollView.addSubview(userAdded)
        scrollView.addSubview(userAddedTextfield)
        scrollView.addSubview(addUsersFromList)
        
        scrollView.addSubview(riskFactorHeader)
        scrollView.addSubview(riskFactorHeaderTextfield)
        scrollView.addSubview(riskFactorButton)
    }
    

    @objc func editDescriptionButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "addDescription", sender: self)
        

    }
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool
    {
        if(text == "\n")
        {
            view.endEditing(true)
            
            self.delegate?.saveDescription(text: self.descriptionTextfield.text)
           
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                self.navigationController?.popViewController(animated: true)
                
                self.dismiss(animated: true, completion: nil)
                
             
            })
            
       
            
            return false
        }
        else
        {
            return true
        }
    }

}
