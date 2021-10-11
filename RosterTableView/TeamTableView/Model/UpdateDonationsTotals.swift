//
//  UpdateDonationsTotals.swift
//  RosterTableView
//
//  Created by Brian Naszradi on 7/19/21.
//

import Foundation
import CloudKit
import UIKit


class UpdateDonationsTotals {

    //functions:
    //querySponsorWithShots
    //queryDonationWithShots
    //querySponsr
    //queryCheckSponsor
    //totalsUpdateWithShots
    //totalsUpdate
    //createDonationRecord
    //func queryDonationPlayers
    
    let container = CloudKit.CKContainer(identifier: "ICloud.Brian-Naszradi.RosterTableView")
    
    
    let playerSearch = PlayerTeamData()
    
    let eventRecord = EventTeamCheck()
    

    func querySponsorWithShots(tName: String, pName: String, eDate: Date) -> (sponsorID: CKRecord.ID, totAttempt: Int, totMake: Int, totPerShot: Double, totFlatDon: Double, totalDonation: Double )   {
    
        var sponsorID: CKRecord.ID = CKRecord.ID()
        
        var totAttempt: Int = 0
        var totMake: Int = 0
        var totPerShot: Double = 0.0
        var totFlatDon: Double = 0.0
        var totalDonation: Double = 0.0
        
        
        let sponsorPredicate = NSPredicate(format: "player == %@ AND team == %@ AND eventDate == %@", pName, tName, eDate as CVarArg)
        
        
        let query = CKQuery(recordType: "donations", predicate: sponsorPredicate)
        
        query.sortDescriptors = [NSSortDescriptor(key: "totalDonation", ascending: false)]
        
        
        let queryOp = CKQueryOperation(query: query)
        
        queryOp.resultsLimit = 25
       
        // This is non-structure data fetch
       queryOp.recordFetchedBlock = { record in
        
      // queryOp.recordFetchedBlock = { (record : CKRecord) in
              
          //  DispatchQueue.main.async {
              
               
          let spons = record.recordID
        
          sponsorID = spons
        
           print("sponsorID: ", sponsorID)
            
        totAttempt = record.value(forKey: "totAttempt") as! Int
        
        print("totAttempt: ", totAttempt)
            
        totMake = record.value(forKey: "totMake") as! Int
        
        print("totMake: ", totMake)
            
        totPerShot = record.value(forKey: "totPerShot") as! Double
        print("totPerShot: ", totPerShot)
        
        totFlatDon = record.value(forKey: "totFlatDonation") as! Double
        print("totalFlatDon: ", totFlatDon)
        
        totalDonation = record.value(forKey: "totalDonation") as! Double
        print("totalDonation: ", totalDonation)
           
             
                 }  //recordFetchedBlock
        
      
        CKContainer.default().publicCloudDatabase.add(queryOp)
    
    
        queryOp.queryCompletionBlock = { cursor, error in
            
         
        } // qOperttion queryCompletionBlock
    
   
    
   // if playerArray.isEmpty  {
       
        var counter: Int = 0
        while counter <= 700000000 {
            counter += 1
        } // while loop
       
        print("Counter: ", counter)
        
        //print("results before return: ", results)
        
        return (sponsorID, totAttempt, totMake, totPerShot, totFlatDon, totalDonation)
   
 } // querySponsorWithShots
    
    
    
