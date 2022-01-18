//
//  PlayerStatsCollectionViewController.swift
//  RosterTableView
//
//  Created by Brian Naszradi on 3/13/21.
//

import UIKit
import CloudKit

// private let reuseIdentifier = "Cell"

class PlayerStatsCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    
    let container = CloudKit.CKContainer(identifier: "ICloud.Brian-Naszradi.RosterTableView")

    
    var player: String = ""
    var team: String = ""
    
   // var teamRefe: CKRecord.ID = CKRecord.ID()
    
    let playerTeamData = PlayerTeamData()
    
    let statsDataLoad = StatsDataLoad()
    
    var eventName: String = ""
    var eDate: Date = Date()
    
    var results = CKRecord(recordType: "team")
    
    var playerArray = [] as Array<String>
   // var playerArray = ["Loading..."]
    
    var dateArray = [] as Array<Date>
    var attemptArray = [] as Array<Int>
    var makesArray = [] as Array<Int>
    var percentArray = [] as Array<Double>
    

    
   // var eventPlayerVariable: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        playerTeamData.queryPlayer(pName: player, team: team, completion: { qResults in
        
            
            DispatchQueue.main.sync {
                
           // self.queryResults = qResults
        
                self.results = qResults.playerRecord
                
                
                print("results in PlayerStatsViewController viewDidLoad: ", self.results as Any)
                
                
           } //DispatchQueue
          
        
            self.statsDataLoad.playerQuery(pName: self.player, teamRecord: self.results, completion: { playerQueryResults in
                
           
              DispatchQueue.main.async {
                    
                    self.playerArray = playerQueryResults.playerArray
                    
                    self.dateArray = playerQueryResults.dateArray
                    
                    self.attemptArray = playerQueryResults.attemptArray
              
                    self.makesArray = playerQueryResults.makesArray
                    
                    self.percentArray = playerQueryResults.percentArray
                    
                   
                   self.collectionView.reloadData()
                   print("reloadData")
                    
                    print("playerArray after reloadData ", self.playerArray as Any)
                
                } //DispatchQueue
               
            } ) // playerQueryResults completion
            
        
                
        } ) // qResults completion
    
 
        
    } //viewDidLoad

    

   // if eventPlayerVariable == false {
    
    
    //code to fetch the CKRecord.ID from team DB for player and teamName fields
  // lazy var playerRecord = playerTeamData.queryPlayer(pName: player, team: team)
    
   
 //  lazy var resultsArray = statsDataLoad.playerQuery(pName: player, teamRecord: playerRecord)
   
    
   
    @IBOutlet weak var PlayerStatsCollectionViewFlowViewController: UICollectionViewFlowLayout!
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let height = view.frame.size.height
        let width = view.frame.size.width
        
        return CGSize(width: width, height: height * 0.15)
        
    } // CollectionViewLayout
    
    
    
  
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    } //numberOfSections


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let statsLength = self.playerArray.count
         
        // let statsLength = resultsArray.count
         print("statsLength in PlayerCollectionViewController: ", statsLength)
         
         return statsLength
        
    }  // numberOfItemsInSection

    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        var playerCell = PlayerStatsCollectionViewCell()
        
        if let playCell = collectionView.dequeueReusableCell(withReuseIdentifier: "playerCell", for: indexPath) as? PlayerStatsCollectionViewCell {
        
            playCell.player.text = self.playerArray[indexPath.row]
            
            if self.attemptArray.count > 0 {
                
            playCell.attempts.text = String(self.attemptArray[indexPath.row])
            
            playCell.makes.text = String(self.makesArray[indexPath.row])
           
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short
            dateFormatter.timeStyle = .short
            
            
           playCell.dateCreated.text = dateFormatter.string(from: self.dateArray[indexPath.row])
            
           playCell.percentage.text = String(self.percentArray[indexPath.row])
          
            } // if attemptArray.count > 0
                
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
