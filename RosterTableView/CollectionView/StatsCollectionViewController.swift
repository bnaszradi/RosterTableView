//
//  StatsCollectionViewController.swift
//  RosterTableView
//
//  Created by Brian Naszradi on 1/30/21.
//

import UIKit
import CloudKit

//private let reuseIdentifier = "playerCell"

class StatsCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var player: String = ""
    var team: String = ""
    
    
   let container = CloudKit.CKContainer(identifier: "ICloud.Brian-Naszradi.RosterTableView")
    
 
   let statsDataLoad = StatsDataLoad()
    
    var playerArray = [] as Array<String>
    var dateArray = [] as Array<Date>
    var attemptArray = [] as Array<Int>
    var makesArray = [] as Array<Int>
    var percentArray = [] as Array<Double>
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        
        statsDataLoad.rosterQuery(pName: player, team: team, completion: { qResults in
            
            DispatchQueue.main.async {
                
           // self.queryResults = qResults
        
                self.playerArray = qResults.playerArray
                
                self.dateArray = qResults.dateArray
            
                self.attemptArray = qResults.attemptArray
                
                self.makesArray = qResults.makesArray
                
                self.percentArray = qResults.percentArray
               
  
                print("# in playerArray: ", self.playerArray.count as Any)
                
                
               self.collectionView.reloadData()
               print("reloadData")
                
               print("playerArray after reloadData: ", self.playerArray as Any)
                
                
            } //DispatchQueue
           
    
            
        } ) // completion
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
    /*   self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier )
      */
       
    }  //viewDidLoad

    
    
    
    @IBOutlet weak var StatsCollectionViewFlowViewController: UICollectionViewFlowLayout!
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let height = view.frame.size.height
        let width = view.frame.size.width
        
        return CGSize(width: width, height: height * 0.15)
        
        
    } // CollectionViewLayout
    
    
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath)
        return headerView
    } // collectionView for viewForSupplementary
    
    
    
    
 //  lazy var resultsArray = statsDataLoad.rosterQuery(pName: player, team: team)
    
    
    // Code for selecting cell
    func locationItem(at index:IndexPath) -> String {
        self.playerArray[index.item]
    } //locationItem func
    

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
       let statsLength = self.playerArray.count
        
      //  print("statsLength in CollectionViewController: ", statsLength)
        
        return statsLength
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var playerCell = StatsCollectionViewCell()
        
        if let playCell = collectionView.dequeueReusableCell(withReuseIdentifier: "playerCell", for: indexPath) as? StatsCollectionViewCell {
        
       
            playCell.player.text = self.playerArray[indexPath.row]
            
            
            playCell.attempts.text = String(self.attemptArray[indexPath.row])
            
            playCell.makes.text = String(self.makesArray[indexPath.row])
           
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short
            dateFormatter.timeStyle = .short
            
           // let dateString = dateFormatter.string(from: )
        
          // playCell.dateCreated.text =  String(resultsArray.dateArray[indexPath.row])
            
           playCell.dateCreated.text = dateFormatter.string(from: self.dateArray[indexPath.row])
            
           playCell.percentage.text = String(self.percentArray[indexPath.row])
            
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
       
       // print("vcStats.player: ", vcStats.player)
           
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