    func queryDonationWithShots(tName: String, eDate: Date) -> (playerN: Array<String>, totAttempt: Array<Int>, totMake: Array<Int>, totPerShot: Array<Double>, totFlatDon: Array<Double>, totalDonation: Array<Double> )   {
    

        var playerArray = [] as Array<String>
        var totAttemptArray = [] as Array<Int>
        var totMakeArray = [] as Array<Int>
        var totPerShotArray = [] as Array<Double>
        var totFlatDonArray = [] as Array<Double>
        var totalDonationArray = [] as Array<Double>
        
        
        let sponsorPredicate = NSPredicate(format: "team == %@ AND eventDate == %@", tName, eDate as CVarArg)
        
        
        let query = CKQuery(recordType: "donations", predicate: sponsorPredicate)
        
        query.sortDescriptors = [NSSortDescriptor(key: "totalDonation", ascending: false)]

        let queryOp = CKQueryOperation(query: query)
        
        queryOp.resultsLimit = 25
       
        // This is non-structure data fetch
       queryOp.recordFetchedBlock = { record in
        
      // queryOp.recordFetchedBlock = { (record : CKRecord) in
              
          //  DispatchQueue.main.async {
              
        let player = record["player"] as! String
        playerArray.append(player)
        
       let totAttempt = record["totAttempt"] as! Int
        totAttemptArray.append(totAttempt)
        
        let totMakes = record["totMake"] as! Int
        totMakeArray.append(totMakes)
        
        let totPerShots = record["totPerShot"] as! Double
        totPerShotArray.append(totPerShots)
        
        let totFlatDons = record["totFlatDonation"] as! Double
        totFlatDonArray.append(totFlatDons)
        
        let totalDonations = record["totalDonation"] as! Double
        totalDonationArray.append(totalDonations)
        
        
             
                 }  //recordFetchedBlock
        
      
        CKContainer.default().publicCloudDatabase.add(queryOp)
    
    
        queryOp.queryCompletionBlock = { cursor, error in
            
         
        } // qOperttion queryCompletionBlock
    
   
    
   // if playerArray.isEmpty  {
       
        var counter: Int = 0
        while counter <= 700000000 {
            counter += 1
        } // while loop
       
        print("Counter: ", counter)
        
        //print("results before return: ", results)
        
        return (playerArray, totAttemptArray, totMakeArray, totPerShotArray, totFlatDonArray, totalDonationArray)
   
 } // queryDonationWithShots

    
    
    
    func querySponsor(tName: String, pName: String, eDate: Date) -> (sponsorID: CKRecord.ID, totPerShot: Double, totFlatDon: Double)   {
    
        var sponsorID: CKRecord.ID = CKRecord.ID()
        
      //  var totAttempt: Int = 0
      //  var totMake: Int = 0
        var totPerShot: Double = 0.0
        var totFlatDon: Double = 0.0
      //  var totalDonation: Double = 0.0
        
        
        print("tName in querySponsor: ", tName)
        print("pName in querySponsor: ", pName)
        print("eDate in querySponsor: ", eDate)
        
    
        let sponsorPredicate = NSPredicate(format: "player == %@ AND team == %@ AND eventDate == %@", pName, tName, eDate as CVarArg)
        
        
        let query = CKQuery(recordType: "donations", predicate: sponsorPredicate)
        
         
        let queryOp = CKQueryOperation(query: query)
        
        
            
        //qOperation.resultsLimit = 25
        queryOp.resultsLimit = 25
       
 
        
        // This is non-structure data fetch
       queryOp.recordFetchedBlock = { record in
        
      // queryOp.recordFetchedBlock = { (record : CKRecord) in
              
          //  DispatchQueue.main.async {
              
               
          let spons = record.recordID
        
          sponsorID = spons
        
           print("sponsorID in querySponsor: ", sponsorID)
       
        /*
        totAttempt = record.value(forKey: "totAttempt") as! Int
        
        print("totAttempt: ", totAttempt)
            
        totMake = record.value(forKey: "totMake") as! Int
        
        print("totMake: ", totMake)
        */
        
        totPerShot = record.value(forKey: "totPerShot") as! Double
        print("totPerShot: ", totPerShot)
        
        totFlatDon = record.value(forKey: "totFlatDonation") as! Double
        print("totalFlatDon: ", totFlatDon)
        
       // totalDonation = record.value(forKey: "totalDonation") as! Double
       // print("totalDonation: ", totalDonation)
           
             
                 }  //recordFetchedBlock
        
      
        CKContainer.default().publicCloudDatabase.add(queryOp)
    
    
        queryOp.queryCompletionBlock = { cursor, error in
            
         
        } // qOperttion queryCompletionBlock
    
   
    
   // if playerArray.isEmpty  {
       
        var counter: Int = 0
        while counter <= 700000000 {
            counter += 1
        } // while loop
       
        print("Counter: ", counter)
        
        //print("results before return: ", results)
        
        return (sponsorID, totPerShot, totFlatDon)
   
 } // querySponsor
    
    
    
