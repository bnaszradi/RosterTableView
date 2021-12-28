//
//  UpdateTeamTotals.swift
//  RosterTableView
//
//  Created by Brian Naszradi on 3/7/21.
//

import Foundation
import CloudKit
import UIKit


class UpdateTeamTotals {

    
    // queryPlayer func
    // totalsUpdate func
    
    
    let container = CloudKit.CKContainer(identifier: "ICloud.Brian-Naszradi.RosterTableView")
    
   
  //  func queryPlayer(pName: String, team: String) -> (playID: CKRecord.ID, totalAttempts: Int, totalMakes: Int )   {
    
    func queryPlayer(pName: String, team: String, completion: @escaping (QPlayer)->Void)  {
        
        //  print("pName in PlayerTeamData: ", pName)
        //  print("team in PlayerTeamData: ", team)
        
        var playID: CKRecord.ID = CKRecord.ID()
        
       // var playerName: String = ""
       // var teamName: String = ""
       // var totalPercentage: Double = 0.0
        var totalAttempts: Int = 0
        var totalMakes: Int = 0
        
         
       // let results = CKRecord(recordType: "team")
    
        let playerPredicate = NSPredicate(format: "player == %@ AND teamName == %@", pName, team)
        
        
        let query = CKQuery(recordType: "team", predicate: playerPredicate)
        
         
        let queryOp = CKQueryOperation(query: query)
        
        
            
        //qOperation.resultsLimit = 25
        queryOp.resultsLimit = 25
       
 
        
        // This is non-structure data fetch
       queryOp.recordFetchedBlock = { record in
        
      // queryOp.recordFetchedBlock = { (record : CKRecord) in
              
            let playerID = record.recordID
        
             playID = playerID
        
             print("playID in UpdateTeamTotals.queryPlayer: ", playID)
            
          //  let playResults = record.value(forKey: "player")
          //  playerName = playResults as! String
          //  print("playerName: ", playerName)
            
          //  let teamResults = record.value(forKey: "teamName")
          //  teamName = teamResults as! String
            //print("teamName: ", teamName)
            
            let totAttempts = record.value(forKey: "TotAttempts")
            totalAttempts = totAttempts as! Int
            print("totalAttempts in UpdateTeamTotals.queryPlayer: ", totalAttempts)
            
            let totMakes = record.value(forKey: "TotMakes")
            totalMakes = totMakes as! Int
            print("totalMakes in UpdateTeamTotals.queryPlayer:: ", totalMakes)
            
         //   let totPercentage = record.value(forKey: "TotPercentage")
          //  totalPercentage = totPercentage as! Double
           // print("totalPercentage: ", totalPercentage)
            
          
            
            // let recordResults = record
          //  results = recordResults
            
        
         //  print("results in UpdateTeamTotals FetchedBlock: ", results)
    
             
                 } //recordFetchedBlock
        

      //  qOperation.queryCompletionBlock = { cursor, error in
        queryOp.queryCompletionBlock = { cursor, error in
           
            
            let qResults = QPlayer(playID: playID, totalAttempts: totalAttempts, totalMakes: totalMakes)
            
            completion(qResults)
            
        } // qOperttion queryCompletionBlock
    
   
        // CKContainer.default().publicCloudDatabase.add(qOperation)
             CKContainer.default().publicCloudDatabase.add(queryOp)
         
        
    
   // if playerArray.isEmpty  {
       /*
        var counter: Int = 0
        while counter <= 700000000 {
            counter += 1
        } // while loop
       
        print("Counter: ", counter)
       */
        //print("results before return: ", results)
        
     //   return (playID, totalAttempts, totalMakes)
   
 } // queryPlayer
    
    
  
    func totalsUpdate(playerID: CKRecord.ID, teamName: String, pName: String, attempts: Int, totalMakes: Int, shotPercentage: Double, scoreDate: Date)  {
        
    print("playerID in totalsUpdate: ", playerID)
   
        CKContainer.default().publicCloudDatabase.fetch(withRecordID: playerID) { (record, error) in
            
            guard let record = record, error == nil else {
                
                print("Error in fetching record")
                
                return
            }  // else

            print("Record in fetch: \(record)")
            
        // The following code is to save the updated record once fetched
    //let saveRecord = CKRecord(recordType: "team", recordID: playerID)

    record["teamName"] = teamName
        
    record["player"] = pName
        
    record["TotAttempts"] = attempts
    print("TotAttempts in totalsUpdate: ", attempts)
        
    record["TotMakes"] = totalMakes
    
    record["TotPercentage"] = shotPercentage
        
    record["LastDate"] = scoreDate
        
    print("record before save: ", record)
        
        CKContainer.default().publicCloudDatabase.save(record) { record, error in
            DispatchQueue.main.async {
               if error == nil {
                    print("No error in CKContainer")
                } else {
                   print("Error in CKContainer.save")
                    
                    let ac = UIAlertController(title: "Error", message: "There was a problem submitting your data \(error!.localizedDescription)", preferredStyle: .alert)
                   ac.addAction(UIAlertAction(title: "OK", style: .default))
                   // self.persent(ac, animated: true)
                }  // else
                
          } //if error
         } // DispatchQueue
    
        }  // fetch
    
    }  // func totalsUpdate
    
  
    
 }  // UpdateTeamTotals class

