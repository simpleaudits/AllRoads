//
//  buildReport.swift
//  RSAC
//
//  Created by John on 1/6/2024.
//

import UIKit
import SwiftLoader
import Firebase

struct reportDataLoad{
    
    
    let reportConfig:String

    let q1:String
    let q2:String
    let q3:String
    let q4:String
    let q5:String
    let q6:String
    let q7:String
    let q8:String
    let q9:String
    let q10:String
    let q11:String
    let q12:String
    let q13:String
    let q14:String
    let q15:String
    let q16:String
    let q17:String
    let q18:String
    let q19:String
    let q20:String
    let q21:String
    let q22:String
    let q23:String
    let q24:String
    let q25:String
    let q26:String
    let q27:String
    let q28:String
    let q29:String
    let q30:String
    let q31:String
    let q32:String
    let q33:String
    let q34:String
    let q35:String
    

    
    
    
    init(
        reportConfig: String,
        q1: String,
        q2:String,
        q3:String,
        q4:String,
        q5:String,
        q6:String,
        q7:String,
        q8:String,
        q9:String,
        q10:String,
        q11:String,
        q12:String,
        q13:String,
        q14:String,
        q15:String,
        q16:String,
        q17:String,
        q18:String,
        q19:String,
        q20:String,
        q21:String,
        q22:String,
        q23:String,
        q24:String,
        q25:String,
        q26:String,
        q27:String,
        q28:String,
        q29:String,
        q30:String,
        q31:String,
        q32:String,
        q33:String,
        q34:String,
        q35:String
    )
    
    
    {
        self.reportConfig=reportConfig
        self.q1=q1
        self.q2=q2
        self.q3=q3
        self.q4=q4
        self.q5=q5
        self.q6=q6
        self.q7=q7
        self.q8=q8
        self.q9=q9
        self.q10=q10
        self.q11=q11
        self.q12=q12
        self.q13=q13
        self.q14=q14
        self.q15=q15
        self.q16=q16
        self.q17=q17
        self.q18=q18
        self.q19=q19
        self.q20=q20
        self.q21=q21
        self.q22=q22
        self.q23=q23
        self.q24=q24
        self.q25=q25
        self.q26=q26
        self.q27=q27
        self.q28=q28
        self.q29=q29
        self.q30=q30
        self.q31=q31
        self.q32=q32
        self.q33=q33
        self.q34=q34
        self.q35=q35
        
    }
    func saveReportDataConfig() -> [String:Any] {
        return [
            "reportConfig":reportConfig,
            "q1":q1,
            "q2":q2,
            "q3":q3,
            "q4":q4,
            "q5":q5,
            "q6":q6,
            "q7":q7,
            "q8":q8,
            "q9":q9,
            "q10":q10,
            "q11":q11,
            "q12":q12,
            "q13":q13,
            "q14":q14,
            "q15":q15,
            "q16":q16,
            "q17":q17,
            "q18":q18,
            "q19":q19,
            "q20":q20,
            "q21":q21,
            "q22":q22,
            "q23":q23,
            "q24":q24,
            "q25":q25,
            "q26":q26,
            "q27":q27,
            "q28":q28,
            "q29":q29,
            "q30":q30,
            "q31":q31,
            "q32":q32,
            "q33":q33,
            "q34":q34,
            "q35":q35
           
        ]
    }
}

class buildReport: UITableViewController {
    var reportData = [String: Any]()
    //Reference to site and audit ID
    var auditID = String()
    var siteID = String()
    var userUID = String()
  
  

    var questionIndex_key  = String()
    var questionIndex_value  = String()
    var item_value_reportData = String()
    
    let mainConsole = CONSOLE()
    var questionListSection = ["General Details",
                               "To be completed by the Client / Design Team","Client / Design Team Contact Details",
                               "Previous Road Safety Audits Undertaken",
                               "Safe System Assessments Undertaken",
                               "Project Information",
                               "To be Completed by Road Safety Audit Team"]
    
    
    
    
    var questionsListSection1 =
                        ["Audit Team Contact Name":"q1", //added
                         "Audit Team Organisation":"q2", //added
                         "Audit Team Organisation Contact Details":"q3", //added
                         "Your company name":"q5"] //added
    var questionsListSection2 =
                         ["Road Safety Audit Stage":"q6", //added
                         "Project Location":"q7", //added
                         "Project Description":"q8", //added
                         "Project Number / Task Number":"q9"] //added
    var questionsListSection3 =
                         ["Organisation / Department":"q10", //added
                         "Contact Name":"q11", //added
                         "Contact Tel. No.":"q12", //added
                         "Email Address":"q13", //added
                         "Date the Final Audit is Required":"q14"] //added
    var questionsListSection4 =
                         ["Previous Road Safety Audit":"q15", //added
                         "Previous Road Safety Audit Stage":"q16", //added
                         "Previous Audit Date":"q17", //added
                         "Previous Audit Organisation":"q18",//added
                         "Previous Audit Team Leader":"q19", //added
                         "Copy of Audit and CAR Provided":"q20"] //added
    var questionsListSection5 =
                         ["Safe System Assessments":"q21", //added
                         "Assessment Date":"q22", //added
                         "Assessment Organisation":"q23", //added
                         "Copy of Assessment Provided":"q24"] //added
    var questionsListSection6 =
                         ["Project Objective":"q25", //added
                         "Speed Limit / Design Speed":"q26",
                         "Standards, Departures from Standards and Mitigation":"q27",
                         "Existing Traffic Flows":"q28",
                         "Forecast Traffic Flows":"q29",
                         "Crash Data (5 Years)":"q30",
                         "Speed Survey Data":"q31",
                         "Audit Requested By":"q32",]
    var questionsListSection7 =
                         ["Date Request Received":"q33",
                         "Audit Reference Number":"q34",
                         "Audit Team Leader":"q35"]
  