    func queryCheckSponsor(tName: String, pName: String, eDate: Date) -> (team: Array<String>, player: Array<String>, eventDate: Array<Date>)   {
    
        var teamArray = [] as Array<String>
        var playerArray = [] as Array<String>
        var eventDateArray = [] as Array<Date>
        
        
        print("tName in querySponsor: ", tName)
        print("pName in querySponsor: ", pName)
        print("eventDate in querySponsor: ", eDate)
        
    
        let sponsorPredicate = NSPredicate(format: "player == %@ AND team == %@ AND eventDate == %@", pName, tName, eDate as CVarArg)
        
        
        let query = CKQuery(recordType: "donations", predicate: sponsorPredicate)
        
         
        let queryOp = CKQueryOperation(query: query)
        
        
            
        //qOperation.resultsLimit = 25
        queryOp.resultsLimit = 25
       
 
        
        // This is non-structure data fetch
       queryOp.recordFetchedBlock = { record in
        
      // queryOp.recordFetchedBlock = { (record : CKRecord) in
              
          //  DispatchQueue.main.async {
              
        
        let team = record["team"] as! String
        teamArray.append(team)
        
        let player = record["player"] as! String
        playerArray.append(player)
        
        let eventDate = record["eventDate"] as! Date
        eventDateArray.append(eventDate)
        
        
                    
                 }  //recordFetchedBlock
        
      
        CKContainer.default().publicCloudDatabase.add(queryOp)
    
    
        queryOp.queryCompletionBlock = { cursor, error in
            
         
        } // qOperttion queryCompletionBlock
    
   
    
   // if playerArray.isEmpty  {
       
        var counter: Int = 0
        while counter <= 700000000 {
            counter += 1
        } // while loop
       
        print("Counter: ", counter)
        
        //print("results before return: ", results)
        
        return (teamArray, playerArray, eventDateArray)
   
 } // queryCheckSponsor
   
    
    
    
  
