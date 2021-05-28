//
//  TeamDataLoad.swift
//  RosterTableView
//
//  Created by Brian Naszradi on 12/27/20.
//

import Foundation
import CloudKit


class TeamDataLoad {

    let container = CloudKit.CKContainer(identifier: "ICloud.Brian-Naszradi.RosterTableView")
    
    
    

   // This searches for the team roster
   func rosterQuery(tName: String) -> Array<Any> {
    
    var resultsValueArray = [] as Array
    
      print("tName in DataLoader: ", tName)
        
        let teamPredicate = NSPredicate(format: "teamName == %@", tName)
       // print("teamPredicate: ", teamPredicate)
        
        let query = CKQuery(recordType: "team", predicate: teamPredicate)
        
        let qOperation = CKQueryOperation.init(query: query)
       
        qOperation.resultsLimit = 25
        print("qOperation resultsLimit: ", qOperation.resultsLimit)
   
    //    qOperation.recordFetchedBlock = { record in
    
    qOperation.recordFetchedBlock = { (record : CKRecord!) in
           
             let results = [record.value(forKey: "player") as! String]
             
            resultsValueArray.append(contentsOf: results)
            
            
             }  //recordFetchedBlock
             
    CKContainer.default().publicCloudDatabase.add(qOperation)
    
    
        qOperation.queryCompletionBlock = { cursor, error in
                   
            
            print("ResultsValueArray in CompletionBlock: ", resultsValueArray)
             
            let queryCount = resultsValueArray.count
           
            print("Number rows in array in queryCompletionBlock: ", queryCount)
         
        } // qOperttion queryCompletionBlock
      
    
     print("ResultsValueArray before loop: ", resultsValueArray)
    
    var counter: Int = 0
    while counter <= 700000000 {
        counter += 1
    } // while loop
    print("Counter: ", counter)
    
    print("ResultsValueArray after loop: ", resultsValueArray)
    
   return resultsValueArray
   
    
 } //rosterQuery func
  
 
    // This is the query for retrieving roster with photos
    func rosterPicQuery(tName: String) ->  (rosterArray: Array<String>, rosterPicArray: Array<CKAsset>) {
     
     var rosterArray = [] as Array<String>
     var rosterPicArray = [] as Array<CKAsset>
     
       print("tName in DataLoader: ", tName)
         
         let teamPredicate = NSPredicate(format: "teamName == %@", tName)
        // print("teamPredicate: ", teamPredicate)
         
         let query = CKQuery(recordType: "team", predicate: teamPredicate)
         
         let qOperation = CKQueryOperation.init(query: query)
        
         qOperation.resultsLimit = 25
         print("qOperation resultsLimit: ", qOperation.resultsLimit)
    
     //    qOperation.recordFetchedBlock = { record in
     
     qOperation.recordFetchedBlock = { (record : CKRecord!) in
            
        let playerResults = [record.value(forKey: "player") as! String]
        
        rosterArray.append(contentsOf: playerResults)
        
         let picResults = [record.value(forKey: "playerPhoto") as! CKAsset]
              
        rosterPicArray.append(contentsOf: picResults)
    
             
              }  //recordFetchedBlock
              
     CKContainer.default().publicCloudDatabase.add(qOperation)
     
     
         qOperation.queryCompletionBlock = { cursor, error in
                    
             
           //  print("RosterArray in CompletionBlock: ", rosterArray)
              
             let queryCount = rosterArray.count
            
             print("Number rows in array in queryCompletionBlock: ", queryCount)
          
         } // qOperttion queryCompletionBlock
       
     
      print("ResultsValueArray before loop: ", rosterArray)
     
     var counter: Int = 0
     while counter <= 700000000 {
         counter += 1
     } // while loop
     print("Counter: ", counter)
     
     print("ResultsValueArray after loop: ", rosterArray)
     
    return (rosterArray, rosterPicArray)
    
     
  } //rosterPicQuery func
    
    
    
 }  // TeamDataLoad class






