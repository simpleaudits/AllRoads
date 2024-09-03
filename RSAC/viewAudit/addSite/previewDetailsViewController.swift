//
//  previewDetailsViewController.swift
//  RSAC
//
//  Created by John on 2/9/2024.
//

import UIKit

class previewDetailsViewController: UIViewController {
    
    
    var detailsText = String()
    var detailsDescription = UITextView()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let navigationBarHeight = navigationController?.navigationBar.frame.height {
      
                detailsDescription  = UITextView(frame: CGRect(x: 10, y: Int(navigationBarHeight) + 50, width: Int(view.frame.width) - 20, height: 50 )) // currently uses static height
                detailsDescription.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                detailsDescription.layer.masksToBounds = true
                detailsDescription.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
                detailsDescription.textAlignment = .left
                detailsDescription.isHidden = true
                

            } else {
                
            }
      
        
        self.view.addSubview(detailsDescription)

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        //Animate the label everytime a new entry is put in
        detailsDescription.isHidden = false
        UIView.transition(with: detailsDescription,
                              duration: 1,
                              options: [.transitionCrossDissolve],
                              animations: {
            self.detailsDescription.text = "dsfsdkjf sdfg sdkfj kdsf gkjdsf kjdsdfhgdfsh jdksfkj sdfhk dsfkjfds sdf jkdf skdk sdf sd gkjdf "
    
            
            self.updateLabelFrame()
            
        }, completion: nil)
    }
    


    
// MARK: - textfield height protocol
    func updateLabelFrame() {
            let maxWidth = view.frame.width - 40
            let size = detailsDescription.sizeThatFits(CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude))
            
            // Set new frame
        detailsDescription.frame.size.height = size.height + 10
        }

    
    
// MARK: - textfield height protocol

}
