//
//  addObservation.swift
//  RSAC
//
//  Created by John on 8/9/2024.
//

import UIKit
import Foundation
import PhotosUI
import PencilKit


extension UITextView {
    func setTextWithTypeAnimation(typedText: String, characterDelay: TimeInterval = 5.0) {
        text = ""
        var writingTask: DispatchWorkItem?
        writingTask = DispatchWorkItem { [weak weakSelf = self] in
            for character in typedText {
                DispatchQueue.main.async {
                    weakSelf?.text!.append(character)
                }
                Thread.sleep(forTimeInterval: characterDelay/100)
            }
        }
        
        if let task = writingTask {
            let queue = DispatchQueue(label: "typespeed", qos: DispatchQoS.userInteractive)
            queue.asyncAfter(deadline: .now() + 0.05, execute: task)
        }
    }
    
}





extension dataCell {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "crashTypeCell", for: indexPath) as! crashTypeCell
        let data = cellItems[indexPath.row]
        
        cell.backgroundColor = #colorLiteral(red: 1, green: 0.6645795107, blue: 0.2553189099, alpha: 1)
        cell.layer.cornerRadius = 15
        cell.layer.masksToBounds = true
        cell.label.text = data
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       let string = cellItems[indexPath.item]
       
       // Create a temporary label to measure the text size
       let tempLabel = UILabel()
       tempLabel.text = (string as String)
       tempLabel.font = UIFont.systemFont(ofSize: 12) // Match the font used in the cell
       tempLabel.numberOfLines = 0
       
       // Calculate the size of the label
       let width = tempLabel.intrinsicContentSize.width + 16 // 16 is padding
       let height = tempLabel.intrinsicContentSize.height + 16 // 16 is padding
        

       
       return CGSize(width: width, height: height)
   
}
    
    
}

class dataCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {


    
    weak var textfieldViewLabel: UITextView!
    weak var siteImage: UIImageView!
 
    var collectionView: UICollectionView!
    var cellItems: [String] = [] // Replace with your model

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
          super.init(style: style, reuseIdentifier: "dataCell")
          setupCollectionView()
        
        
        let siteImage = UIImageView(frame: .zero)
        siteImage.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(siteImage)
        NSLayoutConstraint.activate([
            siteImage.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            siteImage.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            siteImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            siteImage.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            ])
        self.siteImage = siteImage
        self.siteImage.contentMode = .scaleToFill
        self.siteImage.layer.borderWidth = 2
        
        let textfieldViewLabel = UITextView(frame: .zero)
        textfieldViewLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(textfieldViewLabel)
        NSLayoutConstraint.activate([
            textfieldViewLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5),
            textfieldViewLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            textfieldViewLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            textfieldViewLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            ])
        self.textfieldViewLabel = textfieldViewLabel
        
        //self.textLabel.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        //self.textLabel.layer.borderWidth = 0.5
        self.textfieldViewLabel.textAlignment = .left
        self.textfieldViewLabel.font = UIFont.systemFont(ofSize: 15)
        self.textfieldViewLabel.backgroundColor = .clear
        self.textfieldViewLabel.layer.masksToBounds = true
        self.textfieldViewLabel.layer.cornerRadius = 8
      }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCollectionView() {
           let layout = UICollectionViewFlowLayout()
           layout.scrollDirection = .horizontal
           collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
           collectionView.translatesAutoresizingMaskIntoConstraints = false
           collectionView.backgroundColor = .white
           collectionView.delegate = self
           collectionView.dataSource = self
           
           
           // Register your cell class here
           collectionView.register(crashTypeCell.self, forCellWithReuseIdentifier: "crashTypeCell")
           
           contentView.addSubview(collectionView)

           // Constraints
           NSLayoutConstraint.activate([
               collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
               collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
               collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 5),
               collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
           ])
       }
           
        
           
           
       

}




class addObservation: UITableViewController,UIPencilInteractionDelegate, imageData, saveDescription, saveDescriptionRisk, saveDescriptionTag {



    
    var refData = String()
    
    
    let mainConsole = CONSOLE()
    
    //Reference to site and audit ID
    var auditID = String()
    var siteID = String()
    var userUID = String()
    var companyImage = UIImage()
    
    
    //image save contents:
    
    //audit data here:
    var image = UIImage()
    var selectedImage = UIImage()
    //var canvasView = PKCanvasView()
    var canvasData = PKDrawing()
    var siteDescription = String()
    var riskDataArray : [String] = []
    var tagDataArray : [String] = []
    
