//
//  EventTeamCheck.swift
//  RosterTableView
//
//  Created by Brian Naszradi on 6/25/21.
//

import Foundation
import UIKit
import CloudKit

class EventTeamCheck {

    // queryEvent func
    //querySingleEvent func
    //eventText func
    // updateEventText func
    
    
    let container = CloudKit.CKContainer(identifier: "ICloud.Brian-Naszradi.RosterTableView")
    
  //  func queryEvent(team: String, eventN: String, eventD: Date) -> CKRecord.ID   {
    
    
    func queryEvent(team: String, eventN: String, eventD: Date, completion: @escaping (QqueryEvent)->Void)  {
           
    
        print("team in EventTeamCheck: ", team)
      
        var resultsID: CKRecord.ID = CKRecord.ID()
        
        let eventPredicate = NSPredicate(format: "team == %@ AND eventName == %@ AND eventDate == %@", team, eventN, eventD as CVarArg)
        
        let query = CKQuery(recordType: "events", predicate: eventPredicate)
        
         
        let queryOp = CKQueryOperation(query: query)
        
        queryOp.resultsLimit = 25
       
 
        queryOp.recordFetchedBlock = { record in
            
          //  DispatchQueue.main.async {
              
            let recordResults = record.recordID
            
            resultsID = recordResults
            
            print("recordID for results in FetchedBlock: ", recordResults)
            
          //  }  // DispatchQueue
             
             
                 }  //recordFetchedBlock
        
    
        queryOp.queryCompletionBlock = { cursor, error in
            
            let qqueryEvent = QqueryEvent(resultsID: resultsID)
            print("qqueryEvent in CompletionBlock: ", qqueryEvent)
            
            completion(qqueryEvent)
            
        
        } // qOperttion queryCompletionBlock
    
        
    
        CKContainer.default().publicCloudDatabase.add(queryOp)
    
       
      /*
        var counter: Int = 0
        while counter <= 700000000 {
            counter += 1
        } // while loop
       
        print("Counter: ", counter)
        
        print("results before return: ", resultsID)
        
        return resultsID
   */
        
 } // queryPlayer
  
    
   // func querySingleEvent(team: String, eventD: Date) -> CKRecord   {
    
    func querySingleEvent(team: String, eventD: Date, completion: @escaping (QSingleEvent)->Void)  {
           
   
        print("team in EventTeamCheck.querySingleEvent: ", team)
        print("eventD in EventTeamCheck.querySingleEvent: ", eventD)
        
         
        var recordResults = CKRecord(recordType: "events")
        
        
        let eventPredicate = NSPredicate(format: "team == %@ AND eventDate == %@", team, eventD as CVarArg)
        
        
        let query = CKQuery(recordType: "events", predicate: eventPredicate)
        
         
        let queryOp = CKQueryOperation(query: query)
        
        
            
        //qOperation.resultsLimit = 25
        queryOp.resultsLimit = 25
       
 
        // This is non-structure data fetch
       //  queryOp.recordFetchedBlock = { record in
        
     //   queryOp.recordFetchedBlock = { (record : CKRecord) in
              
        
        queryOp.recordFetchedBlock = { record in
            
          //  DispatchQueue.main.async {
              
               // let id = record.recordID
           // let results = record.value(forKey: "player")
             recordResults = record
            
           
            print("eventRecord in EventTeamCheck.querySingleEvent FetchedBlock: ", recordResults)
            
           // print("record for results in FetchedBlock: ", recordResults)
            
          //  }  // DispatchQueue
             
             
                 }  //recordFetchedBlock
        
      
        //  qOperation.queryCompletionBlock = { cursor, error in
          queryOp.queryCompletionBlock = { cursor, error in
              
              let qSingleEvent = QSingleEvent(recordResults: recordResults)
              print("qSingleEvent in CompletionBlock: ", qSingleEvent)
              
              completion(qSingleEvent)
              
          } // qOperttion queryCompletionBlock
      
        
        
   // CKContainer.default().publicCloudDatabase.add(qOperation)
        CKContainer.default().publicCloudDatabase.add(queryOp)
    
    
      
     /*
        var counter: Int = 0
        while counter <= 700000000 {
            counter += 1
        } // while loop
       
        print("Counter: ", counter)
        
        print("results before return: ", recordResults)
        
        return recordResults
   */
        
 } // querySingleEvent func

    
    
 //   func eventText (team: String, eventN: String, eventD: Date) -> (smsText: String, eventID: CKRecord.ID) {
    
    func eventText (team: String, eventN: String, eventD: Date, completion: @escaping (QEventText)->Void)  {
        
        print("team in eventText: ", team)
        print("eventN in eventText: ", eventN)
        print("eventD in eventText: ", eventD)
       
       var smsText: String = ""
        
        var eventID: CKRecord.ID = CKRecord.ID()
        
         let eventPredicate = NSPredicate(format: "team == %@ AND eventName == %@ AND eventDate == %@", team, eventN, eventD as CVarArg)
         
         let query = CKQuery(recordType: "events", predicate: eventPredicate)
         
          
         let queryOp = CKQueryOperation(query: query)
         
         queryOp.resultsLimit = 25
        
         queryOp.recordFetchedBlock = { record in
             
        //  DispatchQueue.main.async {
          
          
          //Handle the case where no text is initially entered in record - this code doesn't run reliably
             /*
             if record.value(forKey: "textMessage") == nil {
             
                 let text = "Enter SMS text here"
                 smsText = text
                 print("smsText in Nil: ", smsText)
             
             } else {
            
                let text = record.value(forKey: "textMessage") as! String
                smsText = text
                print("smsText: ", smsText)
             
             } // if else textMessage in blank
            */
             
             let text = record.value(forKey: "textMessage") as! String
             
             smsText = text
             print("smsText: ", smsText)
             
             
             let event = record.recordID
             eventID = event
             print("eventID: ", eventID)
             
          //  }  // DispatchQueue
              
            }  //recordFetchedBlock
         
       
        queryOp.queryCompletionBlock = { cursor, error in
         
            let qEventText = QEventText(smsText: smsText, eventID: eventID)
            
            completion(qEventText)
            
        
        } // qOperttion queryCompletionBlock
    
        
         CKContainer.default().publicCloudDatabase.add(queryOp)
     
         
        /*
         var counter: Int = 0
         while counter <= 700000000 {
             counter += 1
         } // while loop
        
         print("Counter: ", counter)
         
         return (smsText, eventID)
        */
        
    } //func eventText
    
    
    
    func updateEventText (eventID: CKRecord.ID, textMessage: String) {
    
        CKContainer.default().publicCloudDatabase.fetch(withRecordID: eventID) { (record, error) in
            
            guard let record = record, error == nil else {
                
                print("Error in fetching record")
                
                return
            }  // else

            print("Record in fetch: \(record)")
            
        // The following code is to save the updated record once fetched
    //let saveRecord = CKRecord(recordType: "team", recordID: playerID)

    record["textMessage"] = textMessage
        
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
    
    } //func updateEventText
    
    
    
 }  // PlayerTeamData class
