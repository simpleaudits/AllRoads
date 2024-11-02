//
//  countofUsers.swift
//  dbtestswift
//
//  Created by macbook on 16/3/19.
//  Copyright © 2019 macbook. All rights reserved.
//


import Foundation
import Firebase

struct reportContentsdataModel{
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
    let q36:String
    let q37:String
    
    let q38:String
    let q39:String
    let q40:String

    
    let q1000:String
    let q1001:String
    
    
    
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
        q35:String,
        q36:String,
        q37:String,
        
        q38:String,
        q39:String,
        q40:String,
        
        q1000:String,
        q1001:String
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
        self.q36=q36
        self.q37=q37
        
        self.q38=q38
        self.q39=q39
        self.q40=q40
        
        self.q1000=q1000
        self.q1001=q1001

        
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
                let reportConfig  = value["reportConfig"]as?String,
                let q1  = value["q1"]as?String,
                let q2 = value["q2"]as?String,
                let q3 = value["q3"]as?String,
                let q4 = value["q4"]as?String,
                let q5 = value["q5"]as?String,
                let q6 = value["q6"]as?String,
                let q7 = value["q7"]as?String,
                let q8 = value["q8"]as?String,
                let q9 = value["q9"]as?String,
                let q10 = value["q10"]as?String,
                let q11 = value["q11"]as?String,
                let q12 = value["q12"]as?String,
                let q13 = value["q13"]as?String,
                let q14 = value["q14"]as?String,
                let q15 = value["q15"]as?String,
                let q16 = value["q16"]as?String,
                let q17 = value["q17"]as?String,
                let q18 = value["q18"]as?String,
                let q19 = value["q19"]as?String,
                let q20 = value["q20"]as?String,
                let q21 = value["q21"]as?String,
                let q22 = value["q22"]as?String,
                let q23 = value["q23"]as?String,
                let q24 = value["q24"]as?String,
                let q25 = value["q25"]as?String,
                let q26 = value["q26"]as?String,
                let q27 = value["q27"]as?String,
                let q28 = value["q28"]as?String,
                let q29 = value["q29"]as?String,
                let q30 = value["q30"]as?String,
                let q31 = value["q31"]as?String,
                let q32 = value["q32"]as?String,
                let q33 = value["q33"]as?String,
                let q34 = value["q34"]as?String,
                let q35 = value["q35"]as?String,
                let q36 = value["q36"]as?String,
                let q37 = value["q37"]as?String,
                let q38 = value["q38"]as?String,
                let q39 = value["q39"]as?String,
                let q40 = value["q40"]as?String,
            
                let q1000 = value["q1000"]as?String,
                let q1001 = value["q1001"]as?String
           
        else {
                return nil
        }
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
        self.q36=q36
        self.q37=q37
        
        self.q38=q38
        self.q39=q39
        self.q40=q40
        
        self.q1000=q1000
        self.q1001=q1001
      
    }
    
    func saveReportConfig() -> [String:Any] {
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
            "q35":q35,
            "q36":q36,
            "q37":q37,
            
            "q38":q38,
            "q39":q39,
            "q40":q40,
            
            "q1000":q1000,
            "q1001":q1001
           
        ]
    }
}