    let switchKey = ["Comment",
                     "Risk",
                     "Tag",
                     "History"
    ]
    var switchKeySelection = String()
    
    let headingsItem =         ["Photo",
                                "Comment",
                                "Risk",
                                "Tag",
                                "History"]
    
    
    let questionsListSection0 = ["",""]
    let questionsListSection1 = [""]
    let questionsListSection2 = [""]
    let questionsListSection3 = [""]
    let questionsListSection4 = [""]
    // this has been removed
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.register(dataCell.self, forCellReuseIdentifier: "dataCell")
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    //Passing the Risk data
    func saveRisk(text: [String]) {
        print("riskTypeTo:\(text)")
        self.riskDataArray = text
       
    }
    
    
    func saveTag(text: [String]) {
        print("TagTypeTo:\(text)")
        self.tagDataArray = text
    }
    
    
    //MARK: image edit here:
    func finishPassing_Image(saveImage: UIImage, saveCavnasView: PKDrawing, selectedImage: UIImage) {

        //merged iamge
        image = saveImage
        //canvas pallete
        canvasData = saveCavnasView
        //origionalImage
        self.selectedImage = selectedImage
        
    }
    
    func saveDescription(text: String) {
        self.siteDescription = text
        print("siteDescriptionTo:\(siteDescription)")
    }


    
  
    
    // MARK: - section heading title
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        //headerView.backgroundColor = .lightGray // Set background color if needed
        
        let headerLabel = UILabel()
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.font = UIFont.boldSystemFont(ofSize: 20) // Customize font here
        headerLabel.textColor = #colorLiteral(red: 1, green: 0.5843137255, blue: 0, alpha: 1) // Customize text color if needed
        
        headerLabel.numberOfLines = 3
        
        switch section{
            
        case 0:
            headerLabel.text =  "\(headingsItem[0])"
        case 1:
            headerLabel.text =  "\(headingsItem[1])"
        case 2:
            headerLabel.text =  "\(headingsItem[2])"
        case 3:
            headerLabel.text =  "\(headingsItem[3])"
        default:
            headerLabel.text =  "\(headingsItem[4])"
        }
        
        
        
        headerView.addSubview(headerLabel)
        
