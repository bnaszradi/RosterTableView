//
//  TotalStats.swift
//  RosterTableView
//
//  Created by Brian Naszradi on 10/16/21.
//

import Foundation
import CloudKit
import UIKit

class TotalStats {
    
   
    let container = CloudKit.CKContainer(identifier: "ICloud.Brian-Naszradi.RosterTableView")
    
    
    let playerSearch = PlayerTeamData()
    
    let eventRecord = EventTeamCheck()
    

  //  func queryEventTotals(tName: String, eName: String, eDate: Date) -> (totAttempt: Array<Int>, totMake: Array<Int>, totPerShot: Array<Double>, totFlatDon: Array<Double>, totalDonation: Array<Double> )   {
    
    func queryEventTotals(tName: String, eName: String, eDate: Date, completion: @escaping (QqueryEventTotals)->Void) {
    
        var totAttemptArray = [] as Array<Int>
        var totMakeArray = [] as Array<Int>
        var totPerShotArray = [] as Array<Double>
        var totFlatDonArray = [] as Array<Double>
        var totalDonationArray = [] as Array<Double>
        
        
        let sponsorPredicate = NSPredicate(format: "team == %@ AND eventName == %@ AND eventDate == %@", tName, eName, eDate as CVarArg)
        
        let query = CKQuery(recordType: "donations", predicate: sponsorPredicate)
        
       // query.sortDescriptors = [NSSortDescriptor(key: "totalDonation", ascending: false)]

        let queryOp = CKQueryOperation(query: query)
        
        queryOp.resultsLimit = 25
       
        // This is non-structure data fetch
       queryOp.recordFetchedBlock = { record in
        
      // queryOp.recordFetchedBlock = { (record : CKRecord) in
              
          //  DispatchQueue.main.async {
              
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
        
      
        queryOp.queryCompletionBlock = { cursor, error in
            
            let qqueryEventTotals = QqueryEventTotals(totAttemptArray: totAttemptArray, totMakeArray: totMakeArray, totPerShotArray: totPerShotArray, totFlatDonArray: totFlatDonArray, totalDonationArray: totalDonationArray)
            
            completion(qqueryEventTotals)
            
         
        } // qOperttion queryCompletionBlock
    
        
        
        
        CKContainer.default().publicCloudDatabase.add(queryOp)
    
    
       
   /*
    
   // if playerArray.isEmpty  {
       
        var counter: Int = 0
        while counter <= 700000000 {
            counter += 1
        } // while loop
       
        print("Counter: ", counter)
        
        //print("results before return: ", results)
        
        return (totAttemptArray, totMakeArray, totPerShotArray, totFlatDonArray, totalDonationArray)
   */
        
 } // queryEventTotals

    
    
    
    
} // TotalStats
