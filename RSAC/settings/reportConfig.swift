//
//  reportConfig.swift
//  RSAC
//
//  Created by John on 21/4/2024.
//

import UIKit
import Firebase

extension UIColor {

    // MARK: - Initialization

    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0

        let length = hexSanitized.count

        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }

        if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0

        } else if length == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0

        } else {
            return nil
        }

        self.init(red: r, green: g, blue: b, alpha: a)
    }

    // MARK: - Computed Properties

    var toHex: String? {
        return toHex()
    }

    // MARK: - From UIColor to String

    func toHex(alpha: Bool = false) -> String? {
        guard let components = cgColor.components, components.count >= 3 else {
            return nil
        }

        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])
        var a = Float(1.0)

        if components.count >= 4 {
            a = Float(components[3])
        }

        if alpha {
            return String(format: "%02lX%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255), lroundf(a * 255))
        } else {
            return String(format: "%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
        }
    }
}




class reportConfig: UITableViewController {
    
    //variables here:
    var colourStyle: String? = "#FFA500" //default
    var pdfStyle: String? = "1" //default
    
    //objects here
    let mainConsole = CONSOLE()
    let saveDataPDFStyle = saveLocal()
    
    
    //images here
    @IBOutlet weak var largePDF: UIImageView!
    @IBOutlet weak var mediumPDF: UIImageView!
    @IBOutlet weak var smallPDF: UIImageView!
    
    
    //segment controller
    @IBOutlet weak var segmentControllerOutlet: UISegmentedControl!
    
    
    
    
    //colourpicker
    @IBOutlet weak var colourChoice: UILabel!
    @IBOutlet weak var colorWell: UIColorWell!
    
    
    @IBAction func PDFselection(_ sender: Any) {
        
        let uid = Auth.auth().currentUser?.uid
        
        let ref = "\(self.mainConsole.prod!)/\(self.mainConsole.post!)/\(uid!)/\(self.mainConsole.reportConfig!)"
       
        
                switch segmentControllerOutlet.selectedSegmentIndex {

                    case 0:
                    print("large")
                    self.saveDataPDFStyle.updateReportStyle(pdfStyle:"0", ref:"\(ref)")
       
                    
                    break
                    
                    case 1:
                    print("medium")
                    self.saveDataPDFStyle.updateReportStyle(pdfStyle:"1", ref:"\(ref)")
       
                    
                    break
                    
                    case 2:
                    print("small")
                    self.saveDataPDFStyle.updateReportStyle(pdfStyle:"2", ref:"\(ref)")
       
                    
                    break
                    
                    
                    default:
                    break

                    }
            
    }
    
    func changeColourPreference(hex:String){
        let uid = Auth.auth().currentUser?.uid
        let ref = "\(self.mainConsole.prod!)/\(self.mainConsole.post!)/\(uid!)/\(self.mainConsole.reportConfig!)"
        self.saveDataPDFStyle.updateColourPreference(colourStyle:hex, ref:"\(ref)")
       
        
    }
    
    func addColorWell() {

        colorWell.title = "Select PDF theme colour"
        colorWell.addTarget(self, action: #selector(colorWellChanged(_:)), for: .valueChanged)
    }

    @objc func colorWellChanged(_ sender: Any) {
  
        
        guard let hexValue = colorWell.selectedColor?.toHex else { return }
        print(hexValue)
        changeColourPreference(hex: hexValue)
        

    }
    
    

    override func viewDidLoad() {
        //initialize color well
        addColorWell()
        
        //load report data:
        loadUserReportSettings()
        self.largePDF.layer.borderWidth = 2
        self.mediumPDF.layer.borderWidth = 2
        self.smallPDF.layer.borderWidth = 2
        
        self.largePDF.layer.cornerRadius = 8
        self.mediumPDF.layer.cornerRadius = 8
        self.smallPDF.layer.cornerRadius = 8
       
        
        self.largePDF.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        self.mediumPDF.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        self.smallPDF.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        
        
        self.colourChoice.layer.masksToBounds = true
        self.colourChoice.layer.cornerRadius = 8

        
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - initialize report configuration data:
    
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
                                self.pdfStyle = pdfStyle!
                  

                                self.colourChoice.backgroundColor = UIColor(hex: colourStyle!)
                                self.colourChoice.text = colourStyle
                         
                         
                                 switch  self.pdfStyle{
                                 case "0":
                                     //large
                                     self.segmentControllerOutlet.selectedSegmentIndex = 0;
                      
                                     self.largePDF.layer.borderColor = #colorLiteral(red: 1, green: 0.231372549, blue: 0.1882352941, alpha: 1)
                                     self.mediumPDF.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
                                     self.smallPDF.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
                                     
                                     break
                                 case "1":
                                     //medium
                                     self.segmentControllerOutlet.selectedSegmentIndex = 1;
                                     self.largePDF.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
                                     self.mediumPDF.layer.borderColor = #colorLiteral(red: 1, green: 0.231372549, blue: 0.1882352941, alpha: 1)
                                     self.smallPDF.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
                         
                                     break
                                 case "2":
                                     //small
                                     self.segmentControllerOutlet.selectedSegmentIndex = 2;
                                     self.largePDF.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
                                     self.mediumPDF.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
                                     self.smallPDF.layer.borderColor = #colorLiteral(red: 1, green: 0.231372549, blue: 0.1882352941, alpha: 1)
                                     
                                     break
                                 default:
                                
                                     
                                     

                                     
                                     
                                     
                                     
                                     break
                                 }
                                
  
                   })
        
     
    }



}
