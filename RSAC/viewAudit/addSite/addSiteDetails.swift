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
    var descriptionTextfield = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

       
        
        descriptionTextfield = UITextView(frame: CGRect(x: 10, y: 20, width: Int(view.frame.width) - 20, height: 200 ))
        descriptionTextfield.font = UIFont.systemFont(ofSize: 20)
        descriptionTextfield.delegate = self
        descriptionTextfield.layer.borderWidth = 2
        descriptionTextfield.layer.cornerRadius = 20
        descriptionTextfield.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        //descriptionTextfield.layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        descriptionTextfield.layer.masksToBounds = false
//        descriptionTextfield.layer.shadowOffset = CGSize(width: 0, height: 4.0)
//        descriptionTextfield.layer.shadowRadius = 8.0
//        descriptionTextfield.layer.shadowOpacity = 0.4
        
        view.addSubview(descriptionTextfield)
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
