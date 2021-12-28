//
//  EventPlayerStatsCollectionViewController.swift
//  RosterTableView
//
//  Created by Brian Naszradi on 9/20/21.
//

import UIKit
import CloudKit

// private let reuseIdentifier = "Cell"

class EventPlayerStatsCollectionViewController: UICollectionViewController {

    
    let container = CloudKit.CKContainer(identifier: "ICloud.Brian-Naszradi.RosterTableView")

    
    var player: String = ""
    var team: String = ""
    
   // var teamRefe: CKRecord.ID = CKRecord.ID()
    
    let playerTeamData = PlayerTeamData()
    
    let statsDataLoad = StatsDataLoad()
    
    var eventName: String = ""
    var eDate: Date = Date()
    
    var eventPlayerVariable: Bool = false
    
    var playerArray = [] as Array<String>
    var dateArray = [] as Array<Date>
    var attemptArray = [] as Array<Int>
    var makesArray = [] as Array<Int>
    var percentArray = [] as Array<Double>
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Code to fetch the CKRecord.ID from event DB for team, eName, eDate
        playerTeamData.queryPlayerEvent(team: team, eventName: eventName, eventDate: eDate, completion: { qqueryPlayerEvent in
            
            DispatchQueue.main.async {
              
            let eventRecord = qqueryPlayerEvent.results
                
        // Code to query player DB for records for event with CKRecord.ID
               
        // lazy var resultsArray = statsDataLoad.eventPlayerQuery(pName: player, eventRecord: eventRecord)
            self.statsDataLoad.eventPlayerQuery(pName: self.player, eventRecord: eventRecord, completion: { qeventPlayerQuery in
                    
                DispatchQueue.main.async {
                   
                self.playerArray = qeventPlayerQuery.playerArray
                    
                self.dateArray = qeventPlayerQuery.dateArray
            
                self.attemptArray = qeventPlayerQuery.attemptArray
                
                self.makesArray = qeventPlayerQuery.makesArray
        
                self.percentArray = qeventPlayerQuery.percentArray
                    
                self.collectionView.reloadData()
                    print("reloadData")
                      
                }  // DispatchQueue
                
            } )  // Completionhandler  statsDataLoad.eventPlayerQuery
                    
                
            }  // DispatchQueue
            
        } ) // Completionhandler playerTeamData.queryPlayerEvent
                
        
    } //viewDidLoad

    
    
    //code to fetch the CKRecord.ID from team DB for player and teamName fields
  // lazy var playerRecord = playerTeam.queryPlayer(pName: player, team: team)
    
    
    // Code to fetch the CKRecord.ID from event DB for team, eName, eDate
  //  lazy var eventRecord = playerTeamData.queryPlayerEvent(team: team, eventName: eventName, eventDate: eDate)

   // let playerID = playerRecord.recordID
    
    
  //  let recordToMatch = CKRecord.Reference(recordID: playerID, action: .deleteSelf)
    
  // lazy var resultsArray = playerManager.playerQuery(pName: player, teamRecord: playerRecord)
   
    // Code to query player DB for records for event with CKRecord.ID
   
   // lazy var resultsArray = statsDataLoad.eventPlayerQuery(pName: player, eventRecord: eventRecord)
    
   
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    } //numberOfSections


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
      //  let statsLength = resultsArray.playerArray.count
        let statsLength = playerArray.count
        
        // let statsLength = resultsArray.count
         print("statsLength in PlayerCollectionViewController: ", statsLength)
         
         return statsLength
        
    }  // numberOfItemsInSection

    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        var playerCell = EventPlayerStatsCollectionViewCell()
        
        if let playCell = collectionView.dequeueReusableCell(withReuseIdentifier: "eventPlayerCell", for: indexPath) as? EventPlayerStatsCollectionViewCell {
        
         //   playCell.player.text = resultsArray.playerArray[indexPath.row]
            playCell.player.text = playerArray[indexPath.row]
            
          //  playCell.attempts.text = String(resultsArray.attemptArray[indexPath.row])
            playCell.attempts.text = String(attemptArray[indexPath.row])
              
         //   playCell.makes.text = String(resultsArray.makesArray[indexPath.row])
            playCell.makes.text = String(makesArray[indexPath.row])
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short
            dateFormatter.timeStyle = .short
            
            
         //  playCell.dateCreated.text = dateFormatter.string(from: resultsArray.dateArray[indexPath.row])
            playCell.dateCreated.text = dateFormatter.string(from: dateArray[indexPath.row])
            
          // playCell.percentage.text = String(resultsArray.percentArray[indexPath.row])
            playCell.percentage.text = String(percentArray[indexPath.row])
            
            playerCell = playCell
            
        } //playerCell
            
            
        return playerCell
        
    }  //cellForAtItem
        
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if segue.identifier == "BacktoStatsViewController" {
          //  if segue.destination is PlayerManagement {
                    print("BacktoStatsViewControlle Segue")
             
               
                    let vcRoster = segue.destination as! UINavigationController
                   
                    let vcScore = vcRoster.viewControllers.first as! StatsViewController
                    
                   
              //  vcScore.title = self.team
                vcScore.tName = self.team
            
                print("vcScore.team ", vcScore.tName)
            
        } // if segue to RosterviewController
            
        } // prepare func

    

    
   
}  // EventPlayerStatsCollectionViewController
