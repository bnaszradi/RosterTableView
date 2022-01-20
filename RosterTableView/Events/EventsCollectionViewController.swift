//
//  EventsCollectionViewController.swift
//  RosterTableView
//
//  Created by Brian Naszradi on 6/13/21.
//

import UIKit
import CloudKit

private let reuseIdentifier = "Cell"

//class EventsCollectionViewController: UICollectionViewController {

class EventsCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout
{

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
    
    var eventSponsorVariable: Bool = false
    
   // let queryEvents = QueryEvents()
    let eventsList = EventsList()
    
    let updateDonationsTotals = UpdateDonationsTotals()
    
    var totalMiss: Int = 0
    var totalMake: Int = 0
    
   // var resultsEventArray: Array<String> = ["Loading roster..."]
    
    var resultsEventArray: Array<String> = []
    var resultsDateArray: Array<Date> = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
        // self.clearsSelectionOnViewWillAppear = false
        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
              
        
        eventsList.eventsQuery(tName: team, completion: { qEvents in
            
            DispatchQueue.main.async {
                
            self.resultsEventArray = qEvents.resultsNameArray
            print("resultsEventArray: ", self.resultsEventArray)
                
            self.resultsDateArray = qEvents.resultsDateArray
            print("resultsDateArray: ", self.resultsDateArray)
                
            self.collectionView.reloadData()
            print("reloadData")
             
            } // DispatchQueue
        
            } ) // CompletionHandler eventsList.eventsQuery
                

    } // viewDidLoad

    
    //   This doesn't change the cell size on minin iPad

    
    @IBOutlet weak var eventCollectionViewFlowLayout: UICollectionViewFlowLayout!
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let height = view.frame.size.height
        let width = view.frame.size.width
        
        return CGSize(width: width, height: height * 0.15)
        
        
    } // CollectionViewLayout
    
   
    
    
    
    
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath)
        return headerView
    } // collectionView for viewForSupplementary
    
   
    // Add Datasource
  //  lazy var resultsArray = eventsList.eventsQuery(tName: team)
   
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    } // numberOfSections


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
      //  let rosterLength = resultsArray.resultsNameArray.count
        
        let rosterLength = resultsEventArray.count
          
        
        return rosterLength
        
    } //numberOfItemsInSection

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        var eventsCell = EventsCollectionViewCell()
        
        if let eventCell = collectionView.dequeueReusableCell(withReuseIdentifier: "eventsCell", for: indexPath) as? EventsCollectionViewCell {
        
        
          //  eventCell.eventName.text = String(resultsArray.resultsNameArray[indexPath.row])
            
            eventCell.eventName.text = String(self.resultsEventArray[indexPath.row])
            
            let dateFormatter = DateFormatter()
            
            dateFormatter.dateStyle = .short
            dateFormatter.dateFormat = "EEEE MMM d, yyyy"
           // dateFormatter.timeStyle = .short
            
            
           // eventCell.eventDate.text = dateFormatter.string(from: resultsArray.resultsDateArray[indexPath.row])
        
    
           eventCell.eventDate.text =  dateFormatter.string(from: self.resultsDateArray[indexPath.row])
            
        
            //eventD = resultsArray.resultsDateArray[indexPath.row]
            
            
            eventsCell = eventCell
    
        } // eventCell
            
        return eventsCell
        
        
    }  // UICollectionViewCell

    
    // Go to Player Roster when event selected
   
    
    func locationName(at index:IndexPath) -> String {
       
      //  resultsArray.resultsNameArray[index.item]
       
        resultsEventArray[index.item]
        
        
        
    } //locationName func
    
    
    func locationDate(at index:IndexPath) -> Date {
       
      //  resultsArray.resultsDateArray[index.item]
       
        resultsDateArray[index.item]
        
    } //locationItem func

    

        override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
    
     
        let selectedEvent = locationName(at: indexPath)
        
        let selectedDate = locationDate(at: indexPath)
       
        print("selectedEvent in ECV: ", selectedEvent)
      
        eventN = selectedEvent
        
        eventD = selectedDate
        
        
        
        // Add condition to route to appropriate segue either toPlayerList or backToScoreboard or toDonationStats or TotalStats
        print("eventVariable: ", eventVariable)
        print("donationVariable: ", donationVariable)
        print("playerVariable: ", playerVariable)
        print("scoreboardVariable: ", scoreboardVariable)
        
        if eventVariable == true {
               
            
            
            performSegue(withIdentifier: "toEventMgmt", sender: selectedEvent)

            } //event segue
         
            
          
        if playerVariable == true {
            
           
            self.performSegue(withIdentifier: "toPlayerList", sender: selectedEvent)

                    
        } //if toPlayerList
        
            
            if eventSponsorVariable == true {
                
                performSegue(withIdentifier: "toPlayerList", sender: selectedEvent)
           
            } // if eventSponsorVariable
            
       
        if donationVariable == true {
            
            performSegue(withIdentifier: "toDonationStats", sender: selectedEvent)
            
        } // if toDonationStats
            
        
          
         if scoreboardVariable == true {
            
             print("team in backtoScoreboard segue: ", team)
             print("playerN in backtoScoreboard segue: ", playerN)
             print("eventD in backtoScoreboard segue: ", eventD)
            
            updateDonationsTotals.querySponsorWithShots(tName: team, pName: playerN, eDate: eventD, completion: { qSponsWithShots in
                 
               //  print("updateDonationsTotals.querySponsorWithShots in scoreboardVariable")
                
                DispatchQueue.main.async {
                     
             //   let donationValues = qSponsWithShots
                 
              //  let totalAttempt = donationValues.totAttempt
                let totalAttempt = qSponsWithShots.totAttempt
                    
            //    let totalMake = donationValues.totMake
                self.totalMake = qSponsWithShots.totMake
                print("totalMake in EventCollectionView segue backToScoreboard", self.totalMake)
             
                self.totalMiss = totalAttempt - self.totalMake
                print("totalMiss in EventCollectionView segue backToScoreboard", self.totalMiss)
                 
                    
            

               self.performSegue(withIdentifier: "backToScoreboard", sender: selectedEvent)
                    
                    
                 } // DispatchQueue completionhandler
                   
                
               } ) // Completionhandler updateDonationsTotals.querySponsorWithShots
        
             
       // performSegue(withIdentifier: "backToScoreboard", sender: selectedEvent)
       
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
                    
             
            print("vcMgmt.team in toEventsMgmt: ", team)
            
                vcMgmt.title = self.team
                vcMgmt.name = self.team
            

                    
                } // to EventsMgmtController
          
      
        if segue.identifier == "toPlayerList" {
          
        print("toPlayerList Segue in EventsCollectionView")
        print("playerVariable in toPlayerList segue: ", playerVariable)
             
        let vcEvents = segue.destination as! UINavigationController
                   
        let vcMgmt = vcEvents.viewControllers.first as! TeamTableViewTableViewController
                    
                 //  vcScore.playerN = selectedPlayer
                    
                  //  vcScore.playerN = player
                    
                  //  print("vcScore.playerN: ", vcScore.playerN)
                    
                    
            
          //  var eventTitle = team
        
       // eventTitle.append(" ")
       // eventTitle.append(eventN)
            var eventTitle = eventN
            eventTitle.append(" ")
            
            let dateFormatter = DateFormatter()
            
            dateFormatter.dateStyle = .short
          //  dateFormatter.dateFormat = "EEEE MMM d, yyyy"
           // dateFormatter.timeStyle = .short
            
           let eventDateTitle =  dateFormatter.string(from: eventD)
        eventTitle.append(eventDateTitle)
           
        
        print("eventTitle in toPlayerList: ", eventTitle)
        print("vcMgmt.team in toPlayerList: ", vcMgmt.team)
        print("eventN in toPlayerList: ", eventN)
            
       //     let eventVar: Bool = true
                
            vcMgmt.title = eventTitle
            vcMgmt.team = self.team
          //  vcMgmt.eventVariable = eventVar
            print("eventVariable in eventCV segue: ", eventVariable)
            vcMgmt.eventVariable = self.eventVariable
            vcMgmt.playerVariable = self.playerVariable
            vcMgmt.eventSponsorVariable = self.eventSponsorVariable
            
            vcMgmt.eventN = self.eventN
            vcMgmt.eventDate = eventD
            vcMgmt.eventSwitch = true
            

                    
                } // toPlayerList
        
        
       
    
        if segue.identifier == "backToScoreboard" {
          
        print("backToScoreboard Segue in EventsCollectionView")
             
           let vcScore = segue.destination as! UINavigationController
                   
            let vcSBMgmt = vcScore.viewControllers.first as! ScoreViewController
                    
                    
            vcSBMgmt.title = self.team
            vcSBMgmt.team = self.team
                    
            print("vcSBMgmt.team in backToScoreboard: ", vcSBMgmt.team)
            
            vcSBMgmt.eventN = self.eventN
            vcSBMgmt.eventDate = self.eventD
            vcSBMgmt.playerN = self.playerN
           
            print("totalMake in backToScoreboard segue: ", totalMake)
           vcSBMgmt.eMake = String(totalMake)
            
            print("totalMiss in backToScoreboard segue: ", totalMiss)
           vcSBMgmt.eMiss = String(totalMiss)
            
            vcSBMgmt.eventSwitch = true

                    
        } //backToScoreboard
        
            
        if segue.identifier == "toDonationStats" {
          
                    print("toDonationStats Segue")
             
                    let vcEvents = segue.destination as! UINavigationController
                   
                    let vcMgmt = vcEvents.viewControllers.first as! DonationStatsCollectionViewController
                    
                 //  vcScore.playerN = selectedPlayer
                    
                  //  vcScore.playerN = player
                    
                  //  print("vcScore.playerN: ", vcScore.playerN)
                    
             
         //   print("vcMgmt.team ", team)
            
            let Title = team
            
            
           // Code to include event name and date in title
            /*
            var Title = eventN
            
            Title.append(" ")
            
            let dateFormatter = DateFormatter()
            
            dateFormatter.dateStyle = .short
          //  dateFormatter.dateFormat = "EEEE MMM d, yyyy"
           // dateFormatter.timeStyle = .short
            
           let eventDateTitle =  dateFormatter.string(from: eventD)
           Title.append(eventDateTitle)
           */
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
                    
            let Title = self.team
            // This code displays the event name and date in the title
            /*
            var Title = eventN
            
            Title.append(" ")
            
            let dateFormatter = DateFormatter()
            
            dateFormatter.dateStyle = .short
          //  dateFormatter.dateFormat = "EEEE MMM d, yyyy"
           // dateFormatter.timeStyle = .short
            
           let eventDateTitle =  dateFormatter.string(from: eventD)
           Title.append(eventDateTitle)
           */
            
            
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
      
   // resultsArray = eventsList.eventsQuery(tName: team)
        
        
        //Query events and reload collectionview
        
        eventsList.eventsQuery(tName: team, completion: { qEvents in
            
            DispatchQueue.main.async {
                
            self.resultsEventArray = qEvents.resultsNameArray
            print("resultsEventArray: ", self.resultsEventArray)
                
            self.resultsDateArray = qEvents.resultsDateArray
            print("resultsDateArray: ", self.resultsDateArray)
                
            self.collectionView.reloadData()
            print("reloadData")
             
            } // DispatchQueue
        
            } ) // eventsList.eventsQuery
        
     
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
