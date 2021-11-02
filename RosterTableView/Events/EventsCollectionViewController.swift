//
//  EventsCollectionViewController.swift
//  RosterTableView
//
//  Created by Brian Naszradi on 6/13/21.
//

import UIKit
import CloudKit

private let reuseIdentifier = "Cell"

class EventsCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

       
    } // viewDidLoad

    
    let container = CKContainer(identifier: "ICloud.Brian-Naszradi.RosterTableView")
     
    
    var team: String = ""
    
   // var event: Bool = false
    
    var eventVariable: Bool = false
    
    var playerN: String = ""
    
    var eventN: String = ""
    
    var eventD: Date = Date()
    
    var donationVariable: Bool = false
    
    var scoreboardVariable: Bool = false
    
    var playerVariable: Bool = false
    
    var eventPlayerVariable: Bool = false
    
    var eventTotalsVariable: Bool = false
    
    let manager = QueryEvents()
    
    let updateDonationsTotals = UpdateDonationsTotals()
    
   
    // Add Datasource
    lazy var resultsArray = manager.eventsQuery(tName: team)
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    } // numberOfSections


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        let rosterLength = resultsArray.resultsNameArray.count
        
        return rosterLength
        
    } //numberOfItemsInSection

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        var eventsCell = EventsCollectionViewCell()
        
        if let eventCell = collectionView.dequeueReusableCell(withReuseIdentifier: "eventsCell", for: indexPath) as? EventsCollectionViewCell {
        
        
            eventCell.eventName.text = String(resultsArray.resultsNameArray[indexPath.row])
            
            let dateFormatter = DateFormatter()
            
            dateFormatter.dateStyle = .short
            dateFormatter.dateFormat = "EEEE MMM d, yyyy"
           // dateFormatter.timeStyle = .short
            
            
            eventCell.eventDate.text = dateFormatter.string(from: resultsArray.resultsDateArray[indexPath.row])
        
        
            //eventD = resultsArray.resultsDateArray[indexPath.row]
            
            
            eventsCell = eventCell
    
        } // eventCell
            
        return eventsCell
        
        
    }  // UICollectionViewCell

    
    // Go to Player Roster when event selected
   
    
    func locationName(at index:IndexPath) -> String {
       
        resultsArray.resultsNameArray[index.item]
       
    } //locationName func
    
    
    func locationDate(at index:IndexPath) -> Date {
       
        resultsArray.resultsDateArray[index.item]
       
    } //locationItem func

    

        override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
    
     
        let selectedEvent = locationName(at: indexPath)
        
        let selectedDate = locationDate(at: indexPath)
       
        print("selectedEvent in ECV: ", selectedEvent)
      
        eventN = selectedEvent
        
        eventD = selectedDate
        
        
        
        // Add condition to route to appropriate segue either toPlayerList or backToScoreboard or toDonationStats or TotalStats
        
        
        if eventVariable == true {
                performSegue(withIdentifier: "toEventMgmt", sender: selectedEvent)

            } //event segue
         
            
        if playerVariable == true {
            
        performSegue(withIdentifier: "toPlayerList", sender: selectedEvent)
   
        } //if toPlayerList
        
       
        if donationVariable == true {
            
            performSegue(withIdentifier: "toDonationStats", sender: selectedEvent)
            
        } // if toDonationStats
            
        
         if scoreboardVariable == true {
            
            performSegue(withIdentifier: "backToScoreboard", sender: selectedEvent)
       
        } //if backToScoreboard
            
            if eventPlayerVariable == true {
                    performSegue(withIdentifier: "toDonationStats", sender: selectedEvent)

                } //event segue
            
            
            if eventTotalsVariable == true {
                    performSegue(withIdentifier: "toTotalStatsView", sender: selectedEvent)

                } //eventTotalsVariable segue
       
         return true
    }  //shouldSelectItemAt
    

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

    
    //delete swipe below
    /*
    
    // Add swipe delete function here
    override func collectionView(_ collectionView: UICollectionView, commit editingStyle: UICollectionViewCell.DragState, forRowAt indexPath: IndexPath) {
    
        if editingStyle == .delete {
       
      //  if editingStyle == UITableViewCell.EditingStyle.delete {
            

            // verify with user to delete player
            let dialogMessage = UIAlertController(title: "Confirm", message: "Are you sure you want to delete this player?", preferredStyle: .alert)
            
            // Create OK button with action handler
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
               // print("Ok button tapped")
                deletePlayer()
                
            })  // UIAlertAction ok
            
            // Create Cancel button with action handlder
            let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
               // print("Cancel button tapped")
            } //UIAlertAction cancel
            
            //Add OK and Cancel button to dialog message
            dialogMessage.addAction(ok)
            dialogMessage.addAction(cancel)
            
            // Present dialog message to user
            self.present(dialogMessage, animated: true, completion: nil)
           
            // delete player **************
          func deletePlayer() {
              
          let teamN = team
          print("teamN in swipe delete: ", teamN)
          
            let playerN = resultsArray.rosterArray[indexPath.row]
              
          //  let playerN = resultsArray[indexPath.row] as! String
            
              print("playerN in swipe delete: ", playerN)
          
          
          let recordTeam = playerSearch.queryPlayer(pName: playerN, team: teamN)
          
          playerID = recordTeam.playID

         // print("playerID in delete: ", playerID)
          

          CKContainer.default().publicCloudDatabase.delete(withRecordID: playerID) {(recordID, error) in
             
              //NSLog("OK error")
              
           //  } { record, error in
              DispatchQueue.main.async {
                 if error == nil {
                      
                  } else {
                     let ac = UIAlertController(title: "Error", message: "There was a problem submitting your data \(error!.localizedDescription)", preferredStyle: .alert)
                     ac.addAction(UIAlertAction(title: "OK", style: .default))
                    //  self.persent(ac, animated: true)
                  }  // else
                  
            } //if error
           } // DispatchQueue

            resultsArray.rosterArray.remove(at: indexPath.row)
            // resultsArray.remove(at: indexPath.row)
              tableView.deleteRows(at: [indexPath], with: .fade)
              
              
          var textMessDelete = playerN
          
          textMessDelete.append(" removed from ")
          
          textMessDelete.append(teamN)
          
         print("textMessDelete: ", textMessDelete)
          

        //  messageTextView.text = textMessDelete
         
         let dialogMessage = UIAlertController(title: "Player Removed", message: textMessDelete, preferredStyle: .alert)
         
         // Create OK button with action handler
         let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
             print("Ok button tapped")
          })
         
              
         //Add OK button to a dialog message
         dialogMessage.addAction(ok)

         // Present Alert to
         self.present(dialogMessage, animated: true, completion: nil)

              
              } // func deletePlayer swipe
            
    
    */   // delete swipe above
    
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        
        if segue.identifier == "toEventsMgmt" {
          
                    print("toEventsMgmt Segue")
             
                    let vcEvents = segue.destination as! UINavigationController
                   
                    let vcMgmt = vcEvents.viewControllers.first as! EventsMgmtViewController
                    
                 //  vcScore.playerN = selectedPlayer
                    
                  //  vcScore.playerN = player
                    
                  //  print("vcScore.playerN: ", vcScore.playerN)
                    
             
            print("vcMgmt.team ", team)
            
                vcMgmt.title = self.team
                vcMgmt.name = self.team
            

                    
                } // to EventsMgmtController
          
         
        if segue.identifier == "toPlayerList" {
          
                    print("toPlayerList Segue")
             
                    let vcEvents = segue.destination as! UINavigationController
                   
                    let vcMgmt = vcEvents.viewControllers.first as! TeamTableViewTableViewController
                    
                 //  vcScore.playerN = selectedPlayer
                    
                  //  vcScore.playerN = player
                    
                  //  print("vcScore.playerN: ", vcScore.playerN)
                    
                    
            
          //  var eventTitle = team
        
       // eventTitle.append(" ")
       // eventTitle.append(eventN)
            let eventTitle = eventN
        
        print("eventTitle: ", eventTitle)
        print("vcMgmt.team ", vcMgmt.team)
        print("eventN: ", eventN)
            
            let eventVar: Bool = true
                
            vcMgmt.title = eventTitle
            vcMgmt.team = self.team
            vcMgmt.eventVariable = eventVar
            vcMgmt.eventN = self.eventN
            vcMgmt.eventDate = eventD

                    
                } // toPlayerList
        
        
        if segue.identifier == "backToScoreboard" {
          
                    print("backToScoreboard Segue")
             
                    let vcScore = segue.destination as! UINavigationController
                   
                    let vcMgmt = vcScore.viewControllers.first as! ScoreViewController
                    
                
          // Retrieve score from donation DB
            
            let donationValues = updateDonationsTotals.querySponsorWithShots(tName: team, pName: playerN, eDate: eventD)
            
               
                let totalAttempt = donationValues.totAttempt
                let totalMake = donationValues.totMake
            
                let totalMiss = totalAttempt - totalMake
            
            
        //    var eventTitle = team
        /*
        eventTitle.append(" ")
        eventTitle.append(eventN)
        
        print("eventTitle: ", eventTitle)
        print("vcMgmt.team ", vcMgmt.team)
        print("eventN: ", eventN)
        */
            vcMgmt.title = self.team
            vcMgmt.team = self.team
            vcMgmt.eventN = self.eventN
            vcMgmt.eventDate = eventD
            vcMgmt.playerN = self.playerN
            vcMgmt.eMake = String(totalMake)
            vcMgmt.eMiss = String(totalMiss)
            vcMgmt.eventSwitch = true

        
        } //backToScoreboard
        
            
        if segue.identifier == "toDonationStats" {
          
                    print("toDonationStats Segue")
             
                    let vcEvents = segue.destination as! UINavigationController
                   
                    let vcMgmt = vcEvents.viewControllers.first as! DonationStatsCollectionViewController
                    
                 //  vcScore.playerN = selectedPlayer
                    
                  //  vcScore.playerN = player
                    
                  //  print("vcScore.playerN: ", vcScore.playerN)
                    
             
         //   print("vcMgmt.team ", team)
            
            //var Title = team
            //Title.append(" ")
            //Title.append(eventN)
            let Title = eventN
            
                vcMgmt.title = Title
                vcMgmt.team = self.team
                vcMgmt.eventName = self.eventN
                vcMgmt.eDate = self.eventD
                vcMgmt.eventPlayerVariable = eventPlayerVariable
                vcMgmt.donationVariable = donationVariable
                    
                } // toDonationStats
          
        
        
        if segue.identifier == "toTotalStatsView" {
          
                    print("toTotalStatsView Segue")
             
                    let vcEvents = segue.destination as! UINavigationController
                   
                    let vcMgmt = vcEvents.viewControllers.first as! TotalStatsViewController
                    
                
            let Title = eventN
            
                vcMgmt.title = Title
                vcMgmt.team = self.team
                vcMgmt.eventName = self.eventN
                vcMgmt.eDate = self.eventD
                vcMgmt.eventTotalsVariable = eventTotalsVariable
              //  vcMgmt.donationVariable = donationVariable
                    
                } // toTotalStatsView
          
        
        } // prepare func
    
    
    
    @IBAction func unwindEventsMgmtCancel(segue: UIStoryboardSegue) {
         
   
         print("unwind from EventsMgmt")
         
         print("team name in unwindEventsMgmt: ", team)
      
    resultsArray = manager.eventsQuery(tName: team)
        
     
     // DispatchQueue.main.async {
        
        //Use this
    self.collectionView.reloadData()
      
    // }  // DispatchQueue
     
    }  // UIStoryboardSegue  unwindPlayerManagementCancel

    
    
    @IBAction func unwindTeamTableViewTableViewControllerCancel(segue:UIStoryboardSegue) {
       }
    
    
    /*
    @IBAction func unwindSponsorListCollectionViewController(segue:UIStoryboardSegue) {
        }
    */
    
    @IBAction func unwindDonationStatsCollectionViewController(segue:UIStoryboardSegue) {
        }
    
    
    @IBAction func unwindTotalStatsViewController(segue:UIStoryboardSegue) {
        }
    
    
    
}  // EventsCollectionViewController
