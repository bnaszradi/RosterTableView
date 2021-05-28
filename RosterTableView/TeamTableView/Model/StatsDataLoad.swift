//
//  StatsDataLoad.swift
//  RosterTableView
//
//  Created by Brian Naszradi on 1/23/21.
//

import Foundation
import CloudKit

class StatsDataLoad {

    let container = CloudKit.CKContainer(identifier: "ICloud.Brian-Naszradi.RosterTableView")
    
    /*
    struct PlayerNames {
        var player: String = ""
        var shotAttempts: Int = 0
        var shot: String = ""
        var shotPercentage: Double = 0.0
        
    }
    
  */

   // This is the iCloud code
   
    //  with tName
    //func rosterQuery(tName: String, pName: String) -> Array<Any> {
    
    func rosterQuery(pName: String, team: String) ->  (playerArray:  Array<String>, dateArray: Array<Date>, attemptArray: Array<Int>, makesArray:Array<Int>, percentArray: Array<Double>) {
    
        
       // print("tName in DataLoader: ", tName)
      //  print("pName in StatsDataLoad: ", pName)
        print("team in StatsDataLoad: ", team)
        
       //  let playerTeam = PlayerTeamData()
        
    //  var resultsValueArray = [] as Array
        
        var playerArray = [] as Array<String>
       // var shotArray = [] as Array<String>
        var dateArray = [] as Array<Date>
        var attemptArray = [] as Array<Int>
        var makesArray = [] as Array<Int>
        var percentArray = [] as Array<Double>
       // var teamRefer = [] as Array<CKRecord.ID>
        
      
        let teamPredicate = NSPredicate(format: "teamName == %@", team)
        
        
        
      //  let sort = NSSortDescriptor(key: "TotPercentage", ascending: false)
        
       // let sort = NSSortDescriptor(key: "LastDate", ascending: false)
        
        let query = CKQuery(recordType: "team", predicate: teamPredicate)
         
      //  query.sortDescriptors = [sort]
    
        
        
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
         
        
        
        // Using only player as predicate - this predicate works
       // let predicate = NSPredicate(format: "player == %@", pName)
        
       // print("predicate in StatsDataLoad: ", predicate)
        
        // Create the query object.
        
      //  let query = CKQuery(recordType: "playername", predicate: predicate)
        
        let queryOp = CKQueryOperation(query: query)
        
        
        
        queryOp.desiredKeys = ["player", "LastDate", "TotAttempts","TotMakes", "TotPercentage"]
        
        
        //   qOperation.desiredKeys = ["player", "shotAttempts", "shot", "shotPercentage"]
            
        //qOperation.resultsLimit = 25
        queryOp.resultsLimit = 25
       
        //print("qOperation resultsLimit: ", qOperation.resultsLimit)
   
        /*
    //This is Structure Data Fetch
   qOperation.recordFetchedBlock = { record in
    
      
    var playerNames = PlayerNames()
       
        playerNames.player = record["player"] as! String
       playerNames.shotAttempts = record["shotAttempts"] as! Int
      playerNames.shot = record["shot"] as! String
       playerNames.shotPercentage = record["shotPercentage"] as! Double
      
        
    resultsValueArray.append(playerNames)
        
        print("resultsValueArray in FetchedBlock: ", resultsValueArray)
     */
 
        
        // This is non-structure data fetch
       //  qOperation.recordFetchedBlock = { record in
        queryOp.recordFetchedBlock = { record in
            
            //(record : CKRecord!) in
             
            
            // let results = [record.value(forKey: "player") as! String]
            
           // var playerRecord = PlayerNames()
           // var shotRecord = PlayerNames()
            
           // playerRecord.player = record["player"] as! String
            
            let player = record["player"] as! String
            print("player in recordFetchedBlock: ", player)
            
           // let shot = record["shot"] as! String
            
            let date = record["LastDate"] as! Date
            
            let makes = record["TotMakes"] as! Int
    
            let attempts = record["TotAttempts"] as! Int
            
            let percentage = record["TotPercentage"] as! Double
            print("percentage in recordFetchedBlock: ", percentage)
            
           // let teamRef = record["teamReference"] as! CKRecord.ID
            
            
           /*
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short
            dateFormatter.timeStyle = .short
            
            let date = dateFormatter.string(from: date)
            
            print("createdAt: ", date)
            */
            
            
            
            playerArray.append(player)
          //  shotArray.append(shot)
            dateArray.append(date)
            attemptArray.append(attempts)
            makesArray.append(makes)
            percentArray.append(percentage)
          //  teamRefer.append(teamRef)

            
             }  //recordFetchedBlock
    
 
   // CKContainer.default().publicCloudDatabase.add(qOperation)
        CKContainer.default().publicCloudDatabase.add(queryOp)
    
    
      //  qOperation.queryCompletionBlock = { cursor, error in
        queryOp.queryCompletionBlock = { cursor, error in
            
          //  print("ResultsValueArray in CompletionBlock: ", resultsValueArray)
             
          //  let queryCount = resultsValueArray.count
            
            let queryCount = playerArray.count
           
            print("Number rows in array in queryCompletionBlock: ", queryCount)
         
        } // qOperttion queryCompletionBlock
    
    
          print("playerArray before loop: ", playerArray)
       
   
    
   // if playerArray.isEmpty  {
       
        var counter: Int = 0
        while counter <= 700000000 {
            counter += 1
        } // while loop
       
        print("Counter: ", counter)
        
   // } else {

     
       
      //  print("shotArray: ", shotArray)
   
   print("playerArray after loop: ", playerArray)
   // print("shotArray: ", shotArray)
        
   // print("resultsAttempts: ", resultsAttempts)
    
   // }  //else
        
       return (playerArray, dateArray, attemptArray, makesArray, percentArray)
   
        
    
 } //rosterQuery func
  
 
    
