//
//  PlayerTeamData.swift
//  RosterTableView
//
//  Created by Brian Naszradi on 2/28/21.
//

import Foundation
import CloudKit


class PlayerTeamData {

    let container = CloudKit.CKContainer(identifier: "ICloud.Brian-Naszradi.RosterTableView")
    
   
    func queryPlayer(pName: String, team: String) -> CKRecord   {
    
        
          print("pName in PlayerTeamData: ", pName)
        print("team in PlayerTeamData: ", team)
        
         
        var results = CKRecord(recordType: "team")
    
        
       let playerPredicate = NSPredicate(format: "player == %@ AND teamName == %@", pName, team)
        
      //  let playerPredicate = NSPredicate(format: "teamName == %@", team)
        
        
        let query = CKQuery(recordType: "team", predicate: playerPredicate)
        
         
        let queryOp = CKQueryOperation(query: query)
        
        
            
        //qOperation.resultsLimit = 25
        queryOp.resultsLimit = 25
       
 
        
        // This is non-structure data fetch
       //  queryOp.recordFetchedBlock = { record in
        
        queryOp.recordFetchedBlock = { (record : CKRecord) in
              
          //  DispatchQueue.main.async {
              
               // let id = record.recordID
           // let results = record.value(forKey: "player")
            let recordResults = record
            results = recordResults
            
        
            print("results in FetchedBlock: ", results)
            
            print("recordID for results in FetchedBlock: ", results.recordID)
            
          //  }  // DispatchQueue
             
             
                 }  //recordFetchedBlock
        
      
   // CKContainer.default().publicCloudDatabase.add(qOperation)
        CKContainer.default().publicCloudDatabase.add(queryOp)
    
    
      //  qOperation.queryCompletionBlock = { cursor, error in
        queryOp.queryCompletionBlock = { cursor, error in
            
         
        } // qOperttion queryCompletionBlock
    
   
    
   // if playerArray.isEmpty  {
       
        var counter: Int = 0
        while counter <= 700000000 {
            counter += 1
        } // while loop
       
        print("Counter: ", counter)
        
        print("results before return: ", results)
        
        return results
   
 } // queryPlayer
  
    
 }  // PlayerTeamData class
