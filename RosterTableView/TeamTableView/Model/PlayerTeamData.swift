//
//  PlayerTeamData.swift
//  RosterTableView
//
//  Created by Brian Naszradi on 2/28/21.
//

import Foundation
import CloudKit


class PlayerTeamData {

    // queryPlayer func
    // queryPlayerEvent func
    

    let container = CloudKit.CKContainer(identifier: "ICloud.Brian-Naszradi.RosterTableView")
    
   
  //  func queryPlayer(pName: String, team: String) -> CKRecord   {
    func queryPlayer(pName: String, team: String, completion: @escaping (QPlayerRecord)->Void)  {
      

        print("pName in PlayerTeamData: ", pName)
        print("team in PlayerTeamData: ", team)
        
         
        var results = CKRecord(recordType: "team")
    
       let playerPredicate = NSPredicate(format: "player == %@ AND teamName == %@", pName, team)
        
        let query = CKQuery(recordType: "team", predicate: playerPredicate)
        
        let queryOp = CKQueryOperation(query: query)
        
        queryOp.resultsLimit = 25
       
 
        queryOp.recordFetchedBlock = { (record : CKRecord) in
              
          //  DispatchQueue.main.async {
              
               // let id = record.recordID
           // let results = record.value(forKey: "player")
            let recordResults = record
            
            results = recordResults
            
            print("results in PlayerTeamData.queryPlayer FetchedBlock: ", results)
            
            print("recordID for results in PlayerTeamData.queryPlayer FetchedBlock: ", results.recordID)
            
          //  }  // DispatchQueue
             
                 }  //recordFetchedBlock
        
        
        queryOp.queryCompletionBlock = { cursor, error in
            
            let qResults = QPlayerRecord(playerRecord: results)
            
            completion(qResults)
            
         
        } // qOperttion queryCompletionBlock
    

        CKContainer.default().publicCloudDatabase.add(queryOp)
    
 } // queryPlayer
  
    
  //  func queryPlayerEvent(team: String, eventName: String, eventDate: Date) -> CKRecord   {
    
    func queryPlayerEvent(team: String, eventName: String, eventDate: Date, completion: @escaping(QqueryPlayerEvent)->Void) {
        
        
        print("team in PlayerTeamData: ", team)
        print("eventName in PlayerTeamData: ", eventName)
        print("eventDate in PlayerTeamData: ", eventDate)
        
        var results = CKRecord(recordType: "events")
    
        let playerPredicate = NSPredicate(format: "team == %@ AND eventName == %@ AND eventDate == %@", team, eventName, eventDate as CVarArg)
        
        let query = CKQuery(recordType: "events", predicate: playerPredicate)
        
        let queryOp = CKQueryOperation(query: query)
        
        queryOp.resultsLimit = 25
       
 
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
        
        
        
        queryOp.queryCompletionBlock = { cursor, error in
            
            let qqueryPlayerEvent = QqueryPlayerEvent(results: results)
            
            completion(qqueryPlayerEvent)
            
            
         
        } // qOperttion queryCompletionBlock
        
        CKContainer.default().publicCloudDatabase.add(queryOp)
    
    
       
/*
   // if playerArray.isEmpty  {
       
        var counter: Int = 0
        while counter <= 700000000 {
            counter += 1
        } // while loop
       
        print("Counter: ", counter)
        
        print("results before return: ", results)
        
        return results
   
        */
        
 } // queryPlayerEvent

    

 }  // PlayerTeamData class
