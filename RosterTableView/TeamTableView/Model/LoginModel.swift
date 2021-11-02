//
//  LoginModel.swift
//  RosterTableView
//
//  Created by Brian Naszradi on 9/12/21.
//

import Foundation
import CloudKit
import UIKit

class LoginCheck  {
    
   // let container = CloudKit.CKContainer(identifier: "ICloud.Brian-Naszradi.RosterTableView")
    
    
    let container = (UIApplication.shared.delegate as! AppDelegate).container


  //  @available(iOS 15.0.0, *)
    func pwdTeamCheck(team: String, password: String)  -> Array<String> {

  //  func pwdTeamCheck(team: String, password: String) {
       // var passwordArray = [] as Array
        
        var passwordArray: Array<String> = []
        
        var completeBlock: Bool = false
        
        print("team in LoginCheck: ", team)
        print("password in LoginCheck: ", password)
       
            
        let teamPwdPredicate = NSPredicate(format: "teamName == %@ AND password == %@", team, password)
        
           // print("teamPwdPredicate: ", teamPwdPredicate)
            
         
        let query = CKQuery(recordType: "school", predicate: teamPwdPredicate)
            
        let qOperation = CKQueryOperation.init(query: query)
           
            qOperation.resultsLimit = 25
           // print("qOperation resultsLimit: ", qOperation.resultsLimit)
       
        //    qOperation.recordFetchedBlock = { record in
        qOperation.recordFetchedBlock =  { (record : CKRecord!) in
               
          //  DispatchQueue.main.async {
                
                 let results = [record.value(forKey: "teamName") as! String]
                 
                passwordArray.append(contentsOf: results)
            
            print("passwordArray in FetchedBlock: ", passwordArray)
                
          //  } // DispatchQueue
                
                 }  //recordFetchedBlock
               
    
        qOperation.queryCompletionBlock = { cursor, error in
              
          
                print("passwordArray in CompletionBlock: ", passwordArray)
             
            let queryCount = passwordArray.count
           
            print("Number rows in array in queryCompletionBlock: ", queryCount)
         
        completeBlock = true
            
        } // qOperttion queryCompletionBlock
    
        
            CKContainer.default().publicCloudDatabase.add(qOperation)
       
       
    /*
        print("passwordArray before loop: ", passwordArray)
        
        var counter: Int = 0
        while counter <= 700000000 {
            counter += 1
        } // while loop
        print("Counter: ", counter)
       */
      
        
        var counter: Int = 0
        while completeBlock == false {
            counter += 1
        } //while loop
        
       // let queryCount = passwordArray.count
       // print("passwordArray.count: ", queryCount)
        
        print("completeBlock: ", completeBlock)
        print("passwordArray before return: ", passwordArray)
      
     return passwordArray
       
    }  // pwdTeamCheck


} //LoginCheck class
