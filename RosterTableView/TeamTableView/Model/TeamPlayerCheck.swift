//
//  TeamPlayerCheck.swift
//  RosterTableView
//
//  Created by Brian Naszradi on 4/1/21.
//

import Foundation
import CloudKit

class TeamPlayerCheck {
    
    // teamPlayer func
    //  TeamCheck func
    // playerPhoto func
    // EventCheck func
    
    
    let container = CKContainer(identifier: "ICloud.Brian-Naszradi.RosterTableView")
    
   // func teamPlayer(team: String, player: String) -> Array<Any> {
    
    func teamPlayer(team: String, player: String, completion: @escaping (QTeamPlayer)->Void)  {
        
        var playerArray = [] as Array<String>
        
    //  check for team name and player in team type
    
    let teamPredicate = NSPredicate(format: "teamName == %@ AND player ==%@", team, player)
    
    let query = CKQuery(recordType: "team", predicate: teamPredicate)
    
    let queryOp = CKQueryOperation(query: query)
    
    queryOp.desiredKeys = ["teamName", "player"]
    
    queryOp.resultsLimit = 25
    
    queryOp.recordFetchedBlock = { record in
        
        let player = record["player"] as! String
        print("player in recordFetchedBlock: ", player)
    
        playerArray.append(player)
        
    }  // recordFetchedBlock
        
        
        queryOp.queryCompletionBlock = { cursor, error in
            
            let queryCount = playerArray.count
           
            print("Number rows in array in queryCompletionBlock: ", queryCount)
            
            let qPlayerArray = QTeamPlayer(playerArray: playerArray)
            
            completion(qPlayerArray)
            
        
        } // qOperttion queryCompletionBlock
        
        
        
        CKContainer.default().publicCloudDatabase.add(queryOp)
    
   
        
        
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

    
    
    
  //  func playerPhoto(team: String, player: String) -> Array<CKAsset> {
    
    func playerPhoto(team: String, player: String, completion: @escaping (QPlayerPhoto)->Void)  {
            
       var playerArray = [] as Array<CKAsset>
      //  var photo: CKAsset!
       // var photo: Int!
        
        
    //  check for team name and player in team type
    
        print("team in playerPhoto: ", team)
        print("player in playerPhoto: ", player)
    let teamPredicate = NSPredicate(format: "teamName == %@ AND player ==%@", team, player)
    
    let query = CKQuery(recordType: "team", predicate: teamPredicate)
    
    let queryOp = CKQueryOperation(query: query)
    
        queryOp.desiredKeys = ["teamName", "player", "playerPhoto"]
    
    queryOp.resultsLimit = 25
    
    queryOp.recordFetchedBlock = { record in
        
      
        if let photo = record["playerPhoto"] as? CKAsset {
        
       // print("photo from playerPhoto: ", photo)
       
       playerArray.append(photo)
       
        } // if photo
       
        
    }  // recordFetchedBlock
        
        
    queryOp.queryCompletionBlock = {  cursor, error in
            
        let qPlayerArrayPhoto = QPlayerPhoto(playerArray: playerArray)
        
        completion(qPlayerArrayPhoto)
        

        } // qOperttion queryCompletionBlock
        
        
    CKContainer.default().publicCloudDatabase.add(queryOp)
    

    /*
         var counter: Int = 0
         while counter <= 700000000 {
             counter += 1
         } // while loop
        
         print("Counter: ", counter)
        
        return playerArray
       
        */
        
    } // playerPhoto func
    
    
    //Check if event already exists in Event type
  //  func EventCheck(team: String, eventDate: Date, eventName: String) -> Array<Any> {
    
    func EventCheck(team: String, eventDate: Date, eventName: String, completion: @escaping (QEventCheck)->Void)  {
        
    
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
        
        
        
        queryOp.queryCompletionBlock = { cursor, error in
            
            let queryCount = eventArray.count
           
            print("Number rows in array in queryCompletionBlock: ", queryCount)
           
            let qEventCheck = QEventCheck(eventArray: eventArray)
            
            completion(qEventCheck)
           

        } // qOperttion queryCompletionBlock
            
        
        CKContainer.default().publicCloudDatabase.add(queryOp)
    
   
        /*
         var counter: Int = 0
         while counter <= 700000000 {
             counter += 1
         } // while loop
        
         print("Counter: ", counter)
        
        
        return eventArray
        */
        
    } // EventCheck func
   
    
}  // TeamPlayerCheck

