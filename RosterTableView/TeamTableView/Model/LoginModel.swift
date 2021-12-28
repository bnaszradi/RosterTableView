//
//  LoginModel.swift
//  RosterTableView
//
//  Created by Brian Naszradi on 9/12/21.
//

import Foundation
import CloudKit

class LoginModel  {
    
    let container = CloudKit.CKContainer(identifier: "ICloud.Brian-Naszradi.RosterTableView")
    
   // func pwdTeamCheck(team: String, password: String) (-> Array<String>) {
    
   // typealias CompletionHandler = (Array<Any>) -> Void
    
   // typealias PasswordArray = (Array<String>)
    
   
   // func pwdTeamCheck(team: String, password: String, completionHandler: CompletionHandler) {

    func pwdTeamPwdCheck(team: String, password: String, completion: @escaping (_ result: Array<String>)->Void)  {
    
      //  var CompletionHandler = ((Array<Any>) -> Void).self
        
       // var passwordArray = [] as Array
        
       var passwordArray: Array<String> = []
        
          print("team in LoginCheck: ", team)
        print("password in LoginCheck: ", password)
       
            
          //  let teamPwdPredicate = NSPredicate(format: "teamName == %@ AND password == %@", team, password)
        let teamPwdPredicate = NSPredicate(format: "teamName == %@ AND password == %@", team, password)
        
      //  let teamPwdPredicate = NSPredicate(format: "teamName == %@", team)
        
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
            
            print("passwordArray in FetchedBlock: ", passwordArray)
                
                 }  //recordFetchedBlock
               
        
        qOperation.queryCompletionBlock = { cursor, error in
            
          //  DispatchQueue.main.async {
                
            print("passwordArray in CompletionBlock: ", passwordArray)
             
            let queryCount = passwordArray.count
           
            print("Number rows in array in queryCompletionBlock: ", queryCount)
         
           // PasswordArray = passwordArray
            
           // completion(LoginModel.PasswordArray.self)
           
                
            completion(passwordArray)
            
          //  } // DispatchQueue
            
        } // qOperttion queryCompletionBlock
        
        
        CKContainer.default().publicCloudDatabase.add(qOperation)
        
       
    }  // pwdTeamCheck


    
    func pwdTeamCheck(team: String, password: String, completion: @escaping (_ result: Array<String>)->Void)  {
    
      //  var CompletionHandler = ((Array<Any>) -> Void).self
        
       // var passwordArray = [] as Array
        
       var passwordArray: Array<String> = []
        
          print("team in LoginCheck: ", team)
        print("password in LoginCheck: ", password)
       
            
          //  let teamPwdPredicate = NSPredicate(format: "teamName == %@ AND password == %@", team, password)
       // let teamPwdPredicate = NSPredicate(format: "teamName == %@ AND password == %@", team, password)
        
        let teamPwdPredicate = NSPredicate(format: "teamName == %@", team)
        
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
            
            print("passwordArray in FetchedBlock: ", passwordArray)
                
                 }  //recordFetchedBlock
               
        
        qOperation.queryCompletionBlock = { cursor, error in
            
          //  DispatchQueue.main.async {
                
            print("passwordArray in CompletionBlock: ", passwordArray)
             
            let queryCount = passwordArray.count
           
            print("Number rows in array in queryCompletionBlock: ", queryCount)
         
           // PasswordArray = passwordArray
            
           // completion(LoginModel.PasswordArray.self)
           
                
            completion(passwordArray)
            
          //  } // DispatchQueue
            
        } // qOperttion queryCompletionBlock
        
        
        CKContainer.default().publicCloudDatabase.add(qOperation)
        
    
    }  // pwdTeamCheck

    
    

} //LoginCheck class