    //test
    
    
    
    // MARK: - load function
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        //create report
        //1) initiate
        

        
    }

    
    

    // MARK: - section heading title
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section{
        case 0:
            return "General Details"
        case 1:
            return  "To be completed by the Client / Design Team"
        case 2:
            return "Client / Design Team Contact Details"
        case 3:
            return "Previous Road Safety Audits Undertaken"
        case 4:
            return "Safe System Assessments Undertaken"
        case 5:
            return  "Project Information"
        default:
            return "To be Completed by Road Safety Audit Team"
       
        }
    }
    


    // MARK: - rows in section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section{
        case 0:
            return questionsListSection1.count
        case 1:
            return questionsListSection2.count
        case 2:
            return questionsListSection3.count
        case 3:
            return questionsListSection4.count
        case 4:
            return questionsListSection5.count
        case 5:
            return questionsListSection6.count
        default:
            return questionsListSection7.count
       
        }
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        questionListSection.count
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        switch indexPath.section{
        case 0:
            let item_k = Array(questionsListSection1.keys)
            let item_v = Array(questionsListSection1.values)
            cell.textLabel?.text = item_k[indexPath.row]
            cell.detailTextLabel?.text = "\(reportData[item_v[indexPath.row]] ?? "⚠️")"
        case 1:
            let item = Array(questionsListSection2.keys)
            cell.textLabel?.text = item[indexPath.row]
            cell.detailTextLabel?.text = "☑️"
        case 2:
            let item = Array(questionsListSection3.keys)
            cell.textLabel?.text = item[indexPath.row]
            cell.detailTextLabel?.text = "✅"
        case 3:
            let item = Array(questionsListSection4.keys)
            cell.textLabel?.text = item[indexPath.row]
            cell.detailTextLabel?.text = "❌"
        case 4:
            let item = Array(questionsListSection5.keys)
            cell.textLabel?.text = item[indexPath.row]
            cell.detailTextLabel?.text = "☑️"
        case 5:
            let item = Array(questionsListSection6.keys)
            cell.textLabel?.text = item[indexPath.row]
            cell.detailTextLabel?.text = "☑️"
        default:
            let item = Array(questionsListSection7.keys)
            cell.textLabel?.text = item[indexPath.row]
            cell.detailTextLabel?.text = "☑️"
       
        }
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let indexQuestionsList = questionsList[indexPath.row]
//     
//        
//        questionIndex = (indexQuestionsList as? String)!
        //self.delegate?.finishPassing_category(saveCategory: indexCategory)
    
        
        
        switch indexPath.section{
        case 0:
            
            
            let item_key = Array(questionsListSection1.keys)[indexPath.row]
            let item_value = Array(questionsListSection1.values)[indexPath.row]
            
            
            //pass data
            let item_value_reportData = (reportData[item_value] ?? "⚠️")

            

            questionIndex_key = item_key
            questionIndex_value = item_value
            
            
            self.item_value_reportData = item_value_reportData as! String

        
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            self.performSegue(withIdentifier: "reportContent", sender: nil)
 
            })
         case 1:
            
            let item_key = Array(questionsListSection2.keys)[indexPath.row]
            let item_value = Array(questionsListSection2.values)[indexPath.row]
            
            
            //pass data
            let item_value_reportData = (reportData[item_value] ?? "⚠️")

            

            questionIndex_key = item_key
            questionIndex_value = item_value
            
            
            self.item_value_reportData = item_value_reportData as! String

        
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            self.performSegue(withIdentifier: "reportContent", sender: nil)
 
            })
      
        case 2:
            
            
            let item_key = Array(questionsListSection3.keys)[indexPath.row]
            let item_value = Array(questionsListSection3.values)[indexPath.row]
            
            
            //pass data
            let item_value_reportData = (reportData[item_value] ?? "⚠️")

            

            questionIndex_key = item_key
            questionIndex_value = item_value
            
            
            self.item_value_reportData = item_value_reportData as! String

        
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            self.performSegue(withIdentifier: "reportContent", sender: nil)
 
            })
            
            
            
            
            
            
           
        case 3:
            let item_key = Array(questionsListSection4.keys)[indexPath.row]
            let item_value = Array(questionsListSection4.values)[indexPath.row]
            
            
            //pass data
            let item_value_reportData = (reportData[item_value] ?? "⚠️")

            

            questionIndex_key = item_key
            questionIndex_value = item_value
            
            
            self.item_value_reportData = item_value_reportData as! String

        
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            self.performSegue(withIdentifier: "reportContent", sender: nil)
 
            })
            
            
            

       case 4:
            
            let item_key = Array(questionsListSection5.keys)[indexPath.row]
            let item_value = Array(questionsListSection5.values)[indexPath.row]
            
            
            //pass data
            let item_value_reportData = (reportData[item_value] ?? "⚠️")

            

            questionIndex_key = item_key
            questionIndex_value = item_value
            
            
            self.item_value_reportData = item_value_reportData as! String

        
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            self.performSegue(withIdentifier: "reportContent", sender: nil)
 
            })
            
        case 5:
            let item_key = Array(questionsListSection6.keys)[indexPath.row]
            let item_value = Array(questionsListSection6.values)[indexPath.row]
            
            
            //pass data
            let item_value_reportData = (reportData[item_value] ?? "⚠️")

            

            questionIndex_key = item_key
            questionIndex_value = item_value
            
            
            self.item_value_reportData = item_value_reportData as! String

        
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            self.performSegue(withIdentifier: "reportContent", sender: nil)
 
            })
            
            
        default:
            
            let item_key = Array(questionsListSection7.keys)[indexPath.row]
            let item_value = Array(questionsListSection7.values)[indexPath.row]
            
            
            //pass data
            let item_value_reportData = (reportData[item_value] ?? "⚠️")

            

            questionIndex_key = item_key
            questionIndex_value = item_value
            
            
            self.item_value_reportData = item_value_reportData as! String

        
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            self.performSegue(withIdentifier: "reportContent", sender: nil)
 
            })
       
        }
        
 
        
    }
    
    
    
    func loadData(){

        SwiftLoader.show(title: "Loading", animated: true)
        
        let uid = Auth.auth().currentUser?.uid
        let reftest = Database.database().reference()
            .child("\(mainConsole.prod!)")
            .child("\(mainConsole.post!)")
            .child(uid!)
            .child("\(mainConsole.audit!)")
            .child("\(auditID)")
            .child("\(mainConsole.siteList!)")
            .child("\(siteID)")
            .child("\(mainConsole.reportContent!)")
        
        reftest.queryOrderedByKey()
            .observe( .value, with: { snapshot in

                let data = reportContentsdataModel(snapshot: snapshot)
                var reportDataLoad = reportDataLoad(reportConfig: data!.reportConfig,
                               q1: data!.q1,
                               q2: data!.q2,
                               q3: data!.q3,
                               q4: data!.q4,
                               q5: data!.q5,
                               q6: data!.q6,
                               q7: data!.q7,
                               q8: data!.q8,
                               q9: data!.q9,
                               q10: data!.q10,
                               q11: data!.q11,
                               q12: data!.q12,
                               q13: data!.q13,
                               q14: data!.q14,
                               q15: data!.q15,
                               q16: data!.q16,
                               q17: data!.q17,
                               q18: data!.q8,
                               q19: data!.q19,
                               q20: data!.q20,
                               q21: data!.q21,
                               q22: data!.q22,
                               q23: data!.q23,
                               q24: data!.q24,
                               q25: data!.q25,
                               q26: data!.q26,
                               q27: data!.q27,
                               q28: data!.q29,
                               q29: data!.q30,
                               q30: data!.q31,
                               q31: data!.q32,
                               q32: data!.q33,
                               q33: data!.q34,
                               q34: data!.q34,
                               q35: data!.q35).saveReportDataConfig()
                
                self.reportData = reportDataLoad
                self.tableView.reloadData()
                              
                SwiftLoader.hide()

           
            })
        
        
    }
    

    


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
             if let viewInfoView = segue.destination as? buildReportContentPage{
                 viewInfoView.questionIndex_key = questionIndex_key
                 viewInfoView.questionIndex_value = questionIndex_value
                 viewInfoView.item_value_reportData = item_value_reportData
                 
                 viewInfoView.siteID = siteID
                 viewInfoView.auditID = auditID
                 //viewInfoView.userUID = userUID
                 
             }else{
                 
             }
         }

}