    func playerQuery(pName: String, teamRecord: CKRecord) ->  (playerArray:  Array<String>, dateArray: Array<Date>, attemptArray: Array<Int>, makesArray:Array<Int>, percentArray: Array<Double>) {
    
        
      
       // print("pName in StatsDataLoad: ", pName)
       
      
        var playerArray = [] as Array<String>
       // var shotArray = [] as Array<String>
        var dateArray = [] as Array<Date>
        var attemptArray = [] as Array<Int>
        var makesArray = [] as Array<Int>
        var percentArray = [] as Array<Double>
        
        print("player in playerQuery: ", pName)
        print("teamRecord in playerQuery: ", teamRecord)
        
       // This predicate doesn't work
       // let playerPredicate = NSPredicate(format: "player == %@ AND teamReference == %@", pName, teamRef)
       
        //This predicate works
      //  let playerPredicate = NSPredicate(format: "player == %@", pName)
        
        // This predicate doesn't work
        
        let teamRef = CKRecord.Reference(record: teamRecord, action: .deleteSelf)
    print("teamRef is: ", teamRef)
        
        let playerPredicate = NSPredicate(format: "teamReference == %@", teamRef)
        
        
      //  let sort = NSSortDescriptor(key: "date", ascending: false)
        
        let query = CKQuery(recordType: "playername", predicate: playerPredicate)
         
       // query.sortDescriptors = [sort]
    
        
        
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
    
 
   // CKContainer.default().publicCloudDatabase.add(qOperation)
        CKContainer.default().publicCloudDatabase.add(queryOp)
    
    
      //  qOperation.queryCompletionBlock = { cursor, error in
        queryOp.queryCompletionBlock = { cursor, error in
            
          //  print("ResultsValueArray in CompletionBlock: ", resultsValueArray)
             
            let queryCount = playerArray.count
           
            print("Number rows in array in queryCompletionBlock: ", queryCount)
         
        } // qOperation queryCompletionBlock
    
    
          print("playerArray in playerQuery before loop: ", playerArray)
       
   
    
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
   
 } //playerQuery func
  
    
    
    
    
 }  // StatsDataLoad class
