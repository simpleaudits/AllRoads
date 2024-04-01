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
import Firebase
import SwiftLoader

class viewPDF: UIViewController {
    @IBOutlet weak var webView: WKWebView!
 
    let mainConsole = CONSOLE()
    //let mainFunction = extens()
    
    
    var refData = String()
    var imageData = UIImage()
    
    // arary based on TPPDF
    var contextData: [Any] = []
    
    var listOfSitesData: [auditSiteData] = []
    var saveData: [PDFCreatorData] = []
    
    var imagez: [PDFImage] = []
    var tableContentData: [PDFTableContentable] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("passed:\(refData)")
        loadSiteAuditData()
        
        
        //PDF created:
//        if let data = documentData {
//
//            DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: { [self] in
//                pdfView.document = PDFDocument(data: data)
//                pdfView.autoScales = true
//
//            })
//
        
        SwiftLoader.show(title: "Creating PDF, one moment", animated: true)
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: { [self] in
//
//            SwiftLoader.show(title: "Nearly Done", animated: true)
//
//            perform(#selector(createPDFData), with: nil, afterDelay: TimeInterval(saveData.count))
//        })
        
       
     }
        
        
    @objc func createPDFData(){
        
        SwiftLoader.hide()
        
        let document = PDFDocument(format: .a4)
        
        //add the data here:
        //header data:
        document.add(.headerLeft, text: "AllRoads Audit")
        //line seperator
        let style = PDFLineStyle(type: .full, color: .darkGray, width: 1)
        document.addLineSeparator(PDFContainer.contentLeft, style: style)
        //Observation Title:
        document.set(.contentLeft, font: Font.boldSystemFont(ofSize: 50.0))
        document.set(.contentLeft, textColor: Color(red: 0, green: 0, blue: 0, alpha: 1))
        // Company Name:
        document.add(.contentLeft, textObject: PDFSimpleText(text: "AllRoads Pty Ltd."))
        // Add some spacing below title
        document.add(space: 15.0)
        // Project Name:
        document.add(.contentLeft, text: "Draft Document")

        // Add some spacing below title
        document.add(space: 15.0)
        
        // Create and add a subtitle as an attributed string for more customization possibilities
        let title = NSMutableAttributedString(string: "Draft", attributes: [
            .font: Font.systemFont(ofSize: 15.0),
            .foregroundColor: Color(red: 0.171875, green: 0.2421875, blue: 0.3125, alpha: 1.0)
        ])
        document.add(.contentRight, attributedText: title)
        
        // Add some spacing below title
        document.add(space: 15.0)
        
        //Create a colums to insert data
        let tableOfUserData = PDFTable(rows: 1, columns: 2)
        let cellStyle = PDFTableStyleDefaults.simple
   

        // Change standardized styles
      
        tableOfUserData.content = [
//            ["Signed",      nil],
//            ["John doe",      nil],
            [Image(named: "whiteBackdrop.png")!, nil],
   
        ]
        tableOfUserData.rows.allRowsAlignment = [.right, .left]
        tableOfUserData[0,1].style = PDFTableCellStyle(colors: (fill: #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1), text: UIColor.black))
        tableOfUserData[0,0].style = PDFTableCellStyle(colors: (fill: #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1), text: UIColor.black))

        // The widths of each column is proportional to the total width, set by a value between 0.0 and 1.0, representing percentage.

        tableOfUserData.widths = [
            0.2, 0.8
        
        ]
    
        document.add(table: tableOfUserData)
       

        
        //PAGE BREAK
        document.createNewPage()
        
//        //line seperator
//        document.addLineSeparator(PDFContainer.contentLeft, style: style)
//        //Create a colums to insert data
//        let table = PDFTable(rows: 5, columns: 4)
//        table.content = [
//            [nil, "Name",      "Image",                        "Description"],
//            [1,   "Waterfall", Image(named: "Image-1.jpg")!, "Water flowing down stones."],
//            [2,   "Forrest",   Image(named: "Image-2.jpg")!, "Sunlight shining through the leafs."],
//            [3,   "Fireworks", Image(named: "Image-3.jpg")!, "Fireworks exploding into 100.000 stars"],
//            [nil, nil,         nil,                            "Many beautiful places"]
//
//        ]
//
//
//        table.rows.allRowsAlignment = [.center, .left, .center, .left]
//
//        // The widths of each column is proportional to the total width, set by a value between 0.0 and 1.0, representing percentage.
//
//        table.widths = [
//            0.1, 0.25, 0.35, 0.3
//        ]
//        table.showHeadersOnEveryPage = true
//        document.add(table: table)

        
//        imagez = [
//            PDFImage(image: UIImage(named: "Image-1.jpg")!),
//            PDFImage(image: UIImage(named: "Image-1.jpg")!)
//        ]


           // Here we want to create a data structure to store our firebase saved content
           for x in self.saveData{
//               let arrayDatahere =  ["1",   "\(x.title)", x.imageData, "\(x.body)", ] as [Any]
//               self.contextData.append(arrayDatahere)

               
               //line seperator
               let style1 = PDFLineStyle(type: .full, color: .darkGray, width: 1)
               document.addLineSeparator(PDFContainer.contentLeft, style: style1)
               
               //add space seperator
               document.add(space: 15.0)
               
               //Inset obseravtion image
               let image = PDFImage(image: x.imageData)
               document.add(image:image)
              
               //add space seperator
               document.add(space: 15.0)
               
               //line serperater
               let style2 = PDFLineStyle(type: .full, color: #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1), width: 5)
               document.addLineSeparator(PDFContainer.contentLeft, style: style2)
               
               //add space seperator
               document.add(space: 15.0)
               
               //add line
               document.addLineSeparator(PDFContainer.contentLeft, style: style1)
               
               
               //Create a colums to insert data
               let tableOfUserData = PDFTable(rows: 4, columns: 2)
               let cellStyle = PDFTableStyleDefaults.simple
        
               // Change standardized styles
             
               tableOfUserData.content = [
                   ["Item",      "Details"],
                   ["Site name:",      "\(x.title)"],
                   ["Date:",      "\(x.date)"],
                   ["Obserations:",      "\(x.body)"],
          
               ]
               tableOfUserData.rows.allRowsAlignment = [.left, .left]
               tableOfUserData[0,1].style = PDFTableCellStyle(colors: (fill: #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1), text: UIColor.black))
               tableOfUserData[0,0].style = PDFTableCellStyle(colors: (fill: #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1), text: UIColor.black))

               // The widths of each column is proportional to the total width, set by a value between 0.0 and 1.0, representing percentage.

               tableOfUserData.widths = [
                   0.2, 0.8
               ]
           
               document.add(table: tableOfUserData)
               
               
               
               // Add custom pagination, starting at page 1 and excluding page 3
               document.pagination = PDFPagination(container: .footerLeft, style: PDFPaginationStyle.customClosure { (page, total) -> String in
                   return "page \(page) of \(total)"
               }, range: (1, 10000), hiddenPages: [0, 0], textAttributes: [
                       .font: Font.boldSystemFont(ofSize: 12),
                       .foregroundColor: Color.black
               ])
               document.addLineSeparator(PDFContainer.contentLeft, style: style1)
               
               document.createNewPage()

           }
        
       
        
        
        
        //Export the file
        
        let filename = "AllRoads_Doc).pdf"
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
    


    func loadSiteAuditData(){

                    if Auth.auth().currentUser != nil {

                    Database.database().reference(withPath:"\(refData)/\(mainConsole.auditList!)")
                    .observe(.value, with: { [self] snapshot in

                    var listOfSitesData: [auditSiteData] = []
                    for child in snapshot.children {

                    if let snapshot = child as? DataSnapshot,
                    let List = auditSiteData(snapshot: snapshot) {
                    listOfSitesData.append(List)
                    }
                    }
                    self.listOfSitesData = listOfSitesData
                    //call it after all data is loaded to remove duplications:
                        
                    let group = DispatchGroup()
              
                        for x in listOfSitesData{
                            group.enter()
    

                            asyncData( imageURL: x.imageURL, descriptionData: x.auditDescription, auditTitleData: x.auditTitle, dateData: x.date) { result in do { group.leave()}
                            
                            print(result)
                                
                            }

                        }

                        
                        group.notify(queue: DispatchQueue.main){
                            print("All tasks completed")
                            
                            //once all tasks are completed, and data is loaded. Create the PDF
                            self.createPDFData()
                        }


//                    for x in listOfSitesData{
//
//
//
//                    DispatchQueue.global(qos: .background).async {
//                        do
//                        {
//                        let data = try Data.init(contentsOf: URL.init(string:x.imageURL)!)
//                            DispatchQueue.main.async {
//
//                                self.imageData = UIImage(data: data)!
//                                let pdfCreator = PDFCreatorData(title: x.auditTitle, description: x.auditDescription, imageData: self.imageData, image: "", date: x.date)
//                                self.saveData.append(pdfCreator)
//                                print(self.imageData)
//
//                        }
//
//
//
//
//
//                        }catch {
//                        // error
//                        }
//                    }
//
//
//                    }

           
         


                    })


                    }

                    }


    
    
    
    func asyncData(imageURL:String, descriptionData: String, auditTitleData:String, dateData:String, completion: @escaping (String) -> Void) {
        
   
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            
            let url = URL(string:"\(imageURL)")
            let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
                
                let image: UIImage = UIImage(data: data!)!
                self.imageData = image
                let pdfCreator = PDFCreatorData(title: auditTitleData, description: descriptionData, imageData: self.imageData, image: "", date: dateData)
                self.saveData.append(pdfCreator)
                
                print(image)
                completion("done")
                
            }
            task.resume()

        }
    }
    
    
    
    
    
    
    
    
    
}
