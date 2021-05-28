//
//  ScoreData.swift
//  RosterTableView
//
//  Created by Brian Naszradi on 1/14/21.
//

import Foundation
import UIKit
import CloudKit


class ScoreDataLoader  {

    // (pName: String, sType: String, attempts: Int, percent: Double )
    
    var pName: String
       
    var sType: String
       
    var attempts: Int
       
    var percent: Int
   
        
   init (pName: String, sType: String, attempts: Int, percent: Int) {
        self.pName = pName
        self.sType = sType
        self.attempts = attempts
        self.percent = percent
    }   //init
    
   
    let container = CloudKit.CKContainer(identifier: "ICloud.Brian-Naszradi.RosterTableView")

    let recordPlayer = CKRecord(recordType: "playerName")
    
    
    func recordScore ()  {
    recordPlayer["player"] = pName
    
    recordPlayer["shot"] = sType
    
    recordPlayer["shotAttempts"] = attempts
    
    recordPlayer["shotpercentage"] = percent
    
        CKContainer.default().publicCloudDatabase.save(recordPlayer) { record, error in
            DispatchQueue.main.async {
               if error == nil {
                    
                } else {
                   let ac = UIAlertController(title: "Error", message: "There was a problem submitting your data \(error!.localizedDescription)", preferredStyle: .alert)
                   ac.addAction(UIAlertAction(title: "OK", style: .default))
                  //  self.persent(ac, animated: true)
                }  // else
                
          } //if error
         } // DispatchQueue
        
   }  // func recordScore
    
    
    
}  // ScoreDataLoader
