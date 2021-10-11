//
//  PlayerStatsCollectionViewController.swift
//  RosterTableView
//
//  Created by Brian Naszradi on 3/13/21.
//

import UIKit
import CloudKit

// private let reuseIdentifier = "Cell"

class PlayerStatsCollectionViewController: UICollectionViewController {

    
    let container = CloudKit.CKContainer(identifier: "ICloud.Brian-Naszradi.RosterTableView")

    
    var player: String = ""
    var team: String = ""
    
   // var teamRefe: CKRecord.ID = CKRecord.ID()
    
    let playerTeamData = PlayerTeamData()
    
    let statsDataLoad = StatsDataLoad()
    
    var eventName: String = ""
    var eDate: Date = Date()
    
   // var eventPlayerVariable: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
      //  var playerRecord = playerTeam.queryPlayer(pName: player, team: team)
        
      //  resultsArray = playerManager.playerQuery(pName: player, teamRecord: playerRecord)
       
        
    } //viewDidLoad

    

   // if eventPlayerVariable == false {
    
    
    //code to fetch the CKRecord.ID from team DB for player and teamName fields
   lazy var playerRecord = playerTeamData.queryPlayer(pName: player, team: team)
    
   
   lazy var resultsArray = statsDataLoad.playerQuery(pName: player, teamRecord: playerRecord)
   
  
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    } //numberOfSections


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let statsLength = resultsArray.playerArray.count
         
        // let statsLength = resultsArray.count
         print("statsLength in PlayerCollectionViewController: ", statsLength)
         
         return statsLength
        
    }  // numberOfItemsInSection

    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        var playerCell = PlayerStatsCollectionViewCell()
        
        if let playCell = collectionView.dequeueReusableCell(withReuseIdentifier: "playerCell", for: indexPath) as? PlayerStatsCollectionViewCell {
        
            playCell.player.text = resultsArray.playerArray[indexPath.row]
            
            
            playCell.attempts.text = String(resultsArray.attemptArray[indexPath.row])
            
            playCell.makes.text = String(resultsArray.makesArray[indexPath.row])
           
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short
            dateFormatter.timeStyle = .short
            
            
           playCell.dateCreated.text = dateFormatter.string(from: resultsArray.dateArray[indexPath.row])
            
           playCell.percentage.text = String(resultsArray.percentArray[indexPath.row])
            
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

    

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

        
        
}  //PlayerStatsCollectionViewController
