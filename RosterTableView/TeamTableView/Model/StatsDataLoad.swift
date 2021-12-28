//
//  StatsDataLoad.swift
//  RosterTableView
//
//  Created by Brian Naszradi on 1/23/21.
//

import Foundation
import CloudKit

class StatsDataLoad {

    // rosterQuery func
    // playerQuery func
    // eventPlayerQuery func
    
    
    
    let container = CloudKit.CKContainer(identifier: "ICloud.Brian-Naszradi.RosterTableView")
    

   
    //func rosterQuery(tName: String, pName: String) -> Array<Any> {
    
  //  func rosterQuery(pName: String, team: String) ->  (playerArray:  Array<String>, dateArray: Array<Date>, attemptArray: Array<Int>, makesArray:Array<Int>, percentArray: Array<Double>) {
    
    
    func rosterQuery(pName: String, team: String, completion: @escaping (QStats)->Void)  {
       
        
        print("team in rosterQuery: ", team)
        
       //  let playerTeam = PlayerTeamData()
        
        var playerArray = [] as Array<String>
        var dateArray = [] as Array<Date>
        var attemptArray = [] as Array<Int>
        var makesArray = [] as Array<Int>
        var percentArray = [] as Array<Double>
       
      
        let teamPredicate = NSPredicate(format: "teamName == %@", team)
        
        
        let query = CKQuery(recordType: "team", predicate: teamPredicate)
         
        
       query.sortDescriptors = [NSSortDescriptor(key: "TotPercentage", ascending: false)]
        
        
    
        let queryOp = CKQueryOperation(query: query)
        
        
        
        queryOp.desiredKeys = ["player", "LastDate", "TotAttempts","TotMakes", "TotPercentage"]
        
        
        queryOp.resultsLimit = 25
       
       
    
        queryOp.recordFetchedBlock = { record in
            
            
            let player = record["player"] as! String
            print("player in recordFetchedBlock: ", player)
            
           // let shot = record["shot"] as! String
            
            let date = record["LastDate"] as! Date
            
            let makes = record["TotMakes"] as! Int
    
            let attempts = record["TotAttempts"] as! Int
            
            let percentage = record["TotPercentage"] as! Double
            print("percentage in recordFetchedBlock: ", percentage)
            
        
            playerArray.append(player)
            dateArray.append(date)
            attemptArray.append(attempts)
            makesArray.append(makes)
            percentArray.append(percentage)
    

             }  //recordFetchedBlock
    
 
          queryOp.queryCompletionBlock = { cursor, error in
              
              
              let queryCount = playerArray.count
             
              print("Number rows in array in queryCompletionBlock: ", queryCount)
              
              let qResults = QStats(playerArray: playerArray, dateArray: dateArray, attemptArray: attemptArray, makesArray: makesArray, percentArray: percentArray)
              
              completion(qResults)
           
          } // queryOp queryCompletionBlock
      
        
        
        CKContainer.default().publicCloudDatabase.add(queryOp)
    
    
 } //rosterQuery func
  
 
    
  //  func playerQuery(pName: String, teamRecord: CKRecord) ->  (playerArray:  Array<String>, dateArray: Array<Date>, attemptArray: Array<Int>, makesArray:Array<Int>, percentArray: Array<Double>) {
    
        
    func playerQuery(pName: String, teamRecord: CKRecord, completion: @escaping (QStats)->Void)  {
          
       // print("pName in StatsDataLoad: ", pName)
       
      
        var playerArray = [] as Array<String>
        var dateArray = [] as Array<Date>
        var attemptArray = [] as Array<Int>
        var makesArray = [] as Array<Int>
        var percentArray = [] as Array<Double>
        
        print("player in StatsDataLoad.playerQuery: ", pName)
        print("teamRecord in StatsDataLoad.playerQuery: ", teamRecord)
        
       // This predicate doesn't work
       // let playerPredicate = NSPredicate(format: "player == %@ AND teamReference == %@", pName, teamRef)
       
        //This predicate works
      //  let playerPredicate = NSPredicate(format: "player == %@", pName)
        
        // This predicate doesn't work
        
        let teamRef = CKRecord.Reference(record: teamRecord, action: .deleteSelf)
      //  print("teamRef is: ", teamRef)
        
        let playerPredicate = NSPredicate(format: "teamReference == %@", teamRef)
        
        let query = CKQuery(recordType: "playername", predicate: playerPredicate)
        
       
        query.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        
        // This is the CKReference query code

        // Need to query the team data type for this record to get the recordID
       
        /*
        let recordTeam = CKRecord(recordType: "team")
        
        recordTeam["teamName"] = team
        recordTeam["player"] = pName
        
        print("recordTeam: ", recordTeam)
          
       let recordTeamID = recordTeam.recordID
        
        print("recordTeamID: ", recordTeamID)
        */
       
        /*
       let recordTeam = playerTeam.queryPlayer(pName: pName, team: team)
        print("recordTeam: ", recordTeam)
        
       
        let recordTeamID = recordTeam.recordID
        print("recordTeamID: ", recordTeamID)
        
       let recordToMatch = CKRecord.Reference(recordID: recordTeamID, action: .deleteSelf)
        
        print("recordToMatch: ", recordToMatch)
        
       let predicate = NSPredicate(format: "teamReference == %@", recordToMatch)
       */
        
       // let predicate = NSPredicate(format: "player == %@", recordToMatch)
         
        
        let queryOp = CKQueryOperation(query: query)
        
        
        
        queryOp.desiredKeys = ["player", "date", "shotAttempts","shotMakes", "shotPercentage","teamReference"]
        
        
        queryOp.resultsLimit = 25
       
        
        // This is non-structure data fetch
       //  qOperation.recordFetchedBlock = { record in
        queryOp.recordFetchedBlock = { record in
            
            //(record : CKRecord!) in
             
            
            // let results = [record.value(forKey: "player") as! String]
            
           // var playerRecord = PlayerNames()
           // var shotRecord = PlayerNames()
            
           // playerRecord.player = record["player"] as! String
            
            let player = record["player"] as! String
            print("player in StatsDataLoad.playerQuery recordFetchedBlock: ", player)
            
           // let shot = record["shot"] as! String
            
            let date = record["date"] as! Date
            
            let makes = record["shotMakes"] as! Int
    
            let attempts = record["shotAttempts"] as! Int
            
            let percentage = record["shotPercentage"] as! Double
           // print("percentage in recordFetchedBlock: ", percentage)
            
            
            playerArray.append(player)
          //  shotArray.append(shot)
            dateArray.append(date)
            attemptArray.append(attempts)
            makesArray.append(makes)
            percentArray.append(percentage)

            
             }  //recordFetchedBlock
    
 
        queryOp.queryCompletionBlock = { cursor, error in
            
          //  print("ResultsValueArray in CompletionBlock: ", resultsValueArray)
             
            let queryCount = playerArray.count
           
            print("Number rows in playerArray in StatsDataLoad.playerQuery queryCompletionBlock: ", queryCount)
         
            
            let playerQueryResults = QStats(playerArray: playerArray, dateArray: dateArray, attemptArray: attemptArray, makesArray: makesArray, percentArray: percentArray)
            
            completion(playerQueryResults)
            
            
        } // qOperation queryCompletionBlock
    
        
    
        CKContainer.default().publicCloudDatabase.add(queryOp)
    
    
       //   print("playerArray in playerQuery before loop: ", playerArray)
       
   
    /*
   // if playerArray.isEmpty  {
       
        var counter: Int = 0
        while counter <= 700000000 {
            counter += 1
        } // while loop
       
        print("Counter: ", counter)
        
   // } else {

     
       
      //  print("shotArray: ", shotArray)
   
   print("playerArray in playerQuery after loop: ", playerArray)
   // print("shotArray: ", shotArray)
        
   // print("resultsAttempts: ", resultsAttempts)
    
   // }  //else
        
       return (playerArray, dateArray, attemptArray, makesArray, percentArray)
   */
        
        
 } //playerQuery func
  
    
  //  func eventPlayerQuery(pName: String, eventRecord: CKRecord) ->  (playerArray:  Array<String>, dateArray: Array<Date>, attemptArray: Array<Int>, makesArray:Array<Int>, percentArray: Array<Double>) {
    
