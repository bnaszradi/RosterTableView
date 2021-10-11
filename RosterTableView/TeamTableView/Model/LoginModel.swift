//
//  LoginModel.swift
//  RosterTableView
//
//  Created by Brian Naszradi on 9/12/21.
//

import Foundation
import CloudKit

class LoginCheck  {
    
    let container = CloudKit.CKContainer(identifier: "ICloud.Brian-Naszradi.RosterTableView")
    
    func pwdTeamCheck(team: String, password: String) -> Array<String> {

       // var passwordArray = [] as Array
        
        var passwordArray: Array<String> = []
        
          print("team in LoginCheck: ", team)
        print("password in LoginCheck: ", password)
       
            
          //  let teamPwdPredicate = NSPredicate(format: "teamName == %@ AND password == %@", team, password)
        let teamPwdPredicate = NSPredicate(format: "teamName == %@ AND password == %@", team, password)
        
           // print("teamPwdPredicate: ", teamPwdPredicate)
            
          //  let query = CKQuery(recordType: "Users", predicate: teamPwdPredicate)
        
        let query = CKQuery(recordType: "school", predicate: teamPwdPredicate)
            
            let qOperation = CKQueryOperation.init(query: query)
           
            qOperation.resultsLimit = 25
           // print("qOperation resultsLimit: ", qOperation.resultsLimit)
       
        //    qOperation.recordFetchedBlock = { record in
        
        qOperation.recordFetchedBlock = { (record : CKRecord!) in
               
                 let results = [record.value(forKey: "teamName") as! String]
                 
                passwordArray.append(contentsOf: results)
            
            print("passwordArray: ", passwordArray)
                
                 }  //recordFetchedBlock
                 
        CKContainer.default().publicCloudDatabase.add(qOperation)
        
        
            qOperation.queryCompletionBlock = { cursor, error in
                       
                
                print("passwordArray in CompletionBlock: ", passwordArray)
                 
                let queryCount = passwordArray.count
               
                print("Number rows in array in queryCompletionBlock: ", queryCount)
             
            } // qOperttion queryCompletionBlock
          
        
         print("passwordArray before loop: ", passwordArray)
        
        var counter: Int = 0
        while counter <= 700000000 {
            counter += 1
        } // while loop
        print("Counter: ", counter)
        
        print("passwordArray after loop: ", passwordArray)
        
       return passwordArray
       
    }  // pwdTeamCheck



} //LoginCheck class