        // Set constraints for headerLabel
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            headerLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            headerLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 0),
            headerLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 0)
        ])
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        // Return different heights based on section index, or a fixed height
        
        
        switch section {
        case 0:
            return 50
        case 1:
            return 50
        case 2:
            return 50
        case 3:
            return 50
        default:
            return 50 // Default height
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                //Photo
                return 400.0 // Height for rows in section 0
            }else{
                //Add Photo
                return 50.0
            }
            
        }else if indexPath.section == 1 {
                //Comment
                return 150.0 // Height for rows in section 0
        }else if indexPath.section == 2 {
                //Risk
                return 50.0 // Height for rows in other sections
            
        }else if indexPath.section == 3 {
                //Tag
                return 50.0 // Height for rows in other sections
            
        }
        else if indexPath.section == 4 {
                //History
                return 50.0 // Height for rows in other sections
            
        }
        
        return 0
    }
    
    // MARK: - rows in section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //        switch section{
        //        case 0:
        //            return questionsListSection0.count
        //        case 1:
        //            return questionsListSection1.count
        //        case 2:
        //            return questionsListSection2.count
        //        case 3:
        //            return questionsListSection3.count
        //        default:
        //            return questionsListSection4.count
        //
        //        }
        
        if section == 0 {
            return questionsListSection0.count
        } else if section == 1 {
            return questionsListSection1.count
        }else if section == 2 {
            return questionsListSection2.count
        }else if section == 3 {
            return questionsListSection3.count
        }
        return questionsListSection4.count
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return headingsItem.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "dataCell", for: indexPath) as! dataCell
       
        
        // Reset cell for reuse
        cell.siteImage.isHidden = true
        cell.textfieldViewLabel.isHidden = true // Default hidden
        cell.textLabel?.text = "" // Clear text label
        cell.accessoryType = .disclosureIndicator
        
        // Configure based on section and row
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                // First row in the first section
                cell.siteImage.isHidden = false
                cell.siteImage.image = image // Ensure 'image' is defined
                cell.textfieldViewLabel.isHidden = true
                cell.collectionView.isHidden = true
                cell.accessoryType = .none
                
       
         
            } else if indexPath.row == 1 {
                // Second row in the first section
                cell.siteImage.isHidden = true
                cell.textfieldViewLabel.isHidden = true
                cell.textfieldViewLabel.isEditable = false
                cell.collectionView.isHidden = true
                cell.textLabel?.text = "Add Photo 📷"
            }
        } else if indexPath.section == 1 {
            // First row in the second section
            if indexPath.row == 0 {
                cell.siteImage.isHidden = true
                cell.textfieldViewLabel.isHidden = false
                cell.textfieldViewLabel.isEditable = false
                cell.collectionView.isHidden = true
                cell.textfieldViewLabel.setTextWithTypeAnimation(typedText: "\n\(siteDescription)", characterDelay:  1)
                //cell.textfieldViewLabel.text = "\(siteDescription)"
                cell.textLabel?.text = "" // Clear text label
                
            }
        } else if indexPath.section == 2 {
            // First row in the third section
            if indexPath.row == 0 {
                
                cell.siteImage.isHidden = true
                cell.textfieldViewLabel.isEditable = false
                cell.textfieldViewLabel.isHidden = true
                cell.collectionView.isHidden = false
                cell.textfieldViewLabel.text = "risk"
                cell.textLabel?.text = "" // Clear text label
                cell.cellItems = riskDataArray
                cell.collectionView.reloadData()
                
                return cell
                
           
                
                
            }
        } else if indexPath.section == 3 {
            // First row in the fourth section
            if indexPath.row == 0 {
                
                cell.siteImage.isHidden = true
                cell.textfieldViewLabel.isEditable = false
                cell.textfieldViewLabel.isHidden = true
                cell.collectionView.isHidden = false
                cell.textfieldViewLabel.text = "tag"
                cell.textLabel?.text = "" // Clear text label
                cell.cellItems = tagDataArray
                cell.layer.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
                
        
                cell.collectionView.reloadData()
               
            }
        }
        else if indexPath.section == 4 {
            // First row in the fourth section
            if indexPath.row == 0 {
                cell.siteImage.isHidden = true
                cell.textfieldViewLabel.isEditable = false
                cell.textfieldViewLabel.isHidden = false
                cell.textfieldViewLabel.text = "history"
                cell.collectionView.isHidden = true
                cell.textLabel?.text = "" // Clear text label
            }
        }
        return cell
    }

    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        
        switch indexPath.section{
            
        case 0:
            if indexPath.row == 0 {
                print("")
            }else{
                self.performSegue(withIdentifier: "editImage", sender: self)
            }
        
            
        case 1:
            print("Comment Selected")
       
            switchKeySelection = switchKey[0]
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                self.performSegue(withIdentifier: "addDescription", sender: self)
 
            })

          
        case 2:
            print("Risk Selected")
     
            switchKeySelection = switchKey[1]
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                self.performSegue(withIdentifier: "addDescription", sender: self)
 
            })
        
            
       
        case 3:
            print("Tag Selected")
    
            switchKeySelection = switchKey[2]
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                self.performSegue(withIdentifier: "addDescription", sender: self)
 
            })
      
        default:
            print("History Selected")
          
            switchKeySelection = switchKey[3]
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                self.performSegue(withIdentifier: "addDescription", sender: self)
 
            })
       
       
        }
        
    }
 

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
             if let viewInfoView = segue.destination as? buildReportContentPage{
     
                 viewInfoView.siteID = siteID
                 viewInfoView.auditID = auditID
                 //viewInfoView.userUID = userUID
                 
             }else if let destination6 = segue.destination as? editImage {
                 
                 destination6.delegate = self
                 destination6.canvasData = canvasData
                 destination6.selectedImage = selectedImage
    
                
             }else if let destination3 = segue.destination as? addSiteDetails {
                 
                 destination3.delegate1 = self
                 destination3.delegate2 = self
                 destination3.delegate3 = self
           
                 
        
                 
                 
                 destination3.switchKey = switchKeySelection
                                  
                 switch switchKeySelection {
                     
                     case "Comment":
                     destination3.stringData = siteDescription
                     destination3.value_DataArray = riskDataArray
                         
                     case "Risk":
                     destination3.stringData = siteDescription
                     destination3.value_DataArray = riskDataArray
                  
                         
                     case "Tag":
                     destination3.stringData = siteDescription
                     destination3.value_DataArray = tagDataArray
                        
                         
                     case "history":
                     print("")
                         
                  
                         
                     default:
                         
                 break
                 }
       

            }
        
        
             else{
                 
             }
         }
    
}
