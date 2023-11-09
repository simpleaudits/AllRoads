//
//  DescriptionVC.swift
//  dbtestswift
//
//  Created by macbook on 2/11/19.
//  Copyright © 2019 macbook. All rights reserved.
//

import UIKit


protocol scopeDecriptionString{
    func finishPassing_decription(saveDescription: String)
}

class scopeDecription: UIViewController,UITextFieldDelegate,UITextViewDelegate{
    var DetailsField: UITextView!
    
    var descriptionFromParent = String()
    var delegate: scopeDecriptionString?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPopUpButton()
       
        DetailsField =  UITextView(frame: CGRect(x: 0, y: (self.navigationController?.navigationBar.frame.height)! + 20, width: view.frame.width, height: view.frame.height * 0.7))
        DetailsField.font = UIFont.systemFont(ofSize: 15)
        DetailsField.keyboardType = UIKeyboardType.default
        DetailsField.returnKeyType = UIReturnKeyType.done
        DetailsField.textAlignment = .left
       
        DetailsField.delegate = self
        DetailsField.text = descriptionFromParent
        self.view.addSubview(DetailsField)


    }

    @IBOutlet weak var buttonOps: UIBarButtonItem!
    
    @IBAction func entryOptions(_ sender: UIBarButtonItem) {
        
    }
    func setupPopUpButton() {
        let usersItem = UIAction(title: "Users", image: UIImage(systemName: "person.fill")) { (action) in

              print("Users action was tapped")
         }

         let addUserItem = UIAction(title: "Add User", image: UIImage(systemName: "person.badge.plus")) { (action) in

             print("Add User action was tapped")
         }

         let removeUserItem = UIAction(title: "Remove User", image: UIImage(systemName: "person.fill.xmark.rtl")) { (action) in
              print("Remove User action was tapped")
         }

         let menu = UIMenu(title: "My Menu", options: .displayInline, children: [usersItem , addUserItem , removeUserItem])
        buttonOps.menu = menu
       
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()

        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool
    {
        if(text == "\n")
        {
            view.endEditing(true)
            
            self.delegate?.finishPassing_decription(saveDescription: self.DetailsField.text)
           
            
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
