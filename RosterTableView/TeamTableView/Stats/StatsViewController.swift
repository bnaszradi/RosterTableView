//
//  StatsViewController.swift
//  RosterTableView
//
//  Created by Brian Naszradi on 1/21/21.
//

import UIKit
import CloudKit

class StatsViewController: UIViewController {

    var tName: String = ""
   // var playName: String = ""
    
    let teamCheck = TeamPlayerCheck()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tabBar = tabBarController as! InitialTabBarViewController
       // teamName.text = String(describing: tabBar.teamName)
        
        let name =  String(describing: tabBar.teamName)
        
        // Remove any blank characters at the end of the team name
        var teamArray = Array(name)
        
        print("teamArray: ", teamArray)
        
       var teamNumChar = teamArray.count
       print("teamNumChar: ", teamNumChar)
        
       var extraTeamCharLessOne = teamNumChar - 1
        print("extraTeamCharLessOne: ", extraTeamCharLessOne)
        
        while teamArray[extraTeamCharLessOne] == " " {
            
            teamArray.remove(at: extraTeamCharLessOne)
            print("teamArray after remove end blank character: ", teamArray)
            
           teamNumChar = teamArray.count
           print("teamNumChar: ", teamNumChar)
            
        extraTeamCharLessOne = teamNumChar - 1
        print("extraTeamCharLessOne: ", extraTeamCharLessOne)
            
        } // while extraTeamCharLessOne
        
        teamName.text = String(teamArray)
       
        print("teamName in StatsViewController viewDidLoad: ", teamName.text)
        
      //  print("tname after parsing blank characters from end: ", teamName.text)
        
