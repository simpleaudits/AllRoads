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


extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

//MARK: - remove dup in array

extension Array where Element:Equatable {
    func removeDuplicates() -> [Element] {
        var result = [Element]()

        for value in self {
            if result.contains(value) == false {
                result.append(value)
            }
        }

        return result
    }
}

//MARK: - remove dup in array

class viewPDF: UIViewController {
    @IBOutlet weak var webView: WKWebView!
 
    //PDF settings:
    var PDFenum = "0"
    var colourStyle = "#FFA500"
    
    let mainConsole = CONSOLE()
    //let mainFunction = extens()
    
    
    var refData = String()
    var imageData = UIImage()
    var reportData = [String: Any]()

    
    // arary based on TPPDF
    var contextData: [Any] = []
    
    var listOfSitesData: [auditSiteData] = []
    var saveData: [PDFCreatorData] = []

    var companyImage = UIImage()
    
    
    //company image and signature declare:
    var companyDPData: String? = "AppIcon50x50"
    var companySigData: String? = "Loading.."
    
    
    
    var imagez: [PDFImage] = []
    var tableContentData: [PDFTableContentable] = []
    
    
    var userDataArray = [String]()
    
    


    
    
    //MARK: - Load configurations
    
    func loadUserReportSettings(){
        let uid = Auth.auth().currentUser?.uid
        let reftest = Database.database().reference().child("\(self.mainConsole.prod!)")
        let thisUsersGamesRef = reftest
            .child("\(self.mainConsole.post!)")
            .child(uid!)
            .child("\(self.mainConsole.reportConfig!)")
                 
        thisUsersGamesRef.queryOrderedByKey()
                     .observe( .value, with: { snapshot in
                               guard let dict = snapshot.value as? [String:Any] else {
                               //error here
                               return
                               }

                                let colourStyle = dict["colourStyle"] as? String
                                let pdfStyle = dict["pdfStyle"] as? String
                         
                                self.colourStyle = colourStyle!
                                self.PDFenum = pdfStyle!
                         
                                //1 Load report content
                                
                                
                         
                                //2)Load report contents next
                                self.loadSiteAuditData()
                   })
     
    }
    
    
    
    
    //MARK: - Load configurations
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
                // if this load successfully, load all other related data:
        loadUserReportSettings()
        
        
        
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

        
    
        
        switch PDFenum{
            
        case "0":
            
            SwiftLoader.hide()
            
            let document = PDFDocument(format: .a4)
            
            //header data:
            document.add(.headerLeft, image: PDFImage(image: companyImage, size: CGSize(width: 80, height: 40),sizeFit: PDFImageSizeFit.height, quality: 1))
            
            let attributedTitle = NSMutableAttributedString(string: "\(reportData["q5"] ?? "ERROR REFERENCE") | \(reportData["q9"] ?? "ERROR REFERENCE")", attributes: [
                .font: UIFont.boldSystemFont(ofSize: 10)
            ])
            
            let textElement = PDFAttributedText(text: attributedTitle)
            document.add(.headerRight,attributedTextObject: textElement)
            
            document.add(PDFContainer.headerLeft,space: 15.0)
            //line seperator
            let style = PDFLineStyle(type: .full, color: .darkGray, width: 1)
            document.addLineSeparator(PDFContainer.headerLeft, style: style)
              
            
            // REPORT TITLE:
            document.set(.contentLeft, font: Font.boldSystemFont(ofSize: 50.0))
            document.set(.contentLeft, textColor: Color(red: 0, green: 0, blue: 0, alpha: 1))
          
            document.add(.contentLeft, textObject: PDFSimpleText(text: "\(reportData["q1000"] ?? "ERROR REFERENCE")"))
            // Add some spacing below title
            document.add(space: 15.0)
            
            // AUDIT PREPARED BY and FOR:
            document.set(.contentLeft, font: Font.boldSystemFont(ofSize: 30.0))
            document.set(.contentLeft, textColor: Color(red: 0, green: 0, blue: 0, alpha: 1))
           
            document.add(.contentLeft, textObject: PDFSimpleText(text: "Prepared by \(reportData["q5"] ?? "ERROR REFERENCE") for \(reportData["q10"] ?? "ERROR REFERENCE")"))
            // Add some spacing below title
            document.add(space: 15.0)
            
            
            // AUDIT COMPLETED DATE:
            document.set(.contentLeft, font: Font.boldSystemFont(ofSize: 15.0))
            document.set(.contentLeft, textColor: Color(red: 0, green: 0, blue: 0, alpha: 1))
            
            document.add(.contentLeft, textObject: PDFSimpleText(text: "\(reportData["q1001"] ?? "ERROR REFERENCE")"))
            // Add some spacing below title

    
            
            // Add some spacing below title
            document.add(space: 15.0)
            
            //Create a colums to insert data
            let tableOfUserData = PDFTable(rows: 1, columns: 2)

            
            // Change standardized styles
            
            tableOfUserData.content = [
                //            ["Signed",      nil],
                //            ["John doe",      nil],
                [Image(named: "whiteBackdrop.png")!, nil],
                
            ]
            tableOfUserData.rows.allRowsAlignment = [.right, .left]
            tableOfUserData[0,1].style = PDFTableCellStyle(colors: (fill: UIColor(hexString: colourStyle), text: UIColor.white))
            tableOfUserData[0,0].style = PDFTableCellStyle(colors: (fill: UIColor(hexString: colourStyle), text: UIColor.white))
                                                           
                                                           
            
            // The widths of each column is proportional to the total width, set by a value between 0.0 and 1.0, representing percentage.
            
            tableOfUserData.widths = [
                0.2, 0.8
                
            ]
            
            document.add(table: tableOfUserData)
            
            
            document.add(space: 15.0)
            document.set(.contentLeft, font: Font.boldSystemFont(ofSize: 15.0))
            document.set(.contentLeft, textColor: Color(red: 0, green: 0, blue: 0, alpha: 1))
    

        
            
            //PAGE BREAK
            document.createNewPage()
            
            
            //MARK: - document introduction section

            
            //Introduction section
            let Header_1_0 = NSMutableAttributedString(string: "1.0 Introduction", attributes: [
                .font: UIFont.boldSystemFont(ofSize: 12)
            ])
            let Header_element_1_0 = PDFAttributedText(text: Header_1_0)
            document.add(.contentLeft,attributedTextObject: Header_element_1_0)
            
            //Scope of audit (sub header):
            let Subheader_1_0 = NSMutableAttributedString(string: "1.1 Scope of Audit", attributes: [
                .font: UIFont.italicSystemFont(ofSize: 10)
            ])
            let Subheader_element_1_0 = PDFAttributedText(text: Subheader_1_0)
            document.add(.contentLeft,attributedTextObject: Subheader_element_1_0)
            
            let introductionString = """
            A road safety audit is a formal, systematic assessment of potential road safety risks associated with new or improved road projects. It is conducted by an independent, qualified audit team and considers all road users. The audit suggests measures to eliminate or mitigate identified risks.

            This Road Safety Audit follows the principles outlined in Austroads Guide to Road Safety Part 6: Road Safety Audit and meets the requirements of the Policy and Guidelines for Road Safety Audit.

            This report presents findings undertaken during the \(reportData["q6"] ?? "ERROR REFERENCE") stage, conducted at \(reportData["q7"] ?? "ERROR REFERENCE").

            The audit was conducted by \(reportData["q35"] ?? "ERROR REFERENCE") from \(reportData["q5"] ?? "ERROR REFERENCE"), with reference to details provided in the Audit Brief.

            The audit included a review of drawings and information provided by \(reportData["q10"] ?? "ERROR REFERENCE").

            All findings in this report indicate the need for actions to improve project safety and reduce crash risks and severity. The audit specifically focuses on road safety implications of the project presented, without verifying compliance with other criteria.
            """

            
            let data_1_0 = NSMutableAttributedString(string: introductionString, attributes: [
                .font: UIFont.systemFont(ofSize: 10)
            ])
            let data_element_1_0 = PDFAttributedText(text: data_1_0)
            document.add(.contentLeft,attributedTextObject: data_element_1_0)
            
            
            
            // Add some spacing below title
            document.add(space: 15.0)
            
// MARK: Audit team  ------------------------------------------
            
            //Audti team section
        
            let Header_2_0 = NSMutableAttributedString(string: "2.0 Audit Team", attributes: [
                .font: UIFont.boldSystemFont(ofSize: 12)
            ])
            let Header_element_2_0 = PDFAttributedText(text: Header_2_0)
            document.add(.contentLeft,attributedTextObject: Header_element_2_0)
            
            //Scope of audit (sub header):
            let Subheader_2_0 = NSMutableAttributedString(string: "2.1 Contributors", attributes: [
                .font: UIFont.italicSystemFont(ofSize: 10)
            ])
            let Subheader_element_2_0 = PDFAttributedText(text: Subheader_2_0)
            document.add(.contentLeft,attributedTextObject: Subheader_element_2_0)
            
   
            document.set(.contentLeft, font: Font.boldSystemFont(ofSize: 10.0))
            for x in self.saveData{
                userDataArray.append("\(x.userUploaded)")
            }

           
            
            let items = userDataArray.removeDuplicates()

            // Simple bullet point list
            let featureList = PDFList(indentations: [
                (pre: 10.0, past: 20.0),
                (pre: 20.0, past: 20.0),
                (pre: 40.0, past: 20.0)
            ])

            // By adding the item first to a list item with the dot symbol, all of them will inherit it
            featureList
                .addItem(PDFListItem(symbol: .dot)
                    .addItems(items.map({ item in
                        PDFListItem(content: item)
                    })))
            document.add(list: featureList)
            
            
            // Add some spacing below title
            document.add(space: 15.0)

            
            let auditTeamText = """
            The audit team visited the site on \(reportData["q36"] ?? "ERROR REFERENCE"). At the time of the visit, the weather condition was \(reportData["q37"] ?? "ERROR REFERENCE") and the existing road surface was \(reportData["q38"] ?? "ERROR REFERENCE").
            """
            
            
            let data_2_0 = NSMutableAttributedString(string: auditTeamText, attributes: [
                .font: UIFont.systemFont(ofSize: 10)
            ])
            let data_element_2_0 = PDFAttributedText(text: data_2_0)
            document.add(.contentLeft,attributedTextObject: data_element_2_0)
            
            // Add some spacing below title
            document.add(space: 15.0)
            
// MARK: Audit team  ------------------------------------------
            
            
// MARK: Safe systems  ------------------------------------------
            
            // (header):
            let Header_3_0 = NSMutableAttributedString(string: "3.0 Safe Systems", attributes: [
                .font: UIFont.boldSystemFont(ofSize: 12)
            ])
            let Header_element_3_0 = PDFAttributedText(text: Header_3_0)
            document.add(.contentLeft,attributedTextObject: Header_element_3_0)
        
            
            let safeSystemFindings = """
            The aim of Safe System Findings is to focus the Road Safety Audit process on considering safe speeds and by providing forgiving roads and roadsides. This is to be delivered through the Road Safety Audit process by accepting that people will always make mistakes and by considering the known limits to crash forces the human body can tolerate. This is to achieved by focusing the Road Safety Audit on particular crash types that are known to result in higher severity outcomes at relatively lower speed environments to reduce the risk of fatal and serious injury crashes.
            
            The additional annotaiton *IMPORTANT* shall be used to provide emphasis to any road safety audit finding that has the potential to result in fatal or serious injury or findings that are likely to result in the following crash types above the related speed environment:
            - Head on, >70kmh
            - Right angle, >50kmh
            - Run off road, > 40kmh
            - Vulnerable road users, > 30kmh
            
            The exposure and likelihood of crash occurence shall then be considered for all findings deemed *IMPORTANT* and evaluated based on an audtiors professional judgement. Auditors should consider factors such as, traffic volumes and movements, speed environment, crash history and the road environment, and apply road safety engineering and crash investigation experience to determine the likelihood of crash occurence. The likelihood of crash occurence shall be consiered either:
            - Very high
            - High
            - Moderate
            - Low
            This additional annotation shall be displayed following the IMPORTANT annotation on applicable findings.
            
            """
            
            
            let data_3_0 = NSMutableAttributedString(string: safeSystemFindings, attributes: [
                .font: UIFont.systemFont(ofSize: 10)
            ])
            let data_element_3_0 = PDFAttributedText(text: data_3_0)
            document.add(.contentLeft,attributedTextObject: data_element_3_0)
            
            // Add some spacing below title
            document.add(space: 15.0)
            
// MARK: Safe systems  ------------------------------------------
            
// MARK: Previous safety audits ----------------------------------------
            
            // (header):
            let Header_4_0 = NSMutableAttributedString(string: "4.0 Previous Safety Audits", attributes: [
                .font: UIFont.boldSystemFont(ofSize: 12)
            ])
            let Header_element_4_0 = PDFAttributedText(text: Header_4_0)
            document.add(.contentLeft,attributedTextObject: Header_element_4_0)
 
            
            let previousAudits = """
            A previous audit was undertaken by \(reportData["q18"] ?? "ERROR REFERENCE") on \(reportData["q17"] ?? "ERROR REFERENCE").
            
            The items raised from \(reportData["q15"] ?? "ERROR REFERENCE") audit (previous audit) have been addressed with the exception of the items listed as NOT ADDRESSED.
            
            NOT ADDRESSED - refers to any historical audit findings that have not been addressed in the current stage of work.
            
            These items are discussed again in this road safety audit.
            
            """

            
            let data_4_0 = NSMutableAttributedString(string: previousAudits, attributes: [
                .font: UIFont.systemFont(ofSize: 10)
            ])
            let data_element_4_0 = PDFAttributedText(text: data_4_0)
            document.add(.contentLeft,attributedTextObject: data_element_4_0)
            
            
            // Add some spacing below title
            document.add(space: 15.0)
            
            
            
// MARK: Previous safety audits ----------------------------------------
            
// MARK: Background Data ----------------------------------------
            
            //Introduction section
            let Header_5_0 = NSMutableAttributedString(string: "5.0 Background Data", attributes: [
                .font: UIFont.boldSystemFont(ofSize: 12)
            ])
            let Header_element_5_0 = PDFAttributedText(text: Header_5_0)
            document.add(.contentLeft,attributedTextObject: Header_element_5_0)
            
            //Scope of audit (sub header):
            let Subheader_5_0 = NSMutableAttributedString(string: "5.1 Crash History", attributes: [
                .font: UIFont.italicSystemFont(ofSize: 10)
            ])
            let Subheader_element_5_0 = PDFAttributedText(text: Subheader_5_0)
            document.add(.contentLeft,attributedTextObject: Subheader_element_5_0)
            
            let backgroundData = """
            A study was undertaken for previous crashes in this area over a 5 year period from the date of this audit. Historically, it is shown that the following crash types have been observed this in this area. See below:
            """

            
            let data_5_0 = NSMutableAttributedString(string: backgroundData, attributes: [
                .font: UIFont.systemFont(ofSize: 10)
            ])
            let data_element_5_0 = PDFAttributedText(text: data_5_0)
            document.add(.contentLeft,attributedTextObject: data_element_5_0)
            
            //Add list of user selected crash types here:
            // Convert string to Data
            guard let jsonData = "\(reportData["q30"] ?? "ERROR REFERENCE")".data(using: .utf8) else {
                print("Error: Unable to convert string to Data")
                return
            }
            // Decode JSON data to array of strings
            do {
                let stringArray = try JSONDecoder().decode([String].self, from: jsonData)
                print(stringArray) // Output: ["Hit Train", "Adjacent approach"]
                
                // Simple bullet point list
                let crashList = PDFList(indentations: [
                    (pre: 10.0, past: 20.0),
                    (pre: 20.0, past: 20.0),
                    (pre: 40.0, past: 20.0)
                ])

                // By adding the item first to a list item with the dot symbol, all of them will inherit it
                crashList
                    .addItem(PDFListItem(symbol: .dot)
                        .addItems(stringArray.map({ stringArray in
                            PDFListItem(content: stringArray)
                        })))
                document.add(list: crashList)
                
            } catch {
                print("Error decoding JSON: \(error)")
            }
      
            
            // Add some spacing below title
            document.add(space: 15.0)
            
// MARK: Background Data ----------------------------------------
           
// MARK: Traffic Data -------------------------------------------
            
            let Header_6_0 = NSMutableAttributedString(string: "6.0 Traffic Data and Speed Data", attributes: [
                .font: UIFont.boldSystemFont(ofSize: 12)
            ])
            let Header_element_6_0 = PDFAttributedText(text: Header_6_0)
            document.add(.contentLeft,attributedTextObject: Header_element_6_0)
            
            //Scope of audit (sub header):
            let Subheader_6_0 = NSMutableAttributedString(string: "6.1 Flows", attributes: [
                .font: UIFont.italicSystemFont(ofSize: 10)
            ])
            let Subheader_element_6_0 = PDFAttributedText(text: Subheader_6_0)
            document.add(.contentLeft,attributedTextObject: Subheader_element_6_0)
       
            
            
            let flowText = """
            A summary of the most recent traffic data is provided below:
            """

            
            let data_6_0 = NSMutableAttributedString(string: flowText, attributes: [
                .font: UIFont.systemFont(ofSize: 10)
            ])
            let data_element_6_0 = PDFAttributedText(text: data_6_0)
            document.add(.contentLeft,attributedTextObject: data_element_6_0)
            
                    
            //Table of speed and traffic flow:
            let tableOfFlows = PDFTable(rows: 2, columns: 4)
            
            //Header Cell Configuration:
            let colors = (fill: UIColor.white, text: UIColor.black)
            let lineStyle = PDFLineStyle(type: .full, color: UIColor.black, width: 1)
            let borders = PDFTableCellBorders(left: lineStyle, top: lineStyle, right: lineStyle, bottom: lineStyle)
            let font = UIFont.systemFont(ofSize: 10)
            let font2 = UIFont.boldSystemFont(ofSize: 10)
            
            //Data Cell Configuration:
            let font3 = UIFont.boldSystemFont(ofSize: 10)
            let lineStyle3 = PDFLineStyle(type: .full, color: UIColor.black, width: 1)
            let borders3 = PDFTableCellBorders(left:lineStyle3, right: lineStyle3, bottom: lineStyle3)
       
            // Change standardized styles
            tableOfFlows.content = [
                ["Location", "Vehicles Per day","HV%", "Date"],
                ["\(reportData["q7"] ?? "ERROR REFERENCE")","\(reportData["q28"] ?? "ERROR REFERENCE")","\(reportData["q40"] ?? "ERROR REFERENCE")","\(reportData["q36"] ?? "ERROR REFERENCE")"]
                
            ]
            
            //Headers
            tableOfFlows[0,3].style = PDFTableCellStyle(colors: (fill: UIColor(hexString: colourStyle), text: UIColor.white),borders: borders, font: font2)
            tableOfFlows[0,2].style = PDFTableCellStyle(colors: (fill: UIColor(hexString: colourStyle), text: UIColor.white),borders: borders, font: font2)
            tableOfFlows[0,1].style = PDFTableCellStyle(colors: (fill: UIColor(hexString: colourStyle), text: UIColor.white),borders: borders, font: font2)
            tableOfFlows[0,0].style = PDFTableCellStyle(colors: (fill: UIColor(hexString: colourStyle), text: UIColor.white),borders: borders, font: font2)
            
            //contents
            tableOfFlows[1,0].style = PDFTableCellStyle(colors: (fill: UIColor.white, text: UIColor.black), borders: borders3, font: font3)
            tableOfFlows[1,1].style = PDFTableCellStyle(colors: (fill: UIColor.white, text: UIColor.black), borders: borders3, font: font3)
            tableOfFlows[1,2].style = PDFTableCellStyle(colors: (fill: UIColor.white, text: UIColor.black), borders: borders3, font: font3)
            tableOfFlows[1,3].style = PDFTableCellStyle(colors: (fill: UIColor.white, text: UIColor.black), borders: borders3, font: font3)
            
            
            tableOfFlows.rows.allRowsAlignment = [.center,.center,.center, .center]
            
            tableOfFlows.widths = [
                0.25,0.25,0.25,0.25
            ]
            
            document.add(table: tableOfFlows)

            // Add some spacing below title
            document.add(space: 15.0)
            
            //Scope of audit (sub header):
            let Subheader_6_2 = NSMutableAttributedString(string: "6.2 Speed", attributes: [
                .font: UIFont.italicSystemFont(ofSize: 10)
            ])
            let Subheader_element_6_2 = PDFAttributedText(text: Subheader_6_2)
            document.add(.contentLeft,attributedTextObject: Subheader_element_6_2)
       
            
            
            
            let speedText = """
            A summary of the most recent traffic speed data is provided below:
            """

            
            let data_6_2 = NSMutableAttributedString(string: speedText, attributes: [
                .font: UIFont.systemFont(ofSize: 10)
            ])
            let data_element_6_2 = PDFAttributedText(text: data_6_2)
            document.add(.contentLeft,attributedTextObject: data_element_6_2)
            
            
            
                    
            //Table of speed and traffic flow:
            //Create a colums to insert data
            let tableOfSpeeds = PDFTable(rows: 2, columns: 4)
       
         
       
            // Change standardized styles
            tableOfSpeeds.content = [
                ["Location", "Average Speed","85th Percentile Speed", "Date"],
                ["\(reportData["q7"] ?? "ERROR REFERENCE")","\(reportData["q26"] ?? "ERROR REFERENCE")","\(reportData["q39"] ?? "ERROR REFERENCE")","\(reportData["q36"] ?? "ERROR REFERENCE")"]
                
            ]
            
            //Headers
            tableOfSpeeds[0,3].style = PDFTableCellStyle(colors: (fill: UIColor(hexString: colourStyle), text: UIColor.white),borders: borders, font: font2)
            tableOfSpeeds[0,2].style = PDFTableCellStyle(colors: (fill: UIColor(hexString: colourStyle), text: UIColor.white),borders: borders, font: font2)
            tableOfSpeeds[0,1].style = PDFTableCellStyle(colors: (fill: UIColor(hexString: colourStyle), text: UIColor.white),borders: borders, font: font2)
            tableOfSpeeds[0,0].style = PDFTableCellStyle(colors: (fill: UIColor(hexString: colourStyle), text: UIColor.white),borders: borders, font: font2)
            
            //contents
            tableOfSpeeds[1,0].style = PDFTableCellStyle(colors: (fill: UIColor.white, text: UIColor.black), borders: borders3, font: font3)
            tableOfSpeeds[1,1].style = PDFTableCellStyle(colors: (fill: UIColor.white, text: UIColor.black), borders: borders3, font: font3)
            tableOfSpeeds[1,2].style = PDFTableCellStyle(colors: (fill: UIColor.white, text: UIColor.black), borders: borders3, font: font3)
            tableOfSpeeds[1,3].style = PDFTableCellStyle(colors: (fill: UIColor.white, text: UIColor.black), borders: borders3, font: font3)
                    
            
            tableOfSpeeds.rows.allRowsAlignment = [.center,.center,.center, .center]
            
            tableOfSpeeds.widths = [
                0.25, 0.25,0.25,0.25
            ]
            
            document.add(table: tableOfSpeeds)

            
            
            

            
            
            
            

// MARK: Traffic Data -------------------------------------------
            
            
            
            
            
            
            
            
            
            
            
            
            
            
//MARK: - Observations load here///////////////////////////////////////////////////:
 
            //fresh page for observations:
            document.createNewPage()
            
        
            // Here we want to create a data structure to store our firebase saved content
            for x in self.saveData{
       
                
                //line seperator
                let style1 = PDFLineStyle(type: .full, color: .darkGray, width: 1)
                document.addLineSeparator(PDFContainer.contentLeft, style: style1)
                
            
                //Inset obseravtion image
                let image = PDFImage(image: x.imageData)
                document.add(image:image)

                document.add(space: 15.0)
              
                //add line
                document.addLineSeparator(PDFContainer.contentLeft, style: style1)
                
                
                //Create a colums to insert data
                let tableOfUserData = PDFTable(rows: 6, columns: 2)
                
                let colors = (fill: UIColor.white, text: UIColor.black)
                let lineStyle = PDFLineStyle(type: .full, color: UIColor.black, width: 1)
                let borders = PDFTableCellBorders(left: lineStyle, top: lineStyle, right: lineStyle, bottom: lineStyle)
                let font = UIFont.systemFont(ofSize: 10)
                let font2 = UIFont.boldSystemFont(ofSize: 15)
                let style = PDFTableCellStyle(colors: colors, font: font)
           
                
                // Change standardized styles
                
                tableOfUserData.content = [
                    ["Item",      "Details"],
                    ["Audit Title:",      " \(x.title)"],
                    ["Date:",           " \(x.date)"],
                    ["Coordinates:",    " \(x.lat), \(x.long)"],
                    ["Reporter:",       " \(x.userUploaded)"],
                    ["Observation:",    " \(x.body)"],
                    
                ]
                
                

                
                tableOfUserData.rows.allRowsAlignment = [.left, .left]
                
                
                //Middle column configuration:
                let font3 = UIFont.boldSystemFont(ofSize: 10)
                let lineStyle3 = PDFLineStyle(type: .full, color: UIColor.black, width: 1)
                let borders3 = PDFTableCellBorders(left:lineStyle3, right: lineStyle3, bottom: lineStyle3)
                
                
                //Headers
                tableOfUserData[0,1].style = PDFTableCellStyle(colors: (fill: UIColor(hexString: colourStyle), text: UIColor.white),borders: borders, font: font2)
                tableOfUserData[0,0].style = PDFTableCellStyle(colors: (fill: UIColor(hexString: colourStyle), text: UIColor.white),borders: borders, font: font2)
                
                //contents
                tableOfUserData[1,0].style = PDFTableCellStyle(colors: (fill: UIColor.white, text: UIColor.black), borders: borders3, font: font3)
                tableOfUserData[2,0].style = PDFTableCellStyle(colors: (fill: UIColor.white, text: UIColor.black), borders: borders3, font: font3)
                tableOfUserData[3,0].style = PDFTableCellStyle(colors: (fill: UIColor.white, text: UIColor.black), borders: borders3, font: font3)
                tableOfUserData[4,0].style = PDFTableCellStyle(colors: (fill: UIColor.white, text: UIColor.black), borders: borders3, font: font3)
                tableOfUserData[5,0].style = PDFTableCellStyle(colors: (fill: UIColor.white, text: UIColor.black), borders: borders3, font: font3)
                
                
                
                
                tableOfUserData[1,1].style = PDFTableCellStyle(colors: (fill: UIColor.white, text: UIColor.black), borders: borders3, font: font3)
                tableOfUserData[2,1].style = PDFTableCellStyle(colors: (fill: UIColor.white, text: UIColor.black), borders: borders3, font: font3)
                tableOfUserData[3,1].style = PDFTableCellStyle(colors: (fill: UIColor.white, text: UIColor.black), borders: borders3, font: font3)
                tableOfUserData[4,1].style = PDFTableCellStyle(colors: (fill: UIColor.white, text: UIColor.black), borders: borders3, font: font3)
                tableOfUserData[5,1].style = PDFTableCellStyle(colors: (fill: UIColor.white, text: UIColor.black), borders: borders3, font: font3)
                
                
                
                
                
                
  
                
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
            
            let filename = "AllRoads_Doc.pdf"
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
            
            
            break
            
        case "1":
            
            SwiftLoader.hide()
            
            let document = PDFDocument(format: .a4)
            
            

            //header data:
            document.add(.headerRight, image: PDFImage(image: UIImage(named: "AppIcon50x50.png")!, size: CGSize(width: 40, height: 40), quality: 1))
    
            let attributedTitle = NSMutableAttributedString(string: "AllRoads by SimpleAudits.app", attributes: [
                .font: UIFont.boldSystemFont(ofSize: 10)
            ])
            let textElement = PDFAttributedText(text: attributedTitle)
            document.add(.headerRight,attributedTextObject: textElement)
            
            //line seperator
            let style = PDFLineStyle(type: .full, color: .darkGray, width: 1)
            document.addLineSeparator(PDFContainer.headerRight, style: style)
            
            
            
            
            //Observation Title:
            document.set(.contentLeft, font: Font.boldSystemFont(ofSize: 50.0))
            document.set(.contentLeft, textColor: Color(red: 0, green: 0, blue: 0, alpha: 1))
            // Company Name:
            document.add(.contentLeft, textObject: PDFSimpleText(text: "Road Inspection Report"))
            // Add some spacing below title
            document.add(space: 15.0)
            
            
            document.set(.contentLeft, font: Font.boldSystemFont(ofSize: 30.0))
            document.set(.contentLeft, textColor: Color(red: 0, green: 0, blue: 0, alpha: 1))
            // Company Name:
            document.add(.contentLeft, textObject: PDFSimpleText(text: "Prepared by ABC"))
            // Add some spacing below title
            document.add(space: 15.0)
            
            document.set(.contentLeft, font: Font.boldSystemFont(ofSize: 15.0))
            document.set(.contentLeft, textColor: Color(red: 0, green: 0, blue: 0, alpha: 1))
            // Company Name:
            document.add(.contentLeft, textObject: PDFSimpleText(text: "1/1/2020"))
            // Add some spacing below title

    
            
            // Add some spacing below title
            document.add(space: 15.0)
            
            //Create a colums to insert data
            let tableOfUserData = PDFTable(rows: 1, columns: 2)

            
            // Change standardized styles
            
            tableOfUserData.content = [
                //            ["Signed",      nil],
                //            ["John doe",      nil],
                [Image(named: "whiteBackdrop.png")!, nil],
                
            ]
            tableOfUserData.rows.allRowsAlignment = [.right, .left]
            tableOfUserData[0,1].style = PDFTableCellStyle(colors: (fill: UIColor(hexString: colourStyle), text: UIColor.white))
            tableOfUserData[0,0].style = PDFTableCellStyle(colors: (fill: UIColor(hexString: colourStyle), text: UIColor.white))
                                                           
                                                           
            
            // The widths of each column is proportional to the total width, set by a value between 0.0 and 1.0, representing percentage.
            
            tableOfUserData.widths = [
                0.2, 0.8
                
            ]
            
            document.add(table: tableOfUserData)
            
            
            document.add(space: 15.0)
            document.set(.contentLeft, font: Font.boldSystemFont(ofSize: 15.0))
            document.set(.contentLeft, textColor: Color(red: 0, green: 0, blue: 0, alpha: 1))
            // Company Name:
            document.add(.contentLeft, textObject: PDFSimpleText(text: "Contributors"))
            // Add some spacing below title
            document.addLineSeparator(PDFContainer.contentLeft, style: style)
            
            document.set(.contentLeft, font: Font.boldSystemFont(ofSize: 10.0))
            for x in self.saveData{
                userDataArray.append("\(x.userUploaded)")
            }

           
            
            let items = userDataArray.removeDuplicates()
  

            // Simple bullet point list
            let featureList = PDFList(indentations: [
                (pre: 10.0, past: 20.0),
                (pre: 20.0, past: 20.0),
                (pre: 40.0, past: 20.0)
            ])

            // By adding the item first to a list item with the dot symbol, all of them will inherit it
            featureList
                .addItem(PDFListItem(symbol: .dot)
                    .addItems(items.map({ item in
                        PDFListItem(content: item)
                    })))
            document.add(list: featureList)
            
            
            
            document.addLineSeparator(PDFContainer.contentLeft, style: style)
            
            
            
            
            //PAGE BREAK
            document.createNewPage()
            
    
            
            // Here we want to create a data structure to store our firebase saved content
            for x in self.saveData{
        
          
                
                //Create a colums to insert data
                let tableOfUserData = PDFTable(rows: 6 + 1, columns: 4)
                
                //merge for image
                let row1 = tableOfUserData[rows:1...(3 + 1), column: 0]
                row1.merge()
                //merge contents
   
                let row4 = tableOfUserData[rows:1, columns: 2...3]
                row4.merge()
                let row5 = tableOfUserData[rows:2, columns: 2...3]
                row5.merge()
                let row6 = tableOfUserData[rows:3, columns: 2...3]
                row6.merge()
                let row7 = tableOfUserData[rows:4, columns: 2...3]
                row7.merge()
                let row8 = tableOfUserData[rows:0, columns: 2...3]
                row8.merge()
                
                // merge for comments
                let row2 = tableOfUserData[rows:4 + 1, columns: 0...3]
                row2.merge()
                let row3 = tableOfUserData[rows:5 + 1, columns: 0...3]
                row3.merge()
                
                
                //header colour
                let colors = (fill: UIColor.white, text: UIColor.black)
                let lineStyle = PDFLineStyle(type: .full, color: UIColor.black, width: 1)
                let borders = PDFTableCellBorders(left: lineStyle, top: lineStyle, right: lineStyle, bottom: lineStyle)
                let font = UIFont.systemFont(ofSize: 10)
                let font2 = UIFont.boldSystemFont(ofSize: 15)
                let style = PDFTableCellStyle(colors: colors, font: font)
                
                
                tableOfUserData[0,0].style = PDFTableCellStyle(colors: (fill: UIColor(hexString: colourStyle), text: UIColor.white),borders: borders, font: font2)
                tableOfUserData[0,1].style = PDFTableCellStyle(colors: (fill: UIColor(hexString: colourStyle), text: UIColor.white),borders: borders, font: font2)
                tableOfUserData[0,2].style = PDFTableCellStyle(colors: (fill: UIColor(hexString: colourStyle), text: UIColor.white),borders: borders, font: font2)
           
                
                //Middle column configuration:
                let font3 = UIFont.boldSystemFont(ofSize: 10)
                let lineStyle3 = PDFLineStyle(type: .full, color: UIColor.black, width: 1)
                let borders3 = PDFTableCellBorders(left:lineStyle3, right: lineStyle3, bottom: lineStyle3)
                
                
                //image cell
                tableOfUserData[1,0].style = PDFTableCellStyle(colors: (fill: UIColor.white, text: UIColor.black), borders: borders3, font: font3)
                
                //item cell
                tableOfUserData[1,1].style = PDFTableCellStyle(colors: (fill: UIColor.white, text: UIColor.black), borders: borders3, font: font3)
                tableOfUserData[2,1].style = PDFTableCellStyle(colors: (fill: UIColor.white, text: UIColor.black), borders: borders3, font: font3)
                tableOfUserData[3,1].style = PDFTableCellStyle(colors: (fill: UIColor.white, text: UIColor.black), borders: borders3, font: font3)
                tableOfUserData[4,1].style = PDFTableCellStyle(colors: (fill: UIColor.white, text: UIColor.black), borders: borders3, font: font3)
                
               //details cell
                tableOfUserData[1,2].style = PDFTableCellStyle(colors: (fill: UIColor.white, text: UIColor.black), borders: borders3, font: font3)
                tableOfUserData[2,2].style = PDFTableCellStyle(colors: (fill: UIColor.white, text: UIColor.black), borders: borders3, font: font3)
                tableOfUserData[3,2].style = PDFTableCellStyle(colors: (fill: UIColor.white, text: UIColor.black), borders: borders3, font: font3)
                tableOfUserData[4,2].style = PDFTableCellStyle(colors: (fill: UIColor.white, text: UIColor.black), borders: borders3, font: font3)
             
                //Observation column configuration
                tableOfUserData[5,0].style = PDFTableCellStyle(colors: (fill: UIColor(hexString: colourStyle), text: UIColor.white),borders: borders, font: font2)
                
                tableOfUserData[5 + 1,0].style = PDFTableCellStyle(colors: (fill: UIColor.white, text: UIColor.black), borders: borders3, font: font3)
                
               
                
                
                let lineStyle_user = PDFLineStyle(type: .full, color: UIColor.white, width: 3)
                let borders_user = PDFTableCellBorders(left: lineStyle_user, top: lineStyle_user, right: lineStyle_user, bottom: lineStyle_user)
      
       
                tableOfUserData.style = PDFTableStyle(rowHeaderStyle:style,footerStyle: style,contentStyle: style, alternatingContentStyle: style)

     
 
                tableOfUserData.content = [
                    ["Snapshot",  "Item"          , nil,  "Details"],
                    [nil,         "  Audit Title:"  , nil, "  \(x.title)"],
                    [nil,         "  Date:"       , nil, "  \(x.date)"],
                    [nil,         "  Coordinates:", nil, "  \(x.lat), \(x.long)"],
                    [x.imageData, "  Reporter:"   , nil, "  \(x.userUploaded)"],
                    [nil, nil,     nil, "Observation:"],
                    [nil, nil,     nil, "  \(x.body)"],
   
                    
                ]
                tableOfUserData.rows.allRowsAlignment = [.topLeft, .topLeft,.topLeft]
                tableOfUserData[0,0].alignment = .center
                tableOfUserData[0,1].alignment = .center
                tableOfUserData[0,2].alignment = .center
                tableOfUserData[0,3].alignment = .center
            
                tableOfUserData[6,0].alignment = .left
                
               
     


                
                // The widths of each column is proportional to the total width, set by a value between 0.0 and 1.0, representing percentage.
                
                tableOfUserData.widths = [
                    0.5, 0.2, 0.1, 0.2
                ]
                
                document.add(table: tableOfUserData)
                
                // Add some spacing below title
                document.add(space: 15.0)
                
                // Add custom pagination, starting at page 1 and excluding page 3
                document.pagination = PDFPagination(container: .footerLeft, style: PDFPaginationStyle.customClosure { (page, total) -> String in
                    return "page \(page) of \(total)"
                }, range: (1, 10000), hiddenPages: [0, 0], textAttributes: [
                    .font: Font.boldSystemFont(ofSize: 12),
                    .foregroundColor: Color.black
                ])
    
                
                //document.createNewPage()
                
            }
            
            
            
            
            
            //Export the file
            
            let filename = "AllRoads_Doc.pdf"
            let generator = PDFGenerator(document: document)
 
            
            
            DispatchQueue.global(qos: .background).async {
                do {
                    let url = try generator.generateURL(filename: filename)
                    print("Output URL:", url)
                    
                    DispatchQueue.main.async {
                        // Load PDF into a webview from the temporary file
                        self.webView.load(URLRequest(url: url))
                        
                        
                        //Save the document to local drive:
                        
                        
                    }
                } catch {
                    print("Error while generating PDF: " + error.localizedDescription)
                }
            }
            
            
            // Do any additional setup after loading the view.
            
            
            
            
            
            
            
            
            
            
            
            
            
        break
         
    
        case "2":
            
            
            SwiftLoader.hide()
            
            let document = PDFDocument(format: .a4)
            
            

            //header data:
            document.add(.headerRight, image: PDFImage(image: UIImage(named: "AppIcon50x50.png")!, size: CGSize(width: 40, height: 40), quality: 1))
    
            let attributedTitle = NSMutableAttributedString(string: "AllRoads by SimpleAudits.app", attributes: [
                .font: UIFont.boldSystemFont(ofSize: 10)
            ])
            let textElement = PDFAttributedText(text: attributedTitle)
            document.add(.headerRight,attributedTextObject: textElement)
            
            //line seperator
            let style = PDFLineStyle(type: .full, color: .darkGray, width: 1)
            document.addLineSeparator(PDFContainer.headerRight, style: style)
            
            
            
            
            //Observation Title:
            document.set(.contentLeft, font: Font.boldSystemFont(ofSize: 50.0))
            document.set(.contentLeft, textColor: Color(red: 0, green: 0, blue: 0, alpha: 1))
            // Company Name:
            document.add(.contentLeft, textObject: PDFSimpleText(text: "Road Inspection Report"))
            // Add some spacing below title
            document.add(space: 15.0)
            
            
            document.set(.contentLeft, font: Font.boldSystemFont(ofSize: 30.0))
            document.set(.contentLeft, textColor: Color(red: 0, green: 0, blue: 0, alpha: 1))
            // Company Name:
            document.add(.contentLeft, textObject: PDFSimpleText(text: "Prepared by ABC"))
            // Add some spacing below title
            document.add(space: 15.0)
            
            document.set(.contentLeft, font: Font.boldSystemFont(ofSize: 15.0))
            document.set(.contentLeft, textColor: Color(red: 0, green: 0, blue: 0, alpha: 1))
            // Company Name:
            document.add(.contentLeft, textObject: PDFSimpleText(text: "1/1/2020"))
            // Add some spacing below title

    
            
            // Add some spacing below title
            document.add(space: 15.0)
            
            //Create a colums to insert data
            let tableOfUserData = PDFTable(rows: 1, columns: 2)

            
            // Change standardized styles
            
            tableOfUserData.content = [
                //            ["Signed",      nil],
                //            ["John doe",      nil],
                [Image(named: "whiteBackdrop.png")!, nil],
                
            ]
            tableOfUserData.rows.allRowsAlignment = [.right, .left]
            tableOfUserData[0,1].style = PDFTableCellStyle(colors: (fill: UIColor(hexString: colourStyle), text: UIColor.white))
            tableOfUserData[0,0].style = PDFTableCellStyle(colors: (fill: UIColor(hexString: colourStyle), text: UIColor.white))
                                                           
                                                           
            
            // The widths of each column is proportional to the total width, set by a value between 0.0 and 1.0, representing percentage.
            
            tableOfUserData.widths = [
                0.2, 0.8
                
            ]
            
            document.add(table: tableOfUserData)
            
            
            document.add(space: 15.0)
            document.set(.contentLeft, font: Font.boldSystemFont(ofSize: 15.0))
            document.set(.contentLeft, textColor: Color(red: 0, green: 0, blue: 0, alpha: 1))
            // Company Name:
            document.add(.contentLeft, textObject: PDFSimpleText(text: "Contributors"))
            // Add some spacing below title
            document.addLineSeparator(PDFContainer.contentLeft, style: style)
            
            document.set(.contentLeft, font: Font.boldSystemFont(ofSize: 10.0))
            for x in self.saveData{
                userDataArray.append("\(x.userUploaded)")
            }

           
            
            let items = userDataArray.removeDuplicates()
  

            // Simple bullet point list
            let featureList = PDFList(indentations: [
                (pre: 10.0, past: 20.0),
                (pre: 20.0, past: 20.0),
                (pre: 40.0, past: 20.0)
            ])

            // By adding the item first to a list item with the dot symbol, all of them will inherit it
            featureList
                .addItem(PDFListItem(symbol: .dot)
                    .addItems(items.map({ item in
                        PDFListItem(content: item)
                    })))
            document.add(list: featureList)
            
            
            
            document.addLineSeparator(PDFContainer.contentLeft, style: style)
            
            
            
            //PAGE BREAK
            document.createNewPage()
            
    
            
            // Here we want to create a data structure to store our firebase saved content
            for x in self.saveData{
        
          
                
                //Create a colums to insert data
                let tableOfUserData = PDFTable(rows: 7, columns: 4)
                
                //merge for image
                let row1 = tableOfUserData[rows:1...5, column: 0]
                row1.merge()
                
                // merges the details column
                let row8 = tableOfUserData[rows:0, columns: 2...3]
                row8.merge()
                //merge contents
                let row4 = tableOfUserData[rows:1, columns: 2...3]
                row4.merge()
                let row5 = tableOfUserData[rows:2, columns: 2...3]
                row5.merge()
                let row6 = tableOfUserData[rows:3, columns: 2...3]
                row6.merge()
                let row7 = tableOfUserData[rows:4, columns: 2...3]
                row7.merge()
                let row9 = tableOfUserData[rows:5, columns: 2...3]
                row9.merge()
                
       
                
                
                //header colour
                let colors = (fill: UIColor.white, text: UIColor.black)
           
                let lineStyle = PDFLineStyle(type: .full, color: UIColor.black, width: 1)
                let borders = PDFTableCellBorders(left: lineStyle, top: lineStyle, right: lineStyle, bottom: lineStyle)
                let font = UIFont.systemFont(ofSize: 10)
               
                let font2 = UIFont.boldSystemFont(ofSize: 15)
                let style = PDFTableCellStyle(colors: colors, font: font)
           
                
                tableOfUserData[0,0].style = PDFTableCellStyle(colors: (fill: UIColor(hexString: colourStyle), text: UIColor.white),borders: borders, font: font2)
                tableOfUserData[0,1].style = PDFTableCellStyle(colors: (fill: UIColor(hexString: colourStyle), text: UIColor.white),borders: borders, font: font2)
                tableOfUserData[0,2].style = PDFTableCellStyle(colors: (fill: UIColor(hexString: colourStyle), text: UIColor.white),borders: borders, font: font2)
           
                
                //Middle column configuration:
                let font3 = UIFont.boldSystemFont(ofSize: 10)
                let lineStyle3 = PDFLineStyle(type: .full, color: UIColor.black, width: 1)
                let borders3 = PDFTableCellBorders(left:lineStyle3, right: lineStyle3, bottom: lineStyle3)
                
                tableOfUserData[1,1].style = PDFTableCellStyle(colors: (fill: UIColor.white, text: UIColor.black), borders: borders3, font: font3)
                tableOfUserData[2,1].style = PDFTableCellStyle(colors: (fill: UIColor.white, text: UIColor.black), borders: borders3, font: font3)
                tableOfUserData[3,1].style = PDFTableCellStyle(colors: (fill: UIColor.white, text: UIColor.black), borders: borders3, font: font3)
                tableOfUserData[4,1].style = PDFTableCellStyle(colors: (fill: UIColor.white, text: UIColor.black), borders: borders3, font: font3)
                tableOfUserData[5,1].style = PDFTableCellStyle(colors: (fill: UIColor.white, text: UIColor.black), borders: borders3, font: font3)
        
                tableOfUserData[1,2].style = PDFTableCellStyle(colors: (fill: UIColor.white, text: UIColor.black), borders: borders3, font: font3)
                tableOfUserData[2,2].style = PDFTableCellStyle(colors: (fill: UIColor.white, text: UIColor.black), borders: borders3, font: font3)
                tableOfUserData[3,2].style = PDFTableCellStyle(colors: (fill: UIColor.white, text: UIColor.black), borders: borders3, font: font3)
                tableOfUserData[4,2].style = PDFTableCellStyle(colors: (fill: UIColor.white, text: UIColor.black), borders: borders3, font: font3)
                tableOfUserData[5,2].style = PDFTableCellStyle(colors: (fill: UIColor.white, text: UIColor.black), borders: borders3, font: font3)
           
                
                //Observation column configuration
                tableOfUserData[5,0].style = PDFTableCellStyle(colors: (fill: UIColor(hexString: colourStyle), text: UIColor.white),borders: borders, font: font2)
                tableOfUserData[5 + 1,0].style = PDFTableCellStyle(colors: (fill: UIColor.white, text: UIColor.black), borders: borders3, font: font3)
                
               
                
                
                let lineStyle_user = PDFLineStyle(type: .full, color: UIColor.white, width: 1)
                let borders_user = PDFTableCellBorders(left: lineStyle_user, top: lineStyle_user, right: lineStyle_user, bottom: lineStyle_user)
      
       
                tableOfUserData.style = PDFTableStyle(rowHeaderStyle:style,footerStyle: style,contentStyle: style, alternatingContentStyle: style)

     
 
                tableOfUserData.content = [
                    ["Snapshot", "Item",       nil, "Details"],
                    [nil, "  Audit Title:",      nil, "  \(x.title)"],
                    [nil, "  Date:",           nil, "  \(x.date)"],
                    [nil, "  Coordinates:",    nil, "  \(x.lat), \(x.long)"],
                    [nil, "  Reporter:",       nil, "  \(x.userUploaded)"],
                    [ x.imageData, " Observation:",     nil, "  \(x.body)"],
                    [nil, nil,        nil, nil],
   
                    
                ]
                tableOfUserData.rows.allRowsAlignment = [.topLeft, .topLeft,.topLeft]
                tableOfUserData[0,0].alignment = .center
                tableOfUserData[0,1].alignment = .center
                tableOfUserData[0,2].alignment = .center
                tableOfUserData[0,3].alignment = .center
            
                tableOfUserData[6,0].alignment = .left
                
               
     


                
                // The widths of each column is proportional to the total width, set by a value between 0.0 and 1.0, representing percentage.
                
                tableOfUserData.widths = [
                    0.3, 0.2, 0.1, 0.4
                ]
                
                document.add(table: tableOfUserData)

                // Add custom pagination, starting at page 1 and excluding page 3
                document.pagination = PDFPagination(container: .footerLeft, style: PDFPaginationStyle.customClosure { (page, total) -> String in
                    return "page \(page) of \(total)"
                }, range: (1, 10000), hiddenPages: [0, 0], textAttributes: [
                    .font: Font.boldSystemFont(ofSize: 12),
                    .foregroundColor: Color.black
                ])
    
                
                //document.createNewPage()
                
            }
            
            
            
            
            
            //Export the file
            
            let filename = "AllRoads_Doc.pdf"
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
            
            
            
            
        break
            
            
            
            
            
            
            
            
        default:
            //default settings here, we can ingore
            break
            
        }
  
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
                            
                            asyncData(imageURL: x.imageURL, descriptionData: x.auditDescription, auditTitleData: x.auditTitle, dateData: x.date, lat: "\(x.lat)",long: "\(x.long)",userUploaded:x.userUploaded) { result in do { group.leave()}
                            
                            print(result)
                                
                            }

                        }

                        
                        group.notify(queue: DispatchQueue.main){
                            print("All tasks completed")
                            
                            //once all tasks are completed, and data is loaded. Create the PDF. Once all observation images are downloaded, we need to download the company logo. When this is done, we can then create the PDF.
                        
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



    
    
    func asyncData(imageURL:String, descriptionData: String, auditTitleData:String, dateData:String,lat:String,long:String,userUploaded:String, completion: @escaping (String) -> Void) {
          
 
        
        
          DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
              
              let url = URL(string:"\(imageURL)")
              let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
                  
                  let image: UIImage = UIImage(data: data!)!
                  self.imageData = image
                  let pdfCreator = PDFCreatorData(title: auditTitleData, description: descriptionData, imageData: self.imageData, image: "", date: dateData, lat: lat, long: long, userUploaded: userUploaded)
                  
                  self.saveData.append(pdfCreator)
                  
                  print(image)
                  completion("done")
                  
              }
              task.resume()

          }
      }
    
    
    
}
