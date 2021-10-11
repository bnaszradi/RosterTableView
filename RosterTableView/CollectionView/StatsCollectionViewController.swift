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
    
    
   
   let manager = StatsDataLoad()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
    /*   self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier )
      */
       
    }  //viewDidLoad

   
   lazy var resultsArray = manager.rosterQuery(pName: player, team: team)
    
    
    // Code for selecting cell
    func locationItem(at index:IndexPath) -> String {
        resultsArray.playerArray[index.item]
    } //locationItem func
    

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
       let statsLength = resultsArray.playerArray.count
        
      //  print("statsLength in CollectionViewController: ", statsLength)
        
        return statsLength
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var playerCell = StatsCollectionViewCell()
        
        if let playCell = collectionView.dequeueReusableCell(withReuseIdentifier: "playerCell", for: indexPath) as? StatsCollectionViewCell {
        
       
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
            
            playerCell = playCell
          
    
        } // playCell
        
        return playerCell
      
    }  // cellForItemAT

    
    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */


    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
       
        let selectedPlayer = locationItem(at: indexPath)
       // print("selectedPlayer: ", selectedPlayer)
      
        performSegue(withIdentifier: "toPlayerStats", sender: selectedPlayer)
        
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let selectedPlayer = sender as? String {
        
            let vcTeam = segue.destination as! UINavigationController
           
            let vcStats = vcTeam.viewControllers.first as! PlayerStatsCollectionViewController
            
            
        vcStats.player = selectedPlayer
       
        print("vcStats.player: ", vcStats.player)
           
        vcStats.team = self.team
        print("vcStats.team: ", vcStats.team)
       
        vcStats.title = vcStats.team
            
        print("vcStats.title: ", vcStats.title as Any)
            
        } // if selecterdPlayer
      
        
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