        // This code hides the navigation bar in the navigation controller
        super.viewDidLoad()
            self.navigationController?.isNavigationBarHidden = true
   
    }  // Override func
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            view.endEditing(true)
          super.touchesBegan(touches, with: event)
          }  // touchesBegan
    
    
   let container = CKContainer(identifier: "ICloud.Brian-Naszradi.RosterTableView")
    
    @IBOutlet weak var teamName: UILabel!
    
    
    @IBAction func viewStatsButton(_ sender: Any) {
        
        self.tName = teamName.text!
        //self.playName = playerName.text!
        
        
        performSegue(withIdentifier: "statsSegue", sender: self)
       
       // print("playName in StatsViewController button: ", playName)
        
    }  // viewStatsButton
    
    
    @IBAction func getEvents(_ sender: UIButton) {
    
        tName = teamName.text!
        //self.playName = playerName.text!
        
        print("tName in getEvents: ", tName)
       
        
       performSegue(withIdentifier: "toEvents", sender: self)
    
    } //getEvents
    
    
    @IBAction func eventPlayerStats(_ sender: UIButton) {
        
        tName = teamName.text!
        
        performSegue(withIdentifier: "toEventsList", sender: self)
        
        
    } // eventPlayerStats
    
    
    
    @IBAction func eventTotalStats(_ sender: UIButton) {
        
        tName = teamName.text!
        
        performSegue(withIdentifier: "toEventsView", sender: self)
        
        
    } // eventTotalStats
    
    
    @IBAction func playerEvents(_ sender: UIButton) {
        
        tName = teamName.text!
        
        print("tName in playerEvents button: ", tName)
        
        // Change this segue for the new collectionView
        performSegue(withIdentifier: "toPlayerRoster", sender: self)
        
    } // playerEvents
    
   
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        tName = teamName.text!
        
        if segue.identifier == "statsSegue" {
          
        print("statsSegue Segue")
             
        
        let viewCont = segue.destination as! UINavigationController
        let collectionVC = viewCont.viewControllers.first as! StatsCollectionViewController
        
       // print("playName in StatsViewController prepare: ", playName)
        
       // collectionVC.player = self.playName
        collectionVC.team = self.tName
        collectionVC.title = self.tName
        
        
        } // statsSegue
        
        if segue.identifier == "toEvents" {
          
        print("toEvents Segue")
             
        let viewCont = segue.destination as! UINavigationController
        let collectionVC = viewCont.viewControllers.first as! EventsCollectionViewController
        
        
       // collectionVC.player = self.playName
        print("tName in StatsViewController: ", tName)
      //  collectionVC.team = tName
            let donVariable: Bool = true
            
        var Title = tName
        Title.append(" Events")
        
        collectionVC.team = tName
        collectionVC.title = Title
        collectionVC.donationVariable = donVariable
        
        } // toEvents segue
        
        
        if segue.identifier == "toEventsList" {
          
        print("toEventsList Segue")
             
        let viewCont = segue.destination as! UINavigationController
        let collectionVC = viewCont.viewControllers.first as! EventsCollectionViewController
        
        
       // collectionVC.player = self.playName
        print("tName in StatsViewController: ", tName)
      //  collectionVC.team = tName
        let eventPlayerVariable: Bool = true
            
        var Title = tName
        Title.append(" Events")
        
        collectionVC.team = tName
        collectionVC.title = Title
        collectionVC.eventPlayerVariable = eventPlayerVariable
        
        } // toEventsList segue
       
        
        if segue.identifier == "toEventsView" {
          
        print("toEventsView Segue")
             
        let viewCont = segue.destination as! UINavigationController
        let collectionVC = viewCont.viewControllers.first as! EventsCollectionViewController
        
        
       // collectionVC.player = self.playName
        print("tName in StatsViewController: ", tName)
      //  collectionVC.team = tName
        let eventTotalsVariable: Bool = true
            
        var Title = tName
        Title.append(" Events")
        
        collectionVC.team = tName
        collectionVC.title = Title
        collectionVC.eventTotalsVariable = eventTotalsVariable
        
        } // toEventsView segue
       
        
        if segue.identifier == "toPlayerRoster" {
          
        print("toPlayerRoster Segue")
             
        let viewCont = segue.destination as! UINavigationController
        let collectionVC = viewCont.viewControllers.first as! TeamTableViewTableViewController
        
        let playerEventsVar: Bool = true
             
            
       // collectionVC.player = self.playName
        print("tName in StatsViewController Prepare: ", tName)
      //  collectionVC.team = tName
       // let eventTotalsVariable: Bool = true
            
           
        let Title = tName
        //  let Title = "Player Events"
       // Title.append(" Events")
        
        collectionVC.team = tName
        print("collectionVC.team: ", collectionVC.team)
            
        collectionVC.title = Title
        collectionVC.playerEventsVariable = playerEventsVar
       // collectionVC.eventTotalsVariable = eventTotalsVariable
        
        } // toPlayerEvents segue
       
        
        
        } // prepare func
    
    
   @IBAction func unwindStatsCollectionViewControllerCancel(segue: UIStoryboardSegue) {
    
   }  // UIStoryboardSegue
    
    
    @IBAction func unwindBackToStatsViewController(segue: UIStoryboardSegue) {
        
        teamName.text = tName
        
     }  // UIStoryboardSegue
    
    
    @IBAction func unwindPlayerStatsViewControllerDone(segue: UIStoryboardSegue) {
        
        teamName.text = tName
        
     }  // UIStoryboardSegue
    
    /*
    @IBAction func unwindEventsCollectionViewControllerCancel(segue: UIStoryboardSegue) {
     
    }  // UIStoryboardSegue
    */
    
    @IBAction func unwindBacktoRosterview (segue: UIStoryboardSegue) {
        
        print("unwind from eventsCollectionViewController")
        
        teamName.text = tName
        
        
     }  // UIStoryboardSegue
    
    
    
    
    
    @IBAction func unwindSponsorStatsCollectionViewControllerDone(segue: UIStoryboardSegue) {
     
    }  // UIStoryboardSegue
    
    
    @IBAction func unwindEventPlayerStatsCollectionViewControllerDone(segue: UIStoryboardSegue) {
     
    }  // UIStoryboardSegue
    
    
    
    @IBAction func unwindPlayerEventsCollectionViewControllerCancel(segue: UIStoryboardSegue) {
     
    }  // UIStoryboardSegue
     
    
    @IBAction func unwindTeamTableViewTableViewControllerCancel(segue: UIStoryboardSegue) {
     
    }  // UIStoryboardSegue
    
    
    @IBAction func unwindPlayerEventsCollectionViewControllerDone(segue: UIStoryboardSegue) {
        
        teamName.text = tName
        
     }  // UIStoryboardSegue
    
    
    
   /*
    @IBAction func unwindDonationStatsCollectionViewControllerCancel(segue: UIStoryboardSegue) {
     
    }  // UIStoryboardSegue
    */
    
    
}  // StatsViewController
