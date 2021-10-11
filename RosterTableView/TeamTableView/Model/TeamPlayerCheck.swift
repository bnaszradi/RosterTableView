//
//  TeamPlayerCheck.swift
//  RosterTableView
//
//  Created by Brian Naszradi on 4/1/21.
//

import Foundation
import CloudKit

class TeamPlayerCheck {
    
    // TeamPlayer func
    //  TeamCheck func
    // playerPhoto func
    // EventCheck func
    
    
    let container = CKContainer(identifier: "ICloud.Brian-Naszradi.RosterTableView")
    
    func TeamPlayer(team: String, player: String) -> Array<Any> {
    
        var playerArray = [] as Array<String>
        
    //  check for team name and player in team type
    
    let teamPredicate = NSPredicate(format: "teamName == %@ AND player ==%@", team, player)
    
    let query = CKQuery(recordType: "team", predicate: teamPredicate)
    
    let queryOp = CKQueryOperation(query: query)
    
   // queryOp.desiredKeys = ["player", "LastDate", "TotAttempts","TotMakes", "TotPercentage"]
        
        queryOp.desiredKeys = ["teamName", "player"]
    
    queryOp.resultsLimit = 25
    
    queryOp.recordFetchedBlock = { record in
        
        let player = record["player"] as! String
        print("player in recordFetchedBlock: ", player)
    
        playerArray.append(player)
        
    }  // recordFetchedBlock
        
        CKContainer.default().publicCloudDatabase.add(queryOp)
    
    queryOp.queryCompletionBlock = { cursor, error in
        
        let queryCount = playerArray.count
       
        print("Number rows in array in queryCompletionBlock: ", queryCount)
        
    
    } // qOperttion queryCompletionBlock
    
    
        
         var counter: Int = 0
         while counter <= 700000000 {
             counter += 1
         } // while loop
        
         print("Counter: ", counter)
        
        
        return playerArray
         
    } // TeamPlayer func
    
    
    
    
    func TeamCheck(team: String) -> Array<Any> {
    
        var teamArray = [] as Array<String>
        
    //  check for team name and player in team type
    
    let teamPredicate = NSPredicate(format: "teamName == %@", team)
    
    let query = CKQuery(recordType: "team", predicate: teamPredicate)
    
    let queryOp = CKQueryOperation(query: query)
    
   // queryOp.desiredKeys = ["player", "LastDate", "TotAttempts","TotMakes", "TotPercentage"]
        
        queryOp.desiredKeys = ["teamName"]
    
    queryOp.resultsLimit = 25
    
    queryOp.recordFetchedBlock = { record in
        
        let team = record["teamName"] as! String
        print("team recordFetchedBlock: ", team)
    
        teamArray.append(team)
        
    }  // recordFetchedBlock
        
        CKContainer.default().publicCloudDatabase.add(queryOp)
    
    queryOp.queryCompletionBlock = { cursor, error in
        
        let queryCount = teamArray.count
       
        print("Number rows in array in queryCompletionBlock: ", queryCount)
        

    } // qOperttion queryCompletionBlock
    
    
        
         var counter: Int = 0
         while counter <= 800000000 {
             counter += 1
         } // while loop
        
         print("Counter: ", counter)
        
        
        return teamArray
         
    } // TeamCheck func

    
    
    
    func playerPhoto(team: String, player: String) -> Array<CKAsset> {
    
       var playerArray = [] as Array<CKAsset>
      //  var photo: CKAsset!
       // var photo: Int!
        
        
    //  check for team name and player in team type
    
        print("team in playerPhoto: ", team)
        print("player in playerPhoto: ", player)
    let teamPredicate = NSPredicate(format: "teamName == %@ AND player ==%@", team, player)
    
    let query = CKQuery(recordType: "team", predicate: teamPredicate)
    
    let queryOp = CKQueryOperation(query: query)
    
   // queryOp.desiredKeys = ["player", "LastDate", "TotAttempts","TotMakes", "TotPercentage"]
        
        queryOp.desiredKeys = ["teamName", "player", "playerPhoto"]
    
    queryOp.resultsLimit = 25
    
    queryOp.recordFetchedBlock = { record in
        
       // let player = record["player"] as! String
       // print("player in recordFetchedBlock: ", player)
      //  var photo = record["playerPhoto"] as! CKAsset
        if let photo = record["playerPhoto"] as? CKAsset {
        
       // print("photo from playerPhoto: ", photo)
       
       playerArray.append(photo)
       
        } // if photo
       
        
    }  // recordFetchedBlock
        
        CKContainer.default().publicCloudDatabase.add(queryOp)
    
    //queryOp.perRecordProgressBlock = { self.progressView.progress = $1 }
        
    queryOp.queryCompletionBlock = {  cursor, error in
        

    } // qOperttion queryCompletionBlock
    
         var counter: Int = 0
         while counter <= 700000000 {
             counter += 1
         } // while loop
        
         print("Counter: ", counter)
        
        return playerArray
         
    } // playerPhoto func
    
    
    //Check is event already exists in Event type
    func EventCheck(team: String, eventDate: Date, eventName: String) -> Array<Any> {
    
        var eventArray = [] as Array<String>
        
    //  check for team name and player in team type
    
        let eventPredicate = NSPredicate(format: "team == %@ AND eventDate == %@ AND eventName == %@", team, eventDate as CVarArg, eventName)
    
    let query = CKQuery(recordType: "events", predicate: eventPredicate)
    
    let queryOp = CKQueryOperation(query: query)
    
        queryOp.desiredKeys = ["team", "eventDate","eventName"]
    
    queryOp.resultsLimit = 25
    
    queryOp.recordFetchedBlock = { record in
        
       let teamName = record["team"] as! String
        
        print("team in recordFetchedBlock: ", teamName)
    
        eventArray.append(teamName)
        
    }  // recordFetchedBlock
        
        CKContainer.default().publicCloudDatabase.add(queryOp)
    
    queryOp.queryCompletionBlock = { cursor, error in
        
        let queryCount = eventArray.count
       
        print("Number rows in array in queryCompletionBlock: ", queryCount)
       

    } // qOperttion queryCompletionBlock
        
         var counter: Int = 0
         while counter <= 700000000 {
             counter += 1
         } // while loop
        
         print("Counter: ", counter)
        
        
        return eventArray
         
    } // EventCheck func
   
    
}  // TeamPlayerCheck

