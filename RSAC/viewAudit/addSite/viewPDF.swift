//
//  viewPDF.swift
//  RSAC
//
//  Created by John on 22/11/2023.
//

import UIKit
import PDFKit
import TPPDF
import WebKit

class viewPDF: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    public var documentData: Data?
    @IBOutlet weak var pdfView: PDFView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //PDF created:
//        if let data = documentData {
//
//            DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: { [self] in
//                pdfView.document = PDFDocument(data: data)
//                pdfView.autoScales = true
//
//            })
//
        
        createPDFData()
     }
        
        
    func createPDFData(){
        let document = PDFDocument(format: .a4)
        
        //add the data here:
        //header data:
        document.add(.headerLeft, text: "KwikAudits")
        //line seperator
        let style = PDFLineStyle(type: .full, color: .darkGray, width: 1)
        document.addLineSeparator(PDFContainer.contentLeft, style: style)
        //Observation Title:
        document.set(.contentLeft, font: Font.boldSystemFont(ofSize: 50.0))
        document.set(.contentLeft, textColor: Color(red: 0, green: 0, blue: 0, alpha: 1))
        // Company Name:
        document.add(.contentLeft, textObject: PDFSimpleText(text: "Company Name"))
        // Add some spacing below title
        document.add(space: 15.0)
        // Project Name:
        document.add(.contentLeft, text: "This is the name of your project")

        // Add some spacing below title
        document.add(space: 15.0)
        
        // Create and add a subtitle as an attributed string for more customization possibilities
        let title = NSMutableAttributedString(string: "28/07/1994", attributes: [
            .font: Font.systemFont(ofSize: 18.0),
            .foregroundColor: Color(red: 0.171875, green: 0.2421875, blue: 0.3125, alpha: 1.0)
        ])
        document.add(.contentLeft, attributedText: title)
        
        //Create a colums to insert data
        let tableOfUserData = PDFTable(rows: 3, columns: 2)
        let cellStyle = PDFTableStyleDefaults.none
   

        // Change standardized styles
      
        tableOfUserData.content = [
            ["Signed",      nil],
            ["John doe",      nil],
            [Image(named: "Image-1.jpg")!, nil],
   
        ]
        tableOfUserData.rows.allRowsAlignment = [.right, .left]

        // The widths of each column is proportional to the total width, set by a value between 0.0 and 1.0, representing percentage.

        tableOfUserData.widths = [
            0.2, 0.8
        
        ]
    
        document.add(table: tableOfUserData)
       

        
        //PAGE BREAK
        document.createNewPage()
        
        //line seperator
        document.addLineSeparator(PDFContainer.contentLeft, style: style)
        //Create a colums to insert data
        let table = PDFTable(rows: 5, columns: 4)
        table.content = [
            [nil, "Name",      "Image",                        "Description"],
            [1,   "Waterfall", Image(named: "Image-1.jpg")!, "Water flowing down stones."],
            [2,   "Forrest",   Image(named: "Image-2.jpg")!, "Sunlight shining through the leafs."],
            [3,   "Fireworks", Image(named: "Image-3.jpg")!, "Fireworks exploding into 100.000 stars"],
            [nil, nil,         nil,                            "Many beautiful places"]

        ]
        
  
        table.rows.allRowsAlignment = [.center, .left, .center, .left]

        // The widths of each column is proportional to the total width, set by a value between 0.0 and 1.0, representing percentage.

        table.widths = [
            0.1, 0.25, 0.35, 0.3
        ]
        table.showHeadersOnEveryPage = true
        document.add(table: table)


        
        
        
        
        
        
        
        
        
        
        
        
        
        //Export the file
        
        let filename = "awesome.pdf"
        let generator = PDFGenerator(document: document)
  
        DispatchQueue.global(qos: .background).async {
            do {
                let url = try generator.generateURL(filename: filename)
                print("Output URL:", url)
  

                DispatchQueue.main.async {
        
                    // Load PDF into a webview from the temporary file
                    self.webView.load(URLRequest(url: url))
                }
            } catch {
                print("Error while generating PDF: " + error.localizedDescription)
            }
        }


        // Do any additional setup after loading the view.
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
