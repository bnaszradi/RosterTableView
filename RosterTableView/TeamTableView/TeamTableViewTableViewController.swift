//
//  TeamTableViewTableViewController.swift
//  RosterTableView
//
//  Created by Brian Naszradi on 12/26/20.
//

import UIKit
import CloudKit


class TeamTableViewTableViewController: UITableViewController {

   
    var team: String = ""
    
    var player: String = ""
    
    var selectedPlayer: String = ""
    
    var playerID: CKRecord.ID = CKRecord.ID()
    
    // set variable for ScoreViewController or EventsCollectionViewController segues
    var eventVariable: Bool = false
    
    var playerVariable: Bool = false
    
    var playerEventsVariable: Bool = false
    
    var eventN: String = ""
    
    var eventDate: Date = Date()
    
  let teamDataLoad = TeamDataLoad()
    
  let updateTeamTotals = UpdateTeamTotals()
    
  let PlayerCheck = TeamPlayerCheck()
    
  let dispatchGroup = DispatchGroup()
    
  // var rosterResultsArray = [] as Array<String>
    
    var rosterResultsArray: Array<String> = ["Loading roster..."]
    
  // var rosterPicResultsArray = [] as Array<CKAsset>
    
   // let samplePic: CKAsset = adsflajfaf
    
    var rosterPicResultsArray: Array<CKAsset> = []
    
  
       
   /*
    var queryResults = QResults() {
        
        didSet {
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
            print("reloadData")
            print("rosterResultsArray: ", self.rosterResultsArray as Any)
        } // dispatch
        
        } // didSet
    } // qResults
   
    */
 
    override func viewDidLoad() {
       // super.viewDidLoad()
        
        super.viewDidLoad()
        tableView.dataSource = self
       
        teamDataLoad.rosterPicQuery(tName: team, completion: { qResults in
            
            DispatchQueue.main.async {
                
           // self.queryResults = qResults
        
            
                self.rosterResultsArray = qResults.rosterArray
                self.rosterPicResultsArray = qResults.rosterPicArray
                
                print("# in rosterResultsArray: ", self.rosterResultsArray.count as Any)
                print("rosterResultsArray: ", self.rosterResultsArray as Any)
                print("# in rosterPicResultsArray: ", self.rosterPicResultsArray.count as Any)
                print("rosterPicResultsArray: ", self.rosterPicResultsArray as Any)
                
               self.tableView.reloadData()
               print("reloadData")
                print("rosterResultsArray after reloadData: ", self.rosterResultsArray as Any)
                
                
            } //DispatchQueue
           
    
            
        } ) // completion
            
       
            
        
    } //viewdidLoad

    
        
