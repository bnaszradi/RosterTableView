//
//  SponsorsList.swift
//  RosterTableView
//
//  Created by Brian Naszradi on 6/27/21.
//

import Foundation
import CloudKit


class SponsorsList {
    
    //sponsorsQuery function
    //sponsorRecordQuery
    //querySponsor
    //sponsorPhoneQuery
    
    
    let container = CloudKit.CKContainer(identifier: "ICloud.Brian-Naszradi.RosterTableView")
    
    func sponsorsQuery(tName: String, pName: String, eDate: Date) -> (resultsSponsorArray: Array<String>, resultsAmountPerArray: Array<Double>, resultsDonationArray: Array<Double>) {
     
        var resultsSponsorArray = [] as Array<String>
       
        var resultsAmountArray = [] as Array<Double>
        
        var resultsDonationArray = [] as Array<Double>
        
     
      print("tName in SponsorList: ", tName)
        
      print("pName in SponsorList: ", pName)
        
      print("eDate in SponsorList: ", eDate)
       
        
        
      // This predicate does work
       let eventsPredicate = NSPredicate(format: "team == %@ AND player == %@ AND eventDate == %@" , tName, pName, eDate as CVarArg)
        
      // let eventsPredicate = NSPredicate(format: "team == %@ AND player == %@" , tName, pName)
        
       // This code does provide results
      //  let eventsPredicate = NSPredicate(format: "team == %@ AND eventDate > %@" , tName, eDate as CVarArg)
        
        
        // print("teamPredicate: ", teamPredicate)
         
         let query = CKQuery(recordType: "sponsor", predicate: eventsPredicate)
        
        // This sort doesn't work because the totalDonation field is calculated and not in the sponsor DB
       // query.sortDescriptors = [NSSortDescriptor(key: "totalDonation", ascending: false)]
        
         
         let qOperation = CKQueryOperation.init(query: query)
        
         qOperation.resultsLimit = 25
         print("qOperation resultsLimit: ", qOperation.resultsLimit)
    
     //    qOperation.recordFetchedBlock = { record in
     
     qOperation.recordFetchedBlock = { (record : CKRecord!) in
            
              let sponsor = [record.value(forKey: "sponsorName") as! String]
              
             resultsSponsorArray.append(contentsOf: sponsor)
        
             let amount = [record.value(forKey: "amountperShot") as! Double]
        
             resultsAmountArray.append(contentsOf: amount)
        
        
             let donation = [record.value(forKey: "donation") as! Double]
   
             resultsDonationArray.append(contentsOf: donation)

        
        
             /*
             let date = [record.value(forKey: "eventDate") as! Date]
        
             resultsDateArray.append(contentsOf: date)
             */
             
              }  //recordFetchedBlock
              
     CKContainer.default().publicCloudDatabase.add(qOperation)
     
     
         qOperation.queryCompletionBlock = { cursor, error in
                    
             
             print("ResultsSponsorArray in CompletionBlock: ", resultsSponsorArray)
              
             let queryCount = resultsSponsorArray.count
            
             print("Number rows in array in queryCompletionBlock: ", queryCount)
          
         } // qOperttion queryCompletionBlock
       
     
      print("ResultsSponsorArray before loop: ", resultsSponsorArray)
     
     var counter: Int = 0
     while counter <= 700000000 {
         counter += 1
     } // while loop
     print("Counter: ", counter)
     
     print("ResultsArray after loop: ", resultsSponsorArray)
     
    return (resultsSponsorArray, resultsAmountArray, resultsDonationArray)
    
  } //eventsQuery func
   
    
    func sponsorRecordQuery(tName: String, pName: String, eDate: Date, sponsorN: String) -> (sponsorArray: Array<String>, perShotArray: Array<Double>, donationArray: Array<Double>)  {
        
        
        var sponsorArray = [] as Array<String>
        var perShotArray = [] as Array<Double>
        var donationArray = [] as Array<Double>
        
        print("tname in sponsorRecordQuery: ", tName)
        
        print("pName in sponsorRecordQuery: ", pName)
        
        print("eDate in sponsorRecordQuery: ", eDate)
        
        print("sponsorN in sponsorRecordQuery: ", sponsorN)
        
        
       let sponsorPredicate = NSPredicate(format: "team == %@ AND player == %@ AND eventDate == %@ AND sponsorName == %@" , tName, pName, eDate as CVarArg, sponsorN)
        
        
        
        // search without team and eventDate
      // let sponsorPredicate = NSPredicate(format: "player == %@ AND sponsorName == %@", pName, sponsorN)
          
        
        let query = CKQuery(recordType: "sponsor", predicate: sponsorPredicate)
        
        let qOperation = CKQueryOperation.init(query: query)
       
        qOperation.resultsLimit = 25
      // print("qOperation resultsLimit: ", qOperation.resultsLimit)
   
      qOperation.recordFetchedBlock = { record in
        
        let sponsor = record["sponsorName"] as! String
        sponsorArray.append(sponsor)
        print("sponsor in recordFetchedblock: ", sponsor)
        
        let perShot = record["amountperShot"] as! Double
        perShotArray.append(perShot)
        
        let donation = record["donation"] as! Double
        donationArray.append(donation)
        
        
        
   /*
   qOperation.recordFetchedBlock = { (record : CKRecord!) in
    
    let sponsor = [record.value(forKey: "sponsorName") as! String]
    
   resultsSponsorArray.append(contentsOf: sponsor)
   */
    
    let sponsorNum = sponsorArray.count
    
    print("sponsorNum: ", sponsorNum)

   }  //recordFetchedBlock
    
    
    CKContainer.default().publicCloudDatabase.add(qOperation)
    
    
        qOperation.queryCompletionBlock = { cursor, error in
                   
            
            print("ResultsSponsorArray in CompletionBlock: ", sponsorArray)
             
            let queryCount = sponsorArray.count
           
            print("Number rows in array in queryCompletionBlock: ", queryCount)
         
        } // qOperttion queryCompletionBlock
      
    
     print("ResultsSponsorArray before loop: ", sponsorArray)
    
    var counter: Int = 0
    while counter <= 700000000 {
        counter += 1
    } // while loop
    print("Counter: ", counter)
    
    print("ResultsArray after loop: ", sponsorArray)
    
   return (sponsorArray, perShotArray, donationArray)

    
    } // sponsorRecordQuery
    
    
    
