//
//  StatsCollectionViewController.swift
//  RosterTableView
//
//  Created by Brian Naszradi on 1/30/21.
//

import UIKit
import CloudKit

//private let reuseIdentifier = "playerCell"

class StatsCollectionViewController: UICollectionViewController {

    var player: String = ""
    var team: String = ""
    
    
   let container = CloudKit.CKContainer(identifier: "ICloud.Brian-Naszradi.RosterTableView")
    
    
  //  let teamManager = TeamDataLoad()
    
   let manager = StatsDataLoad()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

     
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
    /*   self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier )
      */
        // Do any additional setup after loading the view.
      
    }  //viewDidLoad

   
   lazy var resultsArray = manager.rosterQuery(pName: player, team: team)
    
    
    // Code from Tableview
    func locationItem(at index:IndexPath) -> String {
        resultsArray.playerArray[index.item]
    } //locationItem func
    

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
       // print("player in numberOfSections: ", player)
       // print("team in numberOfSection: ", team)
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
       let statsLength = resultsArray.playerArray.count
        
       // let statsLength = resultsArray.count
        print("statsLength in CollectionViewController: ", statsLength)
        
        return statsLength
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var playerCell = StatsCollectionViewCell()
        
        if let playCell = collectionView.dequeueReusableCell(withReuseIdentifier: "playerCell", for: indexPath) as? StatsCollectionViewCell {
        
        //let item = player
            
            // this code doesn't run yet
           // let playerResults: Array =   [RosterTableView.StatsDataLoad.PlayerNames(player: "player" )]
        
        
         //  playCell.configure(with: resultsArray[indexPath.row] )
           
            //  This one works with a single data type: player in resultsArray
          //  playCell.configure(with: player: resultsArray.playerResults, shot: resultsArray.shot, dateCreated: resultsArray.date[indexPath.row]
          
           // playCell.configure(with: resultsArray[indexPath.row] as! String
            
                            
            
           // print("resultsArray: ", resultsArray)
           // print("teamResults: ", teamResults)
            
            //  This one works with a single data type: player in resultsArray
           // playCell.player.text = resultsArray[indexPath.row] as? String
           
            playCell.player.text = resultsArray.playerArray[indexPath.row]
            
            
            playCell.attempts.text = String(resultsArray.attemptArray[indexPath.row])
            
            playCell.makes.text = String(resultsArray.makesArray[indexPath.row])
           
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short
            dateFormatter.timeStyle = .short
            
           // let dateString = dateFormatter.string(from: )
        
 
          // playCell.dateCreated.text =  String(resultsArray.dateArray[indexPath.row])
            
           playCell.dateCreated.text = dateFormatter.string(from: resultsArray.dateArray[indexPath.row])
            
           playCell.percentage.text = String(resultsArray.percentArray[indexPath.row])
            
          //  playCell.teamRef.text = String(resultsArray.teamRefer[indexPath.row])
            
            //This displays the cells and row numbers
            //  playCell.player.text = String(resultsArray.index(after: indexPath.row))
            
           
            
            
           // print("resultsArray: ", resultsArray[indexPath.row])
            
            playerCell = playCell
            
           // print("playerCell: ", playerCell)
        
        // Configure the cell
    
        } // playCell
        
        return playerCell
      
    }  // cellForItemAT

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

   
    
    
    
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
       
        let selectedPlayer = locationItem(at: indexPath)
        print("selectedPlayer: ", selectedPlayer)
      
        performSegue(withIdentifier: "toPlayerStats", sender: selectedPlayer)
        
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Any?
        
        print("seque: ", segue)
        print("sender: ", sender as Any)
       /*
        let vcTeam = segue.destination as! UINavigationController
       
        let vcStats = vcTeam.viewControllers.first as! PlayerStatsCollectionViewController
        
        */
       // print("selectedPlayer in prepare: ", selectedPlayer)
        if let selectedPlayer = sender as? String {
        
            let vcTeam = segue.destination as! UINavigationController
           
            let vcStats = vcTeam.viewControllers.first as! PlayerStatsCollectionViewController
            
            
            
            vcStats.player = selectedPlayer
       
        print("vcStats.player: ", vcStats.player)
           
        vcStats.team = self.team
        print("vcStats.team: ", vcStats.team)
       
            // This doesn't display on title
         //   vcStats.title = self.player
            
            // this does display name as title
          //  vcStats.title = vcStats.player
            vcStats.title = vcStats.team
            
            
         
        print("vcStats.title: ", vcStats.title as Any)
            
        } // if selecterdPlayer
      
        /*
        vcStats.title = self.player
        print("vcStats.title: ", vcStats.title as Any)
        */
        
        } // prepare func
    
    
    
    
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

    
    
    @IBAction func unwindPlayerStatsCollectionViewControllerCancel(segue: UIStoryboardSegue) {
     }  // UIStoryboardSegue
    
    
    
} //StatsCollectionViewController
