//
//  DonationStatsCollectionViewController.swift
//  RosterTableView
//
//  Created by Brian Naszradi on 7/28/21.
//

import UIKit
import CloudKit

private let reuseIdentifier = "Cell"

class DonationStatsCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    
   // var player: String = ""
    var team: String = ""
    var eventName: String = ""
    var eDate: Date = Date()
    var donationVariable: Bool = false
    var eventPlayerVariable: Bool = false
    
    let updateDonationTotals = UpdateDonationsTotals()
     
    
    var playerArray = [] as Array<String>
    var totAttemptArray = [] as Array<Int>
    var totMakeArray = [] as Array<Int>
    var totPerShotArray = [] as Array<Double>
    var totFlatDonArray = [] as Array<Double>
    var totalDonationArray = [] as Array<Double>
    

    
   let container = CloudKit.CKContainer(identifier: "ICloud.Brian-Naszradi.RosterTableView")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
       self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        
        updateDonationTotals.queryDonationWithShots(tName: team, eDate: eDate, completion: { qqueryDonationWithShots in
            
            DispatchQueue.main.async {
                
            self.playerArray = qqueryDonationWithShots.playerArray
               
            self.totAttemptArray = qqueryDonationWithShots.totAttemptArray
                
            self.totMakeArray = qqueryDonationWithShots.totMakeArray
                
            self.totPerShotArray = qqueryDonationWithShots.totPerShotArray
                
            self.totFlatDonArray = qqueryDonationWithShots.totFlatDonArray
                
            self.totalDonationArray = qqueryDonationWithShots.totalDonationArray
                
            self.collectionView.reloadData()
            print("reloadData")
                 
                
                
            }  // DispatchQueue
            
        } ) // completionhandler updateDonationTotals.queryDonationWithShots
                
    }  // viewDidLoad

    
    
    @IBOutlet weak var DonationStatsCollectionViewFlowViewController: UICollectionViewFlowLayout!
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let height = view.frame.size.height
        let width = view.frame.size.width
        
        return CGSize(width: width, height: height * 0.15)
        
    } // CollectionViewLayout
    
    
    
    
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var headerView = DonationStatsReusableView()
        
       if let headerViewText = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerViewText", for: indexPath) as? DonationStatsReusableView {
        
           headerViewText.eventN.text = self.eventName
               
           let dateFormatter = DateFormatter()
               
           dateFormatter.dateStyle = .short
             //  dateFormatter.dateFormat = "EEEE MMM d, yyyy"
              // dateFormatter.timeStyle = .short
               
           let eventDat =  dateFormatter.string(from: self.eDate)
               
           headerViewText.eventD.text = eventDat
           
           headerView = headerViewText
           
       } // if headerViewText
        
        
        return headerView
    } // collectionView for viewForSupplementary
    
    
    
    
  //  lazy var resultsArray = updateDonationTotals.queryDonationWithShots(tName: team, eDate: eDate)
    
   

    
    // Code for selecting cell
    func locationItem(at index:IndexPath) -> String {
        playerArray[index.item]
    } //locationItem func
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
   
    } // numberOfSections


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let resultsLength = playerArray.count
        
        return resultsLength
        
    }  //numberOfItemsInSection

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
        var donationCell = DonationStatsCollectionViewCell()
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "donationCell", for: indexPath) as? DonationStatsCollectionViewCell {
        
    
          //  cell.player.text = resultsArray.playerN[indexPath.row]
            cell.player.text = playerArray[indexPath.row]
            
            
          //  cell.attempts.text = String(resultsArray.totAttempt[indexPath.row])
            cell.attempts.text = String(totAttemptArray[indexPath.row])
            
          //  cell.makes.text = String(resultsArray.totMake[indexPath.row])
            cell.makes.text = String(totMakeArray[indexPath.row])
            
          //  cell.totalDonation.text = String(resultsArray.totalDonation[indexPath.row])
            cell.totalDonation.text = String(totalDonationArray[indexPath.row])
            
          //  cell.perShot.text = String(resultsArray.totPerShot[indexPath.row])
            cell.perShot.text = String(totPerShotArray[indexPath.row])
            
          //  cell.flat.text = String(resultsArray.totFlatDon[indexPath.row])
            cell.flat.text = String(totFlatDonArray[indexPath.row])
            
        
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
            let Title = selectedPlayer
            //Title.append(" ")
            //Title.append(eventName)
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
            
            
            let Title = team
           // Title.append(" ")
           // Title.append(selectedPlayer)
         //   var Title = selectedPlayer
            //    Title.append(" ")
            //    Title.append(eventName)
          //  let Title = eventName
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
