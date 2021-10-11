//
//  DonationStatsCollectionViewController.swift
//  RosterTableView
//
//  Created by Brian Naszradi on 7/28/21.
//

import UIKit
import CloudKit

private let reuseIdentifier = "Cell"

class DonationStatsCollectionViewController: UICollectionViewController {

    
   // var player: String = ""
    var team: String = ""
    var eventName: String = ""
    var eDate: Date = Date()
    var donationVariable: Bool = false
    var eventPlayerVariable: Bool = false
    
   let container = CloudKit.CKContainer(identifier: "ICloud.Brian-Naszradi.RosterTableView")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
      //  self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        
    }  // viewDidLoad

    
    // Create donation query object
    let updateDonationTotals = UpdateDonationsTotals()
     
    
    lazy var resultsArray = updateDonationTotals.queryDonationWithShots(tName: team, eDate: eDate)
    
    
    // Code for selecting cell
    func locationItem(at index:IndexPath) -> String {
        resultsArray.playerN[index.item]
    } //locationItem func
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
   
    } // numberOfSections


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let resultsLength = resultsArray.playerN.count
        
        return resultsLength
        
    }  //numberOfItemsInSection

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
        var donationCell = DonationStatsCollectionViewCell()
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "donationCell", for: indexPath) as? DonationStatsCollectionViewCell {
        
    
            cell.player.text = resultsArray.playerN[indexPath.row]
            
            cell.attempts.text = String(resultsArray.totAttempt[indexPath.row])
            
            cell.makes.text = String(resultsArray.totMake[indexPath.row])
            
            cell.totalDonation.text = String(resultsArray.totalDonation[indexPath.row])
            
            cell.perShot.text = String(resultsArray.totPerShot[indexPath.row])
            
            cell.flat.text = String(resultsArray.totFlatDon[indexPath.row])
            
        
          donationCell = cell
            
        }  //cellForAtItem

        return donationCell
            
    }  //UIcollectionViewCell

    
    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
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
    
   
    
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
       
        let selectedPlayer = locationItem(at: indexPath)
        print("selectedPlayer: ", selectedPlayer)
      
        print("donationVariable in DonationStats: ", donationVariable)
        if donationVariable == true {
        
        performSegue(withIdentifier: "toSponsorStats", sender: selectedPlayer)
        } // if donationVariable = true
        
        print("eventPlayerVariable in DonationStats: ", eventPlayerVariable)
        if eventPlayerVariable == true {
            
            performSegue(withIdentifier: "toEventPlayerStats", sender: selectedPlayer)
            
        } //eventPlayerVariable = true
            
        return true
    } //shouldSelectItemAt
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
       
        if segue.identifier == "toSponsorStats" {
           if let selectedPlayer = sender as? String {
        
            let vcTeam = segue.destination as! UINavigationController
           
            let vcStats = vcTeam.viewControllers.first as! SponsorStatsCollectionViewController
            
            vcStats.player = selectedPlayer
            print("vcStats.player: ", vcStats.player)
           
            vcStats.team = self.team
            print("vcStats.team: ", vcStats.team)
            
            vcStats.eventName = self.eventName
            
            vcStats.eventDate = self.eDate
            print("vcStats.eDate: ", eDate)
            
            
           // var Title = team
           // Title.append(" ")
           // Title.append(selectedPlayer)
            var Title = selectedPlayer
            Title.append(" ")
            Title.append(eventName)
           // Title.append(eDate)
            
            vcStats.title = Title
            
            print("Title: ", Title)
        print("vcStats.team ", vcStats.team)
       // print("eventName: ", eventName)
           } // selectedPlayer
            
        } // if toSponsorStats
        
        if segue.identifier == "toEventPlayerStats" {
            
            if let selectedPlayer = sender as? String {
        
            let vcTeam = segue.destination as! UINavigationController
           
            let vcStats = vcTeam.viewControllers.first as! EventPlayerStatsCollectionViewController
            
        
            vcStats.player = selectedPlayer
            print("vcStats.player: ", vcStats.player)
           
            vcStats.team = self.team
            print("vcStats.team: ", vcStats.team)
            
           vcStats.eventName = self.eventName
           vcStats.eDate = self.eDate
            vcStats.eventPlayerVariable = eventPlayerVariable
            
           // vcStats.eventDate = self.eDate
          //  print("vcStats.eDate: ", eDate)
            
            
           // var Title = team
           // Title.append(" ")
           // Title.append(selectedPlayer)
            var Title = selectedPlayer
                Title.append(" ")
                Title.append(eventName)
           // Title.append(eDate)
            
            vcStats.title = Title
            
                print("Title: ", Title)
        print("vcStats.team ", vcStats.team)
       // print("eventName: ", eventName)
            
            } // selectedPlayer
            
        } // if toEventPlayerStats
        
        
        } // prepare func
    
    
    
    @IBAction func unwindSponsorStatsCollectionViewControllerCancel(segue: UIStoryboardSegue) {
     
    }  // UIStoryboardSegue
    
    
    @IBAction func unwindEventPlayerStatsCollectionViewControllerCancel(segue: UIStoryboardSegue) {
     
    }  // UIStoryboardSegue
    
    
    
    
}  //DonationStatsConllectionViewController