    func totalsUpdateWithShots(sponsorID: CKRecord.ID, teamName: String, pName: String, totalAttempt: Int, totalMake: Int, totalPerShot: Double, totalFlatDonation: Double, totalDonation: Double)  {
        
    print("sponsorID in totalsUpdate: ", sponsorID)
   
        
        
        CKContainer.default().publicCloudDatabase.fetch(withRecordID: sponsorID) { (record, error) in
            
            guard let record = record, error == nil else {
                
                print("Error in fetching record")
                
                return
            }  // else

            print("Record in fetch: \(record)")
            
            
      
        
        // The following code is to save the updated record once fetched
    //let saveRecord = CKRecord(recordType: "team", recordID: playerID)

    record["team"] = teamName
        
    record["player"] = pName
        
    record["totAttempt"] = totalAttempt
    print("totalAttempts in totalsUpdate: ", totalAttempt)
        
    record["totMake"] = totalMake
        
    record["totPerShot"] = totalPerShot
        
    record["totFlatDonation"] = totalFlatDonation
            
    record["totalDonation"] = totalDonation
        
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
    
    }  // func totalsUpdateWithShots

    
    func totalsUpdate(sponsorID: CKRecord.ID, teamName: String, pName: String, totalPerShot: Double, totalFlatDonation: Double, totalDonation: Double)  {
        
    print("sponsorID in totalsUpdate: ", sponsorID)
   
        CKContainer.default().publicCloudDatabase.fetch(withRecordID: sponsorID) { (record, error) in
            
            guard let record = record, error == nil else {
                
                print("Error in totalsUpdate fetching record")
                
                return
            }  // else

            print("Record in totalsUpdate fetch: \(record)")
            

   // record["team"] = teamName
        
   // record["player"] = pName
        
  //  record["totAttempt"] = totalAttempt
   //     print("totalAttempts in totalsUpdate: ", totalAttempt)
        
   // record["totMake"] = totalMake
        
    record["totPerShot"] = totalPerShot
        
    record["totFlatDonation"] = totalFlatDonation
            
    record["totalDonation"] = totalDonation
            
      
    print("record before save in totalsUpdate: ", record)
        
        CKContainer.default().publicCloudDatabase.save(record) { record, error in
            DispatchQueue.main.async {
               if error == nil {
                    print("No error in totalsUpdate CKContainer")
                } else {
                   print("Error in totalsUpdate CKContainer.save")
                    
                    let ac = UIAlertController(title: "Error", message: "There was a problem submitting your data \(error!.localizedDescription)", preferredStyle: .alert)
                   ac.addAction(UIAlertAction(title: "OK", style: .default))
                   // self.persent(ac, animated: true)
                }  // else
                
          } //if error
         } // DispatchQueue
    
        }  // fetch
    
    }  // func totalsUpdate
    
    
    func createDonationRecord(teamName: String, pName: String, eDate: Date, totAttempts: Int, totMakes: Int,  totPerShot: Double, totFlatDonation: Double, totalDonation: Double, eventName: String)  {
        

        let recordDonation = CKRecord(recordType: "donations")
        
        let playerRef = playerSearch.queryPlayer(pName: pName, team: teamName)
        
        recordDonation["playerRef"] = CKRecord.Reference(record: playerRef, action: .deleteSelf)
                
        
        let eventRef = eventRecord.querySingleEvent(team: teamName, eventD: eDate)
        
        recordDonation["eventsRef"] = CKRecord.Reference(record: eventRef, action: .deleteSelf)
        
        
        
    recordDonation["team"] = teamName
        
   recordDonation["player"] = pName
        
   recordDonation["totAttempt"] = totAttempts
   //     print("totalAttempts in totalsUpdate: ", totalAttempt)
   recordDonation["eventDate"] = eDate
        
   recordDonation["eventName"] = eventName
        
   recordDonation["totMake"] = totMakes
        
    recordDonation["totPerShot"] = totPerShot
        
    recordDonation["totFlatDonation"] = totFlatDonation
            
  recordDonation["totalDonation"] = totalDonation
        
 //   print("recordDonation before save: ", recordDonation)
        
        CKContainer.default().publicCloudDatabase.save(recordDonation) { record, error in
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
    
        var counter: Int = 0
        while counter <= 800000000 {
            counter += 1
        } // while loop
       
        print("Counter in createDonationRecord: ", counter)
        
    
    }  // func createDonationRecord

    
    func queryDonationPlayers(team: String, eventName: String, eventDate: Date) -> (team: Array<String>, player: Array<String>, totMake: Array<Int>, totAttempt: Array<Int>)   {
    
        var teamArray = [] as Array<String>
        var playerArray = [] as Array<String>
        var totMakeArray = [] as Array<Int>
        var totAttemptArray = [] as Array<Int>
       // var eventDateArray = [] as Array<Date>
        
        
       print("team in queryDonationPlayers: ", team)
       print("eventName in queryDonationPlayers:  ", eventName)
       print("eventDate in queryDonationPlayers ", eventDate)
        
    
        let sponsorPredicate = NSPredicate(format: "team == %@ AND eventName == %@ AND eventDate == %@", team, eventName, eventDate as CVarArg)
        
        let query = CKQuery(recordType: "donations", predicate: sponsorPredicate)
        
        let queryOp = CKQueryOperation(query: query)
        
        //qOperation.resultsLimit = 25
        queryOp.resultsLimit = 25
       

        // This is non-structure data fetch
       queryOp.recordFetchedBlock = { record in
        
      // queryOp.recordFetchedBlock = { (record : CKRecord) in
              
          //  DispatchQueue.main.async {
              
        let team = record["team"] as! String
        teamArray.append(team)
        
        let player = record["player"] as! String
        playerArray.append(player)
        
        let tMake = record["totMake"] as! Int
        print("tMake: ", tMake)
        totMakeArray.append(tMake)
        
        let tAttempt = record["totAttempt"] as! Int
        print("tAttempt: ", tAttempt)
        totAttemptArray.append(tAttempt)
        
       // let eventDate = record["eventDate"] as! Date
       // eventDateArray.append(eventDate)
        
                 }  //recordFetchedBlock
        
      
        CKContainer.default().publicCloudDatabase.add(queryOp)
    
        queryOp.queryCompletionBlock = { cursor, error in
            
         
        } // qOperttion queryCompletionBlock
    
    
   // if playerArray.isEmpty  {
       
        var counter: Int = 0
        while counter <= 700000000 {
            counter += 1
        } // while loop
       
        print("Counter: ", counter)
        
        //print("results before return: ", results)
        
        return (teamArray, playerArray, totMakeArray, totAttemptArray)
   
 } // func queryDonationPlayers
   
    
    
    
    
    
} // UpdateDonationsTotals