  // lazy var resultsArray =  teamDataLoad.rosterPicQuery(tName: team)
    
   
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }  //numberOfSections

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        // let rosterLength = resultsArray.count
        
       // let rosterLength = resultsArray.rosterArray.count
        
      let rosterLength = rosterResultsArray.count
       
        
        print("rosterLength: ", rosterLength)
        
      return rosterLength
    }  //numberOfRowsInSection

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = UITableViewCell()
        
       // player = resultsArray.rosterArray[indexPath.row]
        player = self.rosterResultsArray[indexPath.row]
        print("rosterResultsArray in cellForRowAt: ", player)
        
        cell.textLabel?.text = player
        
        if rosterPicResultsArray.count > 0 {
      
       let photoPic = rosterPicResultsArray[indexPath.row]
        
       let imageData = NSData(contentsOf: photoPic.fileURL!)
       // print("imageData: ", imageData as Any)
        
        if let image = UIImage(data: imageData! as Data) {
        
        cell.imageView?.image = image
        
        } //if image
        } // if rosterPicArray > 0
         
        return cell
        
    }  //tableView func
        
  
    
    func locationItem(at index:IndexPath) -> String {
        
        rosterResultsArray[index.item]
       
    } //locationItem func
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      // Runs but doesn't select correct cell
      //  let selectedPlayer = UITableViewCell()
        
        let selectedPlayer = locationItem(at: indexPath)
      print("selectedPlayer: ", selectedPlayer)
      print("playerVariable: ", playerVariable)
      print("eventVariable: ", eventVariable)
      print("playerEventsVariable: ", playerEventsVariable)
        
        // Add if conditions for segues
        
        if playerVariable == true {
        
        performSegue(withIdentifier: "toPlayer", sender: selectedPlayer)
          
       
        } // if playerVariable == true
            
            if eventVariable == true {
          
            performSegue(withIdentifier: "toSponsorList", sender: selectedPlayer)
            print("event = true, segue toSponsorList")
            
        } //if eventVariable == true
        
        
        if playerEventsVariable == true {
      
        performSegue(withIdentifier: "toPlayerEvents", sender: selectedPlayer)
        
    } //if playerEventsVariable == true
        
        
        
    } // tableView func didSelectRowAt
    

    
    // Add swipe delete function here
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    
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
          
          //  let playerN = resultsArray.rosterArray[indexPath.row]
              let playerN = rosterResultsArray[indexPath.row]
              
          //  let playerN = resultsArray[indexPath.row] as! String
            
              print("playerN in swipe delete: ", playerN)
          
          
       //   let recordTeam = updateTeamTotals.queryPlayer(pName: playerN, team: teamN)
              
        updateTeamTotals.queryPlayer(pName: playerN, team: teamN, completion: { qResults in
            
                  DispatchQueue.main.async {
                      
                
                self.playerID = qResults.playID
                  
                print("playerID: ", self.playerID)
                  
                      
                

            print("playerID in delete func: ", self.playerID)
          

        CKContainer.default().publicCloudDatabase.delete(withRecordID: self.playerID) {(recordID, error) in
             
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

           // resultsArray.rosterArray.remove(at: indexPath.row)
            self.rosterResultsArray.remove(at: indexPath.row)
              
            // resultsArray.remove(at: indexPath.row)
              tableView.deleteRows(at: [indexPath], with: .fade)
              
              
          var textMessDelete = playerN
          
          textMessDelete.append(" removed from ")
          
          textMessDelete.append(teamN)
          
         print("textMessDelete: ", textMessDelete)
          
         let dialogMessage = UIAlertController(title: "Player Removed", message: textMessDelete, preferredStyle: .alert)
         
         // Create OK button with action handler
         let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
             print("Ok button tapped")
          })
         
              
         //Add OK button to a dialog message
         dialogMessage.addAction(ok)

         // Present Alert to
         self.present(dialogMessage, animated: true, completion: nil)

                  } //DispatchQueue
             
          }  //Completionhandler
            
        ) //updateTeamTotalsqueryPlayer
              
        } // func deletePlayer
            
            
 
    } // Swipe
        
    
    } // override func tableview for delete
    
   
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        
        
        if segue.identifier == "toPlayerMgmt" {
          
                    print("toPlayerMgmt Segue")
             //   if let selectedPlayer = sender as? String {
               
                    let vcRoster = segue.destination as! UINavigationController
                   
                    let vcScore = vcRoster.viewControllers.first as! PlayerManagement
                    
                 //  vcScore.playerN = selectedPlayer
                    
                  //  vcScore.playerN = player
                    
                  //  print("vcScore.playerN: ", vcScore.playerN)
                    
                print("vcScore.team ", vcScore.name)
                
                vcScore.title = self.team
                vcScore.name = self.team

           //     } // SelectedPlayer
             //   }   // "toPlayerMgmt segue PlayerManagement
            
            } //toPlayerMgmt
        
           if segue.identifier == "toPlayer" {
               
              //  if segue.destination is ScoreViewController {
                    
                    print("toPlayer Segue")
                    
                    if let selectedPlayer = sender as? String {
                   
                        let vcRoster = segue.destination as! UINavigationController
                       
                        let vcScore = vcRoster.viewControllers.first as! ScoreViewController
                        
                       vcScore.playerN = selectedPlayer
                        
                      //  vcScore.playerN = player
                        
                        print("vcScore.playerN: ", vcScore.playerN)
                        
                        print("vcScore.team ", vcScore.team)
                    
                    vcScore.title = self.team
                    vcScore.team = self.team
                    
                    } // if selected player
                    }  // segue toPlayer
            
            if segue.identifier == "toSponsorList" {
                    
                                    print("toSponsorList")
                             
            if let selectedPlayer = sender as? String {
            let vcRoster = segue.destination as! UINavigationController
                                   
            let vcScore = vcRoster.viewControllers.first as! SponsorListViewController
                                    
            //  vcScore.playerN = selectedPlayer
                                    
            //  vcScore.playerN = player
                                    
            //  print("vcScore.playerN: ", vcScore.playerN)
                                    
                                
                   //     var eventTitle = team
                    
                   // eventTitle.append(",")
                   //     eventTitle.append(selectedPlayer)
                    //    eventTitle.append("-")
                    
                let eventTitle = selectedPlayer
                  //  eventTitle.append(" ")
                  //  eventTitle.append(eventN)
                 //  let eventTitle = selectedPlayer
                        
                    print("eventTitle in TVC: ", eventTitle)
                        
                        
                            vcScore.title = eventTitle
                            vcScore.team = self.team
                            vcScore.playerName = selectedPlayer
                        vcScore.eventName = eventN
                        vcScore.eventDate = eventDate
                            
                        print("team in TVC: ", vcScore.team)
                      //  print("selectedPlayer in TVC: ", selectedPlayer)
                        print("playerName in TVC: ", vcScore.playerName)
                        print("eventName in TVC: ", vcScore.eventName)
                        print("eventDate in TVC: ", eventDate)
                           

                    } // if selected player
                    } //toSponsorList segue
                        
             
        if segue.identifier == "toPlayerEvents" {
            
           //  if segue.destination is ScoreViewController {
                 
                 print("toPlayerEvents Segue")
                 
                 if let selectedPlayer = sender as? String {
                
                     let vcRoster = segue.destination as! UINavigationController
                    
                     let vcScore = vcRoster.viewControllers.first as! PlayerEventsCollectionViewController
                     
                    vcScore.playerN = selectedPlayer
                     
                   //  vcScore.playerN = player
                     
                print("vcScore.playerN: ", vcScore.playerN)
                     
                print("vcScore.team: ", vcScore.self.team)
                 
                 vcScore.title = self.team
                 vcScore.team = self.team
                 
                 } // if selected player
                 }  // segue toPlayer
       
        
                        
                    
          
          
         
            
        } // prepare func
    
    
    @IBAction func unwindScoreViewControllerCancel(segue: UIStoryboardSegue) {
        
        print("unwind from ScoreViewController")
        
     }  // UIStoryboardSegue
    
    
    
    
   
   @IBAction func unwindPlayerManagementCancel(segue: UIStoryboardSegue) {
        
  
        print("unwind from PlayerManagement")
        
        print("team name in unwindPlayerManagement: ", team)
     
    
    dispatchGroup.notify(queue: .main) { [self] in
     
        dispatchGroup.enter()
    
   // resultsArray = teamDataLoad.rosterPicQuery(tName: team)
  /*
        var counter: Int = 0
        while counter <= 700000000 {
            counter += 1
        } // while loop
      */
        
    teamDataLoad.rosterPicQuery(tName: team, completion: { qResults in
            
            DispatchQueue.main.async {
                
           // self.queryResults = qResults
        
            
                self.rosterResultsArray = qResults.rosterArray
                self.rosterPicResultsArray = qResults.rosterPicArray
                
                print("# in rosterResultsArray: ", self.rosterResultsArray.count as Any)
                print("rosterResultsArray: ", self.rosterResultsArray as Any)
                print("# in rosterPicResultsArray: ", self.rosterPicResultsArray.count as Any)
                print("rosterPicResultsArray: ", self.rosterPicResultsArray as Any)
                
               self.tableView.reloadData()
               print("reloadData")
                print("rosterResultsArray after reloadData: ", self.rosterResultsArray as Any)
                
            } //DispatchQueue
           
    
        } ) // completion
        
        
        
   // self.tableView.reloadData()
        
        dispatchGroup.leave()
        
    } // dispatchGroup.notify
     
  
    
   }  // UIStoryboardSegue  unwindPlayerManagementCancel
    
    @IBAction func unwindSponsorListControllerCancel(segue: UIStoryboardSegue) {
        
        print("unwind from SponsorListController")
        
     }  // UIStoryboardSegue
    
    
    @IBAction func unwindPlayerEventsCollectionViewControllerCancel(segue: UIStoryboardSegue) {
        
        print("unwind from PlayerEventsCollectionViewController")
        
     }  // UIStoryboardSegue
    
    
    
    
    
 }   // class TeamTableViewController


