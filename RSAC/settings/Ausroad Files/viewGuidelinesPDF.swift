//
//  viewGuidelinesPDF.swift
//  RSAC
//
//  Created by John on 18/5/2024.
//

import UIKit
import WebKit
import PDFKit

class viewGuidelinesPDF: UIViewController {
    
    var PDFfilename = String()
    var headingName = String()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(PDFfilename)
    
        navigationItem.title = headingName
        
        
        let pdfView = PDFView(frame: self.view.bounds)
     
        pdfView.translatesAutoresizingMaskIntoConstraints = false
        pdfView.autoScales = true
        view.addSubview(pdfView)

        guard let path = Bundle.main.url(forResource: "\(PDFfilename.dropLast(4))", withExtension: "pdf") else { return }
        if let document = PDFDocument(url: path) {
            pdfView.document = document
        }
    }
        
 

      

}
