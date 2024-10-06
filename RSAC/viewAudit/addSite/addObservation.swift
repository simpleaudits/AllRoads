//
//  addObservation.swift
//  RSAC
//
//  Created by John on 8/9/2024.
//

import UIKit
import PhotosUI
import PencilKit


class dataCell: UITableViewCell {
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: "dataCell")
        

        
    contentView.addSubview(siteImage)
    contentView.addSubview(textfieldViewLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let siteImage: UIImageView = {
        let siteImage = UIImageView()
        //profile.image = UIImage(named: "frozen")
        siteImage.contentMode = .scaleAspectFit
        //siteImage.layer.cornerRadius = 10
        siteImage.backgroundColor = .red
        //profile.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        //
        //profile.layer.borderWidth = 0.5
   
        return siteImage
    }()
    
    let textfieldViewLabel: UITextView = {
        let label = UITextView()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .left
        label.isEditable = false
        //label.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    

}




class addObservation: UITableViewController,UIPencilInteractionDelegate, imageData {
    
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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    override func viewDidAppear(_ animated: Bool) {

    }
    
    //MARK: image edit here:
    func finishPassing_Image(saveImage: UIImage, saveCavnasView: PKDrawing, selectedImage: UIImage) {
        //set image to show passed image
   
        //merged iamge
            image = saveImage
        //canvas pallete
        canvasData = saveCavnasView
        //origionalImage
            self.selectedImage = selectedImage
        
            tableView.reloadData()

    }
    
    
    
    
    
    
    

    // MARK: - section heading title

    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        //headerView.backgroundColor = .lightGray // Set background color if needed
        
        let headerLabel = UILabel()
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.font = UIFont.boldSystemFont(ofSize: 20) // Customize font here
        headerLabel.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1) // Customize text color if needed
        
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
                return 250.0 // Height for rows in section 0
            }else{
                return 50.0
        }
        
        }else if indexPath.section == 1 {
            return 150.0 // Height for rows in section 0
        }else{
            return 50.0 // Height for rows in other sections
            
        }
    }

    // MARK: - rows in section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section{
        case 0:
            return questionsListSection0.count
        case 1:
            return questionsListSection1.count
        case 2:
            return questionsListSection2.count
        case 3:
            return questionsListSection3.count
        default:
            return questionsListSection4.count
       
        }
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
       return 4
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dataCell", for: indexPath) as! dataCell
        cell.accessoryType = .disclosureIndicator
        
        
        cell.textfieldViewLabel.frame = CGRect(
            x:0,
            y:0,
            width: cell.frame.width ,
            height: cell.frame.height
        )
        
        
        // photo image cell
        if indexPath.section == 0{
            
            if indexPath.row == 0 {
                cell.textfieldViewLabel.isHidden = true
                cell.accessoryType = .none
                cell.siteImage.image = image
                cell.siteImage.isHidden = false
                
                cell.siteImage.frame = CGRect(
                    x:0,
                    y:0,
                    width: cell.frame.width ,
                    height: cell.frame.height)
                
            }else{
                cell.siteImage.isHidden = true
                cell.textfieldViewLabel.isHidden = false
                cell.textfieldViewLabel.isEditable = false
                cell.textfieldViewLabel.text = "Add Photo 📷"
                cell.textfieldViewLabel.textAlignment = .center
                cell.textfieldViewLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                
            }
            
            
            // comment cell
        }else if indexPath.section == 1{
            cell.siteImage.isHidden = true
            cell.textfieldViewLabel.text = """
        your observations your observationsyour observationsyour observationsyour observationsyour observationsyour observationsyour observationsyour observationsyour observationsyour observationsyour observationsyour observationsyour observationsyour observationsyour observationsyour observationsyour observationsyour observationsyour observationsyour observationsyour observationsyour observationsyour observationsyour observationsyour observationsyour observationsyour observationsyour observationsyour observationsyour observationsyour observationsyour observationsyour observationsyour observationsyour observationsyour observationsyour observationsyour observationsyour observationsyour observationsyour observationsyour observationsyour observationsyour observationsyour observationsyour observationsyour observationsyour observationsyour observationsyour observations
        """
            
            
            // every other cell in section
        }
        else{
            cell.siteImage.isHidden = true
            cell.textfieldViewLabel.text = "11235324634 45 34 "
            
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
            print("")
          
        case 2:
            print("")
       
        case 3:
            print("")
      
        default:
            print("")
       
       
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
    
                 
                 
             }
        
        
        
             else{
                 
             }
         }
    
}