    func querySponsor(tName: String, pName: String, eDate: Date, sponsorN: String) -> CKRecord.ID   {
    
   
        print("team in EventTeamCheck: ", tName)
        
         
      //  var resultsID =  (recordType: "events")
    
        var resultsID: CKRecord.ID = CKRecord.ID()
        
        
        let sponsorPredicate = NSPredicate(format: "team == %@ AND player == %@ AND eventDate == %@ AND sponsorName ==%@" , tName, pName, eDate as CVarArg, sponsorN)
        
        
        let query = CKQuery(recordType: "sponsor", predicate: sponsorPredicate)
        
        query.sortDescriptors = [NSSortDescriptor(key: "donation", ascending: false)]
         
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
            let recordResults = record.recordID
            
            resultsID = recordResults
            
           // results = recordResults
            
        
           // print("results in FetchedBlock: ", results)
            
            print("recordID for results in FetchedBlock: ", recordResults)
            
          //  }  // DispatchQueue
             
             
                 }  //recordFetchedBlock
        
      
   // CKContainer.default().publicCloudDatabase.add(qOperation)
        CKContainer.default().publicCloudDatabase.add(queryOp)
    
    
      //  qOperation.queryCompletionBlock = { cursor, error in
        queryOp.queryCompletionBlock = { cursor, error in
            
         
        } // qOperttion queryCompletionBlock
    
   
    
   // if playerArray.isEmpty  {
       
        var counter: Int = 0
        while counter <= 700000000 {
            counter += 1
        } // while loop
       
        print("Counter: ", counter)
        
        print("results before return: ", resultsID)
        
        return resultsID
   
 } // querySponsor


    func sponsorPhoneQuery(tName: String, pName: String, eDate: Date, sponsorN: String) -> (phoneN: Int, perShot: Double, donation: Double) {
        
    
        var sponsorPhone: Int = 0
        var perShot: Double = 0.0
        var donation: Double = 0.0
        
        
       let sponsorPredicate = NSPredicate(format: "team == %@ AND player == %@ AND eventDate == %@ AND sponsorName == %@" , tName, pName, eDate as CVarArg, sponsorN)
        
        
        let query = CKQuery(recordType: "sponsor", predicate: sponsorPredicate)
        
        let qOperation = CKQueryOperation.init(query: query)
       
        qOperation.resultsLimit = 25
      // print("qOperation resultsLimit: ", qOperation.resultsLimit)
   
      qOperation.recordFetchedBlock = { record in
        
         sponsorPhone = record["sponsorPhoneNumber"] as! Int
        
        perShot = record["amountperShot"] as! Double
        
        donation = record["donation"] as! Double
        
       // sponsorArray.append(sponsor)
       
   }  //recordFetchedBlock
    
    
    CKContainer.default().publicCloudDatabase.add(qOperation)
    
    
        qOperation.queryCompletionBlock = { cursor, error in
                   
        } // qOperttion queryCompletionBlock
      
    
   //  print("ResultsSponsorArray before loop: ", sponsorArray)
    
    var counter: Int = 0
    while counter <= 700000000 {
        counter += 1
    } // while loop
    print("Counter: ", counter)
    
   // print("ResultsArray after loop: ", sponsorArray)
    
   return (sponsorPhone, perShot, donation)

    
    } // sponsorPhoneQuery
    
    
    
    
    
  
}  // QueryEvents