    func eventPlayerQuery(pName: String, eventRecord: CKRecord, completion: @escaping (QeventPlayerQuery)->Void) {
        
        var playerArray = [] as Array<String>
        var dateArray = [] as Array<Date>
        var attemptArray = [] as Array<Int>
        var makesArray = [] as Array<Int>
        var percentArray = [] as Array<Double>
        
        print("player in playerQuery: ", pName)
        print("eventRecord in playerQuery: ", eventRecord)
        
        let eventRef = CKRecord.Reference(record: eventRecord, action: .deleteSelf)
        print("eventRef is: ", eventRef)
        
        let playerPredicate = NSPredicate(format: "eventReference == %@ AND player ==%@", eventRef, pName)
        
        
      //  let sort = NSSortDescriptor(key: "date", ascending: false)
        
        let query = CKQuery(recordType: "playername", predicate: playerPredicate)
         
      query.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        
        let queryOp = CKQueryOperation(query: query)
        
        
        queryOp.desiredKeys = ["player", "date", "shotAttempts","shotMakes", "shotPercentage","teamReference"]
        
        
        queryOp.resultsLimit = 25
       
        
        // This is non-structure data fetch
       //  qOperation.recordFetchedBlock = { record in
        queryOp.recordFetchedBlock = { record in
            
            //(record : CKRecord!) in
             
            
            let player = record["player"] as! String
            print("player in player recordFetchedBlock: ", player)
            
           // let shot = record["shot"] as! String
            
            let date = record["date"] as! Date
            
            let makes = record["shotMakes"] as! Int
    
            let attempts = record["shotAttempts"] as! Int
            
            let percentage = record["shotPercentage"] as! Double
            print("percentage in recordFetchedBlock: ", percentage)
            
            
            playerArray.append(player)
          //  shotArray.append(shot)
            dateArray.append(date)
            attemptArray.append(attempts)
            makesArray.append(makes)
            percentArray.append(percentage)

            
             }  //recordFetchedBlock
    
 
        queryOp.queryCompletionBlock = { cursor, error in
            
            let queryCount = playerArray.count
           
            print("Number rows in array in queryCompletionBlock: ", queryCount)
            
            let qeventPlayerQuery = QeventPlayerQuery(playerArray: playerArray, dateArray: dateArray, attemptArray: attemptArray, makesArray: makesArray, percentArray: percentArray)
            
            completion(qeventPlayerQuery)
            
            
        } // qOperation queryCompletionBlock
    
   
        CKContainer.default().publicCloudDatabase.add(queryOp)
    
    
     
       
    /*
          print("playerArray in playerQuery before loop: ", playerArray)
       
   // if playerArray.isEmpty  {
       
        var counter: Int = 0
        while counter <= 700000000 {
            counter += 1
        } // while loop
       
        print("Counter: ", counter)
        
   // } else {

     
   print("playerArray in playerQuery after loop: ", playerArray)
        
       return (playerArray, dateArray, attemptArray, makesArray, percentArray)
        
        
    */
   
 } //eventPlayerQuery func
  
    
 }  // StatsDataLoad class
