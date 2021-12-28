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
    
  //  func sponsorsQuery(tName: String, pName: String, eDate: Date) -> (resultsSponsorArray: Array<String>, resultsAmountPerArray: Array<Double>, resultsDonationArray: Array<Double>) {
    
 //   func sponsorQuery(tName: String, pName: String, eDate: Date, completion: @escaping (QsponsorQuery)->Void) {
        
    func sponsorQuery(tName: String, pName: String, eDate: Date, eName: String,  completion: @escaping (QsponsorQuery)->Void) {
          
     
        var resultsSponsorArray = [] as Array<String>
       
        var resultsAmountArray = [] as Array<Double>
        
        var resultsDonationArray = [] as Array<Double>
        
     
      print("tName in SponsorList: ", tName)
        
      print("pName in SponsorList: ", pName)
        
      print("eDate in SponsorList: ", eDate)
        
      print("eName in SponsorList: ", eName)
         
        
      // This predicate does not work because the eName is not in the sponsor DB
     //  let eventsPredicate = NSPredicate(format: "team == %@ AND player == %@ AND eventDate == %@ AND eName == %@" , tName, pName, eDate as CVarArg, eName)
        
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
        // print("qOperation resultsLimit: ", qOperation.resultsLimit)
    
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
       
        qOperation.queryCompletionBlock = { cursor, error in
                   
            
            print("ResultsSponsorArray in CompletionBlock: ", resultsSponsorArray)
             
            let queryCount = resultsSponsorArray.count
           
            print("Number rows in array in queryCompletionBlock: ", queryCount)
            
            
            let qsponsorQuery = QsponsorQuery(resultsSponsorArray: resultsSponsorArray, resultsAmountArray: resultsAmountArray, resultsDonationArray: resultsDonationArray)
            
            completion(qsponsorQuery)
            
            
        } // qOperttion queryCompletionBlock
      
        
        
        
     CKContainer.default().publicCloudDatabase.add(qOperation)
     
     
        
    /*
      print("ResultsSponsorArray before loop: ", resultsSponsorArray)
     
     var counter: Int = 0
     while counter <= 700000000 {
         counter += 1
     } // while loop
     print("Counter: ", counter)
     
     print("ResultsArray after loop: ", resultsSponsorArray)
     
    return (resultsSponsorArray, resultsAmountArray, resultsDonationArray)
    
        */
        
  } //eventsQuery func
   
    
  //  func sponsorRecordQuery(tName: String, pName: String, eDate: Date, sponsorN: String) -> (sponsorArray: Array<String>, perShotArray: Array<Double>, donationArray: Array<Double>)  {
    
    func sponsorRecordQuery(tName: String, pName: String, eDate: Date, sponsorN: String, completion: @escaping (QsponsorRecordQuery)->Void) {
        
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
        
    
    let sponsorNum = sponsorArray.count
    
    print("sponsorNum: ", sponsorNum)

   }  //recordFetchedBlock
    
    
    qOperation.queryCompletionBlock = { cursor, error in
                   
            print("ResultsSponsorArray in CompletionBlock: ", sponsorArray)
             
            let queryCount = sponsorArray.count
           
            print("Number rows in array in queryCompletionBlock: ", queryCount)
        
        
        let qsponsorRecordQuery = QsponsorRecordQuery(sponsorArray: sponsorArray, perShotArray: perShotArray, donationArray: donationArray)
        
        completion(qsponsorRecordQuery)
        
        
        } // qOperttion queryCompletionBlock
      
        
    CKContainer.default().publicCloudDatabase.add(qOperation)
    
    
       
    /*
     print("ResultsSponsorArray before loop: ", sponsorArray)
    
    var counter: Int = 0
    while counter <= 700000000 {
        counter += 1
    } // while loop
    print("Counter: ", counter)
    
    print("ResultsArray after loop: ", sponsorArray)
    
   return (sponsorArray, perShotArray, donationArray)

    */
    } // sponsorRecordQuery
    
    
    
  //  func querySponsor(tName: String, pName: String, eDate: Date, sponsorN: String) -> CKRecord.ID   {
    
    func querySponsor(tName: String, pName: String, eDate: Date, sponsorN: String, completion: @escaping (QquerySponsor)->Void) {
   
        print("team in EventTeamCheck: ", tName)
        
      //  var resultsID =  (recordType: "events")
    
        var resultsID: CKRecord.ID = CKRecord.ID()
        
        
        let sponsorPredicate = NSPredicate(format: "team == %@ AND player == %@ AND eventDate == %@ AND sponsorName ==%@" , tName, pName, eDate as CVarArg, sponsorN)
        
        
        let query = CKQuery(recordType: "sponsor", predicate: sponsorPredicate)
        
        query.sortDescriptors = [NSSortDescriptor(key: "donation", ascending: false)]
         
        let queryOp = CKQueryOperation(query: query)
        
        queryOp.resultsLimit = 25
       
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
        
        
        queryOp.queryCompletionBlock = { cursor, error in
            
         let qquerySponsor = QquerySponsor(resultsID: resultsID)
            
            completion(qquerySponsor)
            
        } // qOperttion queryCompletionBlock
    
        
        CKContainer.default().publicCloudDatabase.add(queryOp)
    
    
      //  qOperation.queryCompletionBlock = { cursor, error in
       
   
    
        /*
   // if playerArray.isEmpty  {
       
        var counter: Int = 0
        while counter <= 700000000 {
            counter += 1
        } // while loop
       
        print("Counter: ", counter)
        
        print("results before return: ", resultsID)
        
        return resultsID
   
        */
        
 } // querySponsor


 //   func sponsorPhoneQuery(tName: String, pName: String, eDate: Date, sponsorN: String) -> (phoneN: Int, perShot: Double, donation: Double) {
       
    func sponsorPhoneQuery(tName: String, pName: String, eDate: Date, sponsorN: String, completion: @escaping (QsponsorPhoneQuery)->Void) {
    
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
    
        qOperation.queryCompletionBlock = { cursor, error in
              
            let qsponsorPhoneQuery = QsponsorPhoneQuery(sponsorPhone: sponsorPhone, perShot: perShot, donation: donation)
               
               completion(qsponsorPhoneQuery)
               
            
        } // qOperttion queryCompletionBlock
      
    CKContainer.default().publicCloudDatabase.add(qOperation)
    
    
       
    /*
   //  print("ResultsSponsorArray before loop: ", sponsorArray)
    
    var counter: Int = 0
    while counter <= 700000000 {
        counter += 1
    } // while loop
    print("Counter: ", counter)
    
   // print("ResultsArray after loop: ", sponsorArray)
    
   return (sponsorPhone, perShot, donation)

   */
    } // sponsorPhoneQuery
    

  
}  // QueryEvents
