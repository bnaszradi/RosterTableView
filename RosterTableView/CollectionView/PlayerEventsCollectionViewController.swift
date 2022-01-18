//
//  PlayerEventsCollectionViewController.swift
//  RosterTableView
//
//  Created by Brian Naszradi on 12/26/21.
//

import UIKit
import CloudKit

private let reuseIdentifier = "Cell"

class PlayerEventsCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    
    let container = CloudKit.CKContainer(identifier: "ICloud.Brian-Naszradi.RosterTableView")
     
    
    let updateDonationTotals = UpdateDonationsTotals()
    let eventsList = EventsList()
    
    var team: String = ""
    var playerN: String = ""
    var eventName: String = ""
    var eDate: Date = Date()
    
    var playerArray = [] as Array<String>
    var eventArray = [] as Array<String>
    var totAttemptArray = [] as Array<Int>
    var totMakeArray = [] as Array<Int>
    var totPerShotArray = [] as Array<Double>
    var totFlatDonArray = [] as Array<Double>
    var totalDonationArray = [] as Array<Double>
    var eventDateArray = [] as Array<Date>
    
    
    var selectedEvent: String = ""
    var selectedDateEvent: Date = Date()
    
    /*
    var resultsEventArray: Array<String> = []
    var resultsDateArray: Array<Date> = []
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()

       // collectionView.dataSource = self
        
      //  self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        
        print("team before updateDonationTotals.queryDonations: ", team)
        
        updateDonationTotals.queryDonations(team: team, player: playerN, completion: { qqueryDonations in
            
            DispatchQueue.main.async {
                
          //  self.playerArray = qqueryDonations.playerArray
               
           // print("playerArray: ", self.playerArray)
            
            self.eventArray = qqueryDonations.eventArray
            print("eventArray: ", self.eventArray)
                
            self.totAttemptArray = qqueryDonations.totAttemptArray
                
            self.totMakeArray = qqueryDonations.totMakeArray
                
            self.totPerShotArray = qqueryDonations.totPerShotArray
                
            self.totFlatDonArray = qqueryDonations.totFlatDonArray
                
            self.totalDonationArray = qqueryDonations.totalDonationArray
                
            self.eventDateArray = qqueryDonations.eventDateArray
                
           self.collectionView.reloadData()
            print("reloadData")
                 
                
            }  // DispatchQueue
            
           
            
        } ) // completionhandler updateDonationTotals.queryDonationWithShots
       
        
        
    } // viewDidLoad

    
    
    @IBOutlet weak var PlayerEventsCollectionViewFlowViewController: UICollectionViewFlowLayout!
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let height = view.frame.size.height
        let width = view.frame.size.width
        
        return CGSize(width: width, height: height * 0.15)
        
    } // CollectionViewLayout
    
    
    
    
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
       
        
      //  var headerView = PlayerEventsCollectionReusableView()
       
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! PlayerEventsCollectionReusableView
        
       header.playerName.text = playerN
       // let player = String(self.playerArray[indexPath.row])
     
       //   header.playerName.text = String(self.playerArray[indexPath.row])
            
       //     header.playerName.text = player
        
       // headerView = header
            
       
        //} // if let header
            
     
        return header
        
       
    } // collectionView for viewForSupplementary
    
    
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
       
       let numberSections = playerArray.count
     
        print("numberSections: ", numberSections)
        
      //  return numberSections
        return 1
        
    } // numberOfSections


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let numberEvents = eventArray.count
        print("numberEvents: ", numberEvents)
        
        // Need to figure out this value?
        return numberEvents
        
    } // numberOfItemsInSection

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        var playerCell = PlayerEventsCollectionViewCell()
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "playerEventsCell", for: indexPath) as? PlayerEventsCollectionViewCell {
        
       // cell.event.text = "Event"
        cell.event.text = String(self.eventArray[indexPath.row])
          
        let dateFormatter = DateFormatter()
                    
        dateFormatter.dateStyle = .short
            //  dateFormatter.dateFormat = "EEEE MMM d, yyyy"
            // dateFormatter.timeStyle = .short
                    
        let eventDateValue =  dateFormatter.string(from: self.eventDateArray[indexPath.row])
                
        cell.eventD.text = eventDateValue
      
        cell.total.text = String(self.totalDonationArray[indexPath.row])
       
        cell.attempts.text = String(self.totAttemptArray[indexPath.row])
        
        cell.makes.text = String(self.totMakeArray[indexPath.row])
        
        cell.perShot.text = String(self.totPerShotArray[indexPath.row])
                                   
        cell.flat.text = String(self.totFlatDonArray[indexPath.row])
            

        playerCell = cell
            
            
        } // if cell
        
        return playerCell
        
    } // collectionView cellforat

    
    // Code for selecting cell
    func eventItem(at index:IndexPath) -> String {
       
        eventArray[index.item]
        
    } //eventItem func
    
    func eventDateItem(at index:IndexPath) -> Date {
       
        eventDateArray[index.item]
        
    } //eventItem func
    
    
    
    // Select Event to view player shot stats
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        
        selectedEvent = eventItem(at: indexPath)
        print("selectedEvent: ", selectedEvent)
    
        selectedDateEvent = eventDateItem(at: indexPath)
        print("selectedDateEvent: ", selectedDateEvent)
        
       performSegue(withIdentifier: "toEventPlayerShots", sender: selectedEvent)
        
        
        return true
        
        
    } // shouldSelectItemsAt
    
    
    
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

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        
        if segue.identifier == "toEventPlayerShots" {
            
            print("segue toEventPlayerShots started")
            
        
        //   if let selectedEvent = sender as? String {
        
            let vcTeam = segue.destination as! UINavigationController
               
            let vcStats = vcTeam.viewControllers.first as! EventPlayerStatsCollectionViewController
                
               
             //   vcStats.eDate = self.resultsDateArray[0]
             //   print("vcStats.eDate: ", vcStats.eDate)
               
           // let Title = self.selectedEvent
            let Title = self.team
            print("Title: ", Title)
            vcStats.title = Title
            print("vcStats.title: ", vcStats.title!)
                
            vcStats.player = self.playerN
            print("vcStats.player: ", vcStats.player)
               
            vcStats.team = self.team
            print("vcStats.team: ", vcStats.team)
                
             //  vcStats.eventName = self.eventName
            vcStats.eventName = self.selectedEvent
             
               vcStats.eDate = self.selectedDateEvent
                print("vcStats.eDate: ", vcStats.eDate)
                    
      //  } // selectedEvent
            
        } // if toEventPlayerStats
        
        
        } // prepare func
    
   
    @IBAction func unwindEventPlayerStatsCollectionViewControllerCancel(segue: UIStoryboardSegue) {
     
    }  // UIStoryboardSegue
    
    
    
    
}   // PlayerEventsCollecttionViewController
