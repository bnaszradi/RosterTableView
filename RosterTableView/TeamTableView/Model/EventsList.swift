//
//  EventsList.swift
//  RosterTableView
//
//  Created by Brian Naszradi on 6/11/21.
//

import Foundation
import CloudKit

class QueryEvents {
    
    let container = CloudKit.CKContainer(identifier: "ICloud.Brian-Naszradi.RosterTableView")
    
    func eventsQuery(tName: String) -> (resultsNameArray: Array<String>, resultsDateArray: Array<Date>) {
     
     
        var resultsNameArray = [] as Array<String>
       
        var resultsDateArray = [] as Array<Date>
        
       print("tName in QueryEvents: ", tName)
         
         let eventsPredicate = NSPredicate(format: "team == %@", tName)
        // print("teamPredicate: ", teamPredicate)
         
         let query = CKQuery(recordType: "events", predicate: eventsPredicate)
        
        // This sortDescriptor doesn't work
       // query.sortDescriptors = [NSSortDescriptor(key: "eventDate", ascending: true)]
         
         let qOperation = CKQueryOperation.init(query: query)
        
         qOperation.resultsLimit = 25
         print("qOperation resultsLimit: ", qOperation.resultsLimit)
    
     //    qOperation.recordFetchedBlock = { record in
     
     qOperation.recordFetchedBlock = { (record : CKRecord!) in
            
              let name = [record.value(forKey: "eventName") as! String]
              
             resultsNameArray.append(contentsOf: name)
        
             let date = [record.value(forKey: "eventDate") as! Date]
        
             resultsDateArray.append(contentsOf: date)
             
             
              }  //recordFetchedBlock
              
     CKContainer.default().publicCloudDatabase.add(qOperation)
     
     
         qOperation.queryCompletionBlock = { cursor, error in
                    
             
             print("ResultsNameArray in CompletionBlock: ", resultsNameArray)
              
             let queryCount = resultsNameArray.count
            
             print("Number rows in array in queryCompletionBlock: ", queryCount)
          
         } // qOperttion queryCompletionBlock
       
     
      print("ResultsNameArray before loop: ", resultsNameArray)
     
     var counter: Int = 0
     while counter <= 700000000 {
         counter += 1
     } // while loop
     print("Counter: ", counter)
     
     print("ResultsArray after loop: ", resultsNameArray)
     
    return (resultsNameArray, resultsDateArray)
    
  } //eventsQuery func
   
  
    // May be able to delete this function
    /*
    //Query for a single event and return recordID
    
    func singleEventQuery(tName: String, eDate: Date) -> CKRecord {
     
     
        var results = CKRecord(recordType: "events")
        
        
     
      // print("tName in DataLoader: ", tName)
         
        let eventsPredicate = NSPredicate(format: "team == %@ AND eventDate == %@", tName, eDate as CVarArg)
        
        // print("teamPredicate: ", teamPredicate)
         
         let query = CKQuery(recordType: "events", predicate: eventsPredicate)
        
        // This sortDescriptor doesn't work
       // query.sortDescriptors = [NSSortDescriptor(key: "eventDate", ascending: true)]
         
         let qOperation = CKQueryOperation.init(query: query)
        
         qOperation.resultsLimit = 25
         print("qOperation resultsLimit: ", qOperation.resultsLimit)
    
     //    qOperation.recordFetchedBlock = { record in
     
     qOperation.recordFetchedBlock = { (record : CKRecord!) in
            
              let name = [record.value(forKey: "eventName") as! String]
              
             resultsNameArray.append(contentsOf: name)
        
             let date = [record.value(forKey: "eventDate") as! Date]
        
             resultsDateArray.append(contentsOf: date)
             
             
              }  //recordFetchedBlock
              
     CKContainer.default().publicCloudDatabase.add(qOperation)
     
     
         qOperation.queryCompletionBlock = { cursor, error in
                    
             
             print("ResultsNameArray in CompletionBlock: ", resultsNameArray)
              
             let queryCount = resultsNameArray.count
            
             print("Number rows in array in queryCompletionBlock: ", queryCount)
          
         } // qOperttion queryCompletionBlock
       
     
      print("ResultsNameArray before loop: ", resultsNameArray)
     
     var counter: Int = 0
     while counter <= 700000000 {
         counter += 1
     } // while loop
     print("Counter: ", counter)
     
     print("ResultsArray after loop: ", resultsNameArray)
     
    return (resultsNameArray, resultsDateArray)
    
  } //singleEventsQuery func

  */

    
  
}  // QueryEvents
